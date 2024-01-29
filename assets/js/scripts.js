var mode = getCookie('lightDark');

if (mode==null){
  var mode = "light";
  setCookie('lightDark',mode,28);
} else if (mode=='dark'){
  toggleLightDarkCSS();
}

function toggleLightDarkCSS(){
  const darkCSSs = document.getElementsByClassName("dark-css");
  Array.from(darkCSSs).forEach((darkCSS)=>{darkCSS.disabled = !darkCSS.disabled});
  
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