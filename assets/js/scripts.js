var mode = "light";

// Toggle Dark mode on/off
document.getElementById("dark-toggle-container").addEventListener("click", function() {
  const cssLink = document.getElementById("dark-css");
  cssLink.disabled = !cssLink.disabled;
  
  const toggleImg = document.querySelector("#dark-toggle-img");
  if (mode=="light") {
    toggleImg.src = "../../assets/imgs/light-mode.svg";
    mode = "dark";
  } else {
    toggleImg.src = "../../assets/imgs/dark-mode.svg";
    mode = "light";
  }
});