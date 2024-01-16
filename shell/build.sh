#!/bin/zsh

# Ask for the project name
echo -n "Enter project name: "
read projectName

# Ask for the project description
echo -n "Enter project description: "
read projectDescription

# Ask for the JavaScript file name
echo -n "Enter JS file name (with .js extension): "
read jsFileName

# Create a new directory for the project
mkdir "builds/$projectName"

touch "builds/$projectName/custom.css"

# Create an HTML file
cat <<EOF > "builds/$projectName/index.html"
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$projectName</title>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../../css/styles.css">
    <link rel="stylesheet" href="custom.css">
    <script src="https://cdn.jsdelivr.net/npm/d3@7"></script>
  </head>
  <body>
    <div id="title-container">
      <h1 id="title">$projectName</h1>
      <p id="desc">$projectDescription</p>
    </div>
    <div id="chart-container"></div>
    <div id="footer-container">
      <p id="footer">Toby Loader – D3.js $projectName</p>
    </div>
    <script src="../../d3/$jsFileName"></script>
  </body>
</html>
EOF

if [ $? -eq 0 ]; then
  echo "Project '$projectName' has been built successfully."
else
  echo "Build of '$projectName' failed."
fi
