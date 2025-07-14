// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./toast"


// This file is automatically compiled by Webpack, along with any other files
document.addEventListener("DOMContentLoaded", () => {
  const channel = new BroadcastChannel("click_earn_channel");

  document.querySelectorAll(".start-click").forEach(button => {
    button.addEventListener("click", () => {
      if (button.clicked) return;
      button.clicked = true;

      const linkId = button.dataset.linkId;
      const linkUrl = button.dataset.linkUrl;
      const countdownEl = document.querySelector(`#countdown-${linkId}`);
      const form = document.querySelector(`#auto-submit-form-${linkId}`);
      const newTab = window.open(`/click_window/${linkId}?url=${encodeURIComponent(linkUrl)}`, "_blank");

      let timeLeft = 15;
      button.disabled = true;
      button.classList.add("opacity-50", "cursor-not-allowed");
      countdownEl.classList.remove("hidden");
      countdownEl.textContent = `⏳ Wait ${timeLeft}s to earn reward...`;

      const timer = setInterval(() => {
        timeLeft--;
        countdownEl.textContent = `⏳ Wait ${timeLeft}s to earn reward...`;
        channel.postMessage({ type: "update", linkId, timeLeft });

        if (timeLeft <= 0) {
          clearInterval(timer);
          countdownEl.textContent = "🎉 Reward earned!";
          form.submit();
          channel.postMessage({ type: "complete", linkId });
        }
      }, 1000);

      // Detect if the new tab is closed early
      const monitor = setInterval(() => {
        if (newTab.closed && timeLeft > 0) {
          clearInterval(timer);
          clearInterval(monitor);
          countdownEl.textContent = "❌ Reward cancelled. Tab closed too early.";
          button.disabled = false;
          button.classList.remove("opacity-50", "cursor-not-allowed");
        }
      }, 1000);
    });
  });

  // Sync countdown across tabs
  channel.onmessage = (event) => {
    const { type, linkId, timeLeft } = event.data;
    const el = document.querySelector(`#countdown-${linkId}`);
    if (!el) return;

    if (type === "update") {
      el.classList.remove("hidden");
      el.textContent = `⏳ Wait ${timeLeft}s to earn reward...`;
    }

    if (type === "complete") {
      el.textContent = "🎉 Reward earned!";
    }
  };
});

