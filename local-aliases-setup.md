## How to set up local aliases for the commands:

> Instructions only for a Unix system using a `zsh` terminal environment

1. Add for following snippet of shell script to the bottom on your `~/.zshrc` file.

```zsh
# to create local aliases for zsh commands

local_alias(){
  local aliasName=$1
  local aliasLocalPath=$2
  local directoryPath=$3
  if [[ "$(pwd)" = $directoryPath ]]; then
    alias $aliasName=".$2/$aliasName.sh"
  else
    unalias $aliasName 2> /dev/null
  fi
}

function precmd() {
  # creates aliases to build, launch and delete only in the 'data-vis' directory
  local dataVisDir="/path/to/data-vis"
  local shellDir="/shell"
  local_alias build $shellDir $dataVisDir
  local_alias launch $shellDir $dataVisDir
  local_alias delete $shellDir $dataVisDir
  local_alias shutdown $shellDir $dataVisDir
  local_alias export $shellDir $dataVisDir
}
```

2. Restart your terminal (or run `source ~/.zshrc`)

3. Now you should be able to use local aliases from the `/data-vis` directory:

- `build`
- `launch [name]`
- `delete [name]`
- `shutdown`
- `export [name] [optional destination]`

You can now run `[COMMAND]` instead of `./shell/[COMMAND].sh`.