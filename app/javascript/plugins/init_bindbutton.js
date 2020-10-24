const bindButton = () => {
  const button = document.querySelector(".map-btn")
  if (button) {
    button.addEventListener("click", () => {
      setTimeout(() => { window.map.resize() }, 400)
    });
  };
}

export { bindButton };
