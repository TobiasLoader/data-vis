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
  echo -n "Enter JS file name (with extension .js): "
  read jsFileName
  if [[ $jsFileName == *.js ]]; then
    if [[ ! -f "./d3/$jsFileName" ]]; then
      touch "./d3/$jsFileName"
    fi
  else
    jsFileName="template.js"
  fi
  
  # Ask for export location
  echo -n "Enter export location (defaults to ~/Desktop): "
  read exportLocation
  expandedExportLocation=$(eval echo $exportLocation)
  if [[ ! -n $exportLocation ]] || [[ ! -d $expandedExportLocation ]]; then
    exportLocation="~/Desktop"
  fi
  
  # Ask for the theme choice
  echo -n "Enter theme choice (default/modern): "
  read themeChoice
  
  customThemes=("modern")
  # if themeChioce is in the list themeOptions
  if [[ ${customThemes[(ie)$themeChoice]} -le ${#customThemes} ]]; then
    # then set the theme css links
    themeCSSLink="<link rel='stylesheet' href='../../assets/css/$themeChoice/$themeChoice.css'>"
    themeDarkCSSLink="<link class='dark-css' disabled='true' rel='stylesheet' href='../../assets/css/$themeChoice/$themeChoice-dark.css'>"
  else
    # otherwise set themeChoice to default
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
    $([[ $themeChoice != "default" ]] && echo "$themeCSSLink")
    <link class="dark-css" disabled="true" rel="stylesheet" href="../../assets/css/default/dark.css">
    $([[ $themeChoice != "default" ]] && echo "$themeDarkCSSLink")
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