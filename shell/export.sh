#!/bin/zsh

function extractProjectSingleFromMetadata() {
  local projectName=$1
  local propertyName=$2
  local metadata=$(cat "metadata.json")
  # Find project in metadata
  local project=$(echo $metadata | jq -r ".$projectName")
  if [[ -n $project && $project != "null" ]]; then
    # Extract property from the project metadata
    dataToExtract=$(echo $project | jq -c ".$propertyName")
    if [[ -n $dataToExtract && $dataToExtract != "null" ]]; then
      unquotedDataToExtract=${dataToExtract//\"/}
      echo $unquotedDataToExtract
    fi
  else
    return 1
  fi
}

function extractProjectThemeFromMetadata() {
  echo $(extractProjectSingleFromMetadata $1 "theme")
}

function extractProjectJSFromMetadata() {
  echo $(extractProjectSingleFromMetadata $1 "js")
}

function extractProjectExportFromMetadata() {
  echo $(extractProjectSingleFromMetadata $1 "export")
}

function extractProjectDataFromMetadata() {
  local dataToExport=()
  local projectName=$1
  local metadata=$(cat "metadata.json")
  local project=$(echo $metadata | jq -r ".$projectName")
  
  # Check if project is not null and not the string "null"
  if [[ -n $project && $project != "null" ]]; then
    # Project exists in the metadata
    # Extract data
    dataList=$(echo $project | jq -c '.data[]')
    if [[ -n $dataList && $dataList != "null" ]]; then
      # Iterate through each item in the JSON array
      while IFS= read -r line; do
        unquotedLine=${line//\"/}
        dataToExport+=("$unquotedLine")
      done <<< "$dataList"
    fi
  else
    return 1
  fi
  printf '%s\n' "${dataToExport[@]}"
}

function exportProject(){
  if [[ -d $2 ]]; then
    local projectName=$1
    local projectDir="project-$projectName"
    local destination="$2/$projectDir"
    if [[ -d "builds/$projectName" ]]; then
      if [[ ! -d $destination ]]; then
        echo "Making directory $destination"
        mkdir "$destination"
      fi
      
      # assets
      if [[ -d "$destination/assets" ]]; then
        rm -r "$destination/assets"
      fi
      echo "Copying Assets"
      mkdir "$destination/assets"
      cp -r "./assets/imgs" "$destination/assets/imgs"
      cp -r "./assets/js" "$destination/assets/js"
      mkdir "$destination/assets/css"
      cp -r "./assets/css/default" "$destination/assets/css/default"
      projectTheme=$(extractProjectThemeFromMetadata $1)
      if [[ $projectTheme != "default" ]]; then
        cp -r "./assets/css/$projectTheme" "$destination/assets/css/$projectTheme"
      fi
      
      # build
      if [[ -d "$destination/builds" ]]; then
        rm -r "$destination/builds"
      fi
      echo "Copying Build"
      mkdir "$destination/builds"
      cp -r "./builds/$projectName" "$destination/builds/$projectName"
      
      # data
      if [[ -d "$destination/data" ]]; then
        rm -r "$destination/data"
      fi
      echo "Copying Data"
      mkdir "$destination/data"
      while IFS= read -r fileName; do
        cp "./data/$fileName" "$destination/data/$fileName"
      done < <(extractProjectDataFromMetadata "$projectName")
      
      # d3 js
      if [[ -d "$destination/d3" ]]; then
        rm -r "$destination/d3"
      fi
      projectJSFile=$(extractProjectJSFromMetadata $1)
      echo "Copying d3 JS file"
      mkdir "$destination/d3"
      cp "./d3/$projectJSFile" "$destination/d3/$projectJSFile"
      
      # alias index.html
      if [[ -f "$destination/index.html" ]]; then
        rm "$destination/index.html"
      fi
      echo "Creating alias to index.html"
      ln -s "$destination/builds/$projectName/index.html" "$destination/index.html"
      
      # create launch script
      if [[ -f "$destination/launch.sh" ]]; then
        rm "$destination/launch.sh"
      fi
      echo "Creating launch.sh script"
      touch "$destination/launch.sh"
      cat <<EOF > "$destination/launch.sh"
#/bin/bash
python3 -m http.server & sleep 2; open "http://localhost:8000/builds/$projectName"
EOF
    fi
  else
    echo "Destination directory doesn't exist."
  fi
}

case $# in
  0)
    echo "Export a project – with parameters:"
    echo " - Project name"
    echo " - [Optional destination directory]"
    echo ""
    echo "Note: if no destination directory supplied then the\n      default location as set in metadata.json is chosen"
    echo ""
    echo "Build projects ready for export:"
    path="$(pwd)/builds"
    for dir in "$path"/*; do
      if [ -d "$dir" ]; then
        echo " - ${dir:t}"
      fi
    done
    ;;
  1)
    exportLocation=$(extractProjectExportFromMetadata $1)
    expandedExportLocation=$(eval echo $exportLocation)
    if [[ -d $expandedExportLocation ]]; then
      echo "Export to $expandedExportLocation"
      exportProject $1 $expandedExportLocation
    else
      echo "Invalid export location - check your metadata.json or project name."
    fi
    ;;
  2)
    exportProject $1 $2
    ;;
  *)
    echo "Error: Too many parameters. Please provide one or two."
    ;;
esac