var mode = "light";

// Toggle Dark mode on/off
document.getElementById("dark-toggle-container").addEventListener("click", function() {
  const darkCSS = document.getElementById("dark-css");
  darkCSS.disabled = !darkCSS.disabled;
  
  const modernDarkCSS = document.getElementById("modern-dark-css");
  if (modernDarkCSS!=null) modernDarkCSS.disabled = !modernDarkCSS.disabled;
  
  const toggleImg = document.querySelector("#dark-toggle-img");
  if (mode=="light") {
    toggleImg.src = "../../assets/imgs/light-mode.svg";
    mode = "dark";
  } else {
    toggleImg.src = "../../assets/imgs/dark-mode.svg";
    mode = "light";
  }
});