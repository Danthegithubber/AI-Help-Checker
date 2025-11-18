import React from "react";
import { Button } from "../../components/ui/button";

const features = [
  {
    icon: "/container-1.svg",
    title: "AI-Powered Analysis",
    description: "Advanced algorithms analyze your questions in seconds",
  },
  {
    icon: "/container.svg",
    title: "Accurate Results",
    description: "Get reliable feedback you can trust every time",
  },
  {
    icon: "/container-3.svg",
    title: "Instant Feedback",
    description: "No waiting around — receive results immediately",
  },
];

export const WelcomePage = (): JSX.Element => {
  return (
    <div className="flex flex-col min-h-screen max-w-md mx-auto items-center gap-5 bg-white px-8">
      <header className="w-full h-11">
        <img className="w-full h-full" alt="Status bar" src="/status-bar.svg" />
      </header>

      <main className="flex flex-col w-full items-center justify-center gap-8 pb-0 pt-0 px-0">
        <img
          className="w-24 h-24"
          alt="AI Help Checker Logo"
          src="/container-2.svg"
        />

        <section className="flex flex-col w-full items-start gap-3">
          <h1 className="w-full [font-family:'Arimo',Helvetica] font-normal text-neutral-950 text-3xl text-center tracking-[0] leading-9">
            AI Help Checker
          </h1>

          <p className="w-full [font-family:'Arimo',Helvetica] font-normal text-[#717182] text-base text-center tracking-[0] leading-6 px-5">
            Get instant, accurate feedback on your questions powered by advanced
            AI
          </p>
        </section>

        <section className="flex flex-col w-full items-start gap-6 pt-4">
          {features.map((feature, index) => (
            <article
              key={index}
              className="flex h-[68.01px] items-center gap-4 w-full"
            >
              <img
                className="w-12 h-12"
                alt={`${feature.title} icon`}
                src={feature.icon}
              />

              <div className="flex flex-col flex-1 items-start gap-1">
                <h2 className="w-full [font-family:'Arimo',Helvetica] font-normal text-neutral-950 text-base tracking-[0] leading-6">
                  {feature.title}
                </h2>

                <p className="w-full [font-family:'Arimo',Helvetica] font-normal text-[#717182] text-sm tracking-[0] leading-5">
                  {feature.description}
                </p>
              </div>
            </article>
          ))}
        </section>
      </main>

      <footer className="flex flex-col w-full items-start gap-3 pt-8 pb-8">
        <Button className="w-full h-14 bg-black text-white rounded-[14px] [font-family:'Arimo',Helvetica] font-normal text-sm tracking-[0] leading-5 hover:bg-black/90">
          Continue
        </Button>
      </footer>
    </div>
  );
};
