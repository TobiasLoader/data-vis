# data-vis

Create and Deploy local D3.js projects.

> Note: D3.js JS files reside in the `/d3` folder.

I built this before taking the Data Visualisation course at Oxford, to be able to quickly deploy and organise D3.js projects.

Metadata of built projects is stored in `metadata.json` and is used to export the projects. Note: before exporting a project, add any file names (from `/data` folder) that you wish to include in the `data` array of the `metadata.json` file.

---

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

```zsh
./shell/export.sh [project name]
```

See [local aliases](#local-aliases) section below for a more streamlined approach.

---

### Info

Run `./shell/build.sh` to build a new d3.js project.
The script asks for a title, description and d3.js script file (in /d3 folder).

Run `./shell/launch.sh [name]` to launch the `[name]` d3.js project.
Supply the name of the project as the parameter to the command.

Run `./shell/delete.sh [name]` to delete the `[name]` d3.js project.
Supply the name of the project as the parameter to the command.

Run `./shell/shutdown.sh` to shutdown the Python simple web server.

Run `./shell/export.sh [name]` to export the `[name]` d3.js project.
Supply an optional parameter to specify the destination path.
If not given, will extract the default export path from `metadata.json`.

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
```zsh
export [name]
```
