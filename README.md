a command line interface for common utilities built with v

no external deps are used

builds to ~900kb

```
Usage: cli [flags] [commands]

cli for common task utils for my system

Flags:
  -help               Prints help information.
  -man                Prints the auto-generated manpage.

Commands:
  server              starts a static web server on port 8080 with specified path or cwd
  node                Removes all node_modules from a cwd or specified paths
  search              searches for strings in specified paths
  editor              basic terminal text editor
  help                Prints help information.
  man                 Prints the auto-generated manpage.
```
