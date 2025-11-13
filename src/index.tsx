import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { WelcomePage } from "./screens/WelcomePage";

createRoot(document.getElementById("app") as HTMLElement).render(
  <StrictMode>
    <WelcomePage />
  </StrictMode>,
);
