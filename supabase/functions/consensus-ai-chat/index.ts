import "jsr:@supabase/functions-js/edge-runtime.d.ts";
import { createClient } from "npm:@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type, Authorization, X-Client-Info, Apikey",
};

interface VoteRequest {
  vote: "support" | "against" | "neutral";
  last_response: string;
  chat_history?: Array<{ role: string; content: string }>;
}

interface PromptRequest {
  prompt: string;
  chat_history: Array<{ role: string; content: string }>;
}

type ChatRequest = VoteRequest | PromptRequest;

function isVoteRequest(req: ChatRequest): req is VoteRequest {
  return "vote" in req;
}

Deno.serve(async (req: Request) => {
  if (req.method === "OPTIONS") {
    return new Response(null, {
      status: 200,
      headers: corsHeaders,
    });
  }

  try {
    const authHeader = req.headers.get("Authorization");
    if (!authHeader) {
      return new Response(
        JSON.stringify({ error: "Missing authorization header" }),
        {
          status: 401,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    const supabaseUrl = Deno.env.get("SUPABASE_URL")!;
    const supabaseServiceKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
    const openaiApiKey = Deno.env.get("OPENAI_API_KEY");

    if (!openaiApiKey) {
      return new Response(
        JSON.stringify({ error: "OpenAI API key not configured" }),
        {
          status: 500,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    const supabase = createClient(supabaseUrl, supabaseServiceKey, {
      global: {
        headers: { Authorization: authHeader },
      },
    });

    const { data: { user }, error: userError } = await supabase.auth.getUser();

    if (userError || !user) {
      return new Response(
        JSON.stringify({ error: "Unauthorized" }),
        {
          status: 401,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    const requestData: ChatRequest = await req.json();
    let chatHistory: Array<{ role: string; content: string }> = [];
    let userPrompt = "";

    if (isVoteRequest(requestData)) {
      const { vote, last_response, chat_history } = requestData;
      chatHistory = chat_history || [];

      if (vote === "support") {
        userPrompt = `The user supported your last response: "${last_response}". Acknowledge their support and ask what they would like to explore next or how you can help them further.`;
      } else if (vote === "against") {
        userPrompt = `The user was against your last response: "${last_response}". Apologize for not meeting their needs and offer to regenerate a better response or take a different approach. Ask them what specifically they would like changed.`;
      } else {
        userPrompt = `The user had a neutral reaction to your last response: "${last_response}". Ask for clarification on what they think and how you can better help them.`;
      }
    } else {
      userPrompt = requestData.prompt;
      chatHistory = requestData.chat_history || [];
    }

    const { data: settings, error: settingsError } = await supabase
      .from("user_settings")
      .select("selected_model")
      .eq("user_id", user.id)
      .maybeSingle();

    let selectedModel = "gpt-3.5-turbo";
    
    if (!settingsError && settings) {
      selectedModel = settings.selected_model === "gpt-5" ? "gpt-4" : "gpt-3.5-turbo";
    }

    const messages = [
      ...chatHistory,
      { role: "user", content: userPrompt },
    ];

    const openaiResponse = await fetch("https://api.openai.com/v1/chat/completions", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${openaiApiKey}`,
      },
      body: JSON.stringify({
        model: selectedModel,
        messages: messages,
        temperature: 0.7,
      }),
    });

    if (!openaiResponse.ok) {
      const errorData = await openaiResponse.text();
      return new Response(
        JSON.stringify({ error: "OpenAI API error", details: errorData }),
        {
          status: 500,
          headers: { ...corsHeaders, "Content-Type": "application/json" },
        }
      );
    }

    const openaiData = await openaiResponse.json();
    const aiResponse = openaiData.choices[0]?.message?.content || "I'm sorry, I couldn't generate a response.";

    return new Response(
      JSON.stringify({ 
        response: aiResponse,
        model: selectedModel,
      }),
      {
        status: 200,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({ error: error instanceof Error ? error.message : "Internal server error" }),
      {
        status: 500,
        headers: { ...corsHeaders, "Content-Type": "application/json" },
      }
    );
  }
});
