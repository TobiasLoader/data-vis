var mode = getCookie('lightDark');

if (mode==null){
  var mode = "light";
  setCookie('lightDark',mode,28);
} else if (mode=='dark'){
  toggleLightDarkCSS();
}

function toggleLightDarkCSS(){
  const darkCSS = document.getElementById("dark-css");
  darkCSS.disabled = !darkCSS.disabled;
  
  const modernDarkCSS = document.getElementById("modern-dark-css");
  if (modernDarkCSS!=null) modernDarkCSS.disabled = !modernDarkCSS.disabled;
  
  const toggleImg = document.querySelector("#dark-toggle-img");
  if (mode=="dark") toggleImg.src = "../../assets/imgs/light-mode.svg";
  else toggleImg.src = "../../assets/imgs/dark-mode.svg";
}

// Toggle Dark mode on/off
document.getElementById("dark-toggle-container").addEventListener("click", function() {  
  if (mode=="light") {
    mode = "dark";
    setCookie('lightDark',mode,28);
  } else {
    mode = "light";
    setCookie('lightDark',mode,28);
  }
  
  toggleLightDarkCSS();
});