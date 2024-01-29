#!/bin/zsh

if [[ $# -eq 0 ]] then
  # Ask for the project name
  echo -n "Enter project name: "
  read projectName
else
  projectName=$1
fi

if [[ -n $projectName ]]; then

  # Ask for the project description
  echo -n "Enter project description: "
  read projectDescription
  
  # Ask for the JavaScript file name
  echo -n "Enter JS file name (with .js extension): "
  read jsFileName
  
  # Ask for export location
  echo -n "Enter export location (defaults to ~/Desktop): "
  read exportLocation
  
  if [ ! -d $exportLocation ]; then
    exportLocation="~/Desktop"
  fi
  
  # Ask for the theme choice
  echo -n "Enter theme choice (default/modern): "
  read themeChoice
  
  modernCSSLink=""
  modernDarkCSSLink=""
  if [ $themeChoice = "modern" ]; then
    modernCSSLink="<link rel='stylesheet' href='../../assets/css/modern/modern.css'>"
    modernDarkCSSLink="<link id='modern-dark-css' disabled='true' rel='stylesheet' href='../../assets/css/modern/modern-dark.css'>"
  else
    themeChoice="default"
  fi
  
  # Create a new directory for the project
  mkdir "builds/$projectName"
  
  touch "builds/$projectName/custom.css"
  
  # Create an HTML file
  cat <<EOF > "builds/$projectName/index.html"
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$projectName</title>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../assets/css/default/styles.css">
    $([ -n "$modernCSSLink" ] && echo "$modernCSSLink")
    <link id="dark-css" disabled="true" rel="stylesheet" href="../../assets/css/default/dark.css">
    $([ -n "$modernDarkCSSLink" ] && echo "$modernDarkCSSLink")
    <link rel="stylesheet" href="custom.css">
    <script src="https://cdn.jsdelivr.net/npm/d3@7"></script>
    <script src="../../assets/js/cookies.js"></script>
  </head>
  <body>
    <div id="dark-toggle-container">
      <img id="dark-toggle-img" alt="light/dark toggle" src="../../assets/imgs/dark-mode.svg"/>
    </div>
    <div id="title-container">
      <h1 id="title">$projectName</h1>
      <p id="desc">$projectDescription</p>
    </div>
    <div id="chart-container"></div>
    <div id="footer-container">
      <p id="footer">Toby Loader – D3.js $projectName</p>
    </div>
    <script src="../../d3/$jsFileName"></script>
    <script src="../../assets/js/scripts.js"></script>
  </body>
</html>
EOF

  # populate metadata.json
  jq ". + {\"$projectName\": {\"theme\": \"$themeChoice\", \"data\": [], \"js\": \"$jsFileName\", \"export\": \"$exportLocation\"}}" metadata.json > temp.json && mv temp.json metadata.json

  
  if [ $? -eq 0 ]; then
    echo "Project '$projectName' has been built successfully."
  else
    echo "Build of '$projectName' failed."
  fi
else 
  echo "The project name cannot be empty."
fi