# data-vis

Builds local D3.js projects.

> Note: D3.js JS files reside in the `/d3` folder.

### Commands

```zsh
./shell/build.sh
> Enter project name:
> Enter project description:
> Enter JS file name (with .js extension):
```

```zsh
./shell/launch.sh [project name]
```

```zsh
./shell/delete.sh [project name]
```

```zsh
./shell/shutdown.sh
```

---

### Info

Run `./shell/build.sh` to build a new d3.js project.
The script asks for a title, description and d3.js script file (in /d3 folder).

Run `./shell/launch.sh [name]` to launch the `[name]` d3.js project.
Supply the name of the project as the parameter to the command.

Run `./shell/delete.sh [name]` to delete the `[name]` d3.js project.
Supply the name of the project as the parameter to the command.

Run `./shell/shutdown.sh` to shutdown the Python simple web server.

---

### Local Aliases

Follow the instructions in the [local-aliases-setup.md](./local-aliases-setup.md) file. You should then be able to run the commands as `[COMMAND]` instead of `./shell/[COMMAND].sh` as above from the `/data-vis` directory:

```zsh
build
```
```zsh
launch [name]
```
```zsh
delete [name]
```
```zsh
shutdown
```