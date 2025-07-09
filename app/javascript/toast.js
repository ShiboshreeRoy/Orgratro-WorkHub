document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("toast-container");

  ["notice", "alert"].forEach(type => {
    const el = document.getElementById(`toast-${type}`);
    if (el) {
      const message = el.dataset.message;
      const toast = document.createElement("div");
      toast.className = `toast ${type}`;
      toast.innerHTML = `<strong>${type.toUpperCase()}:</strong> ${message}`;
      container.appendChild(toast);

      setTimeout(() => {
        toast.remove();
      }, 5000);
    }
  });
});
