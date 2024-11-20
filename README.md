# Nix Project Template

I use [Nix](https://nixos.org/) for project isolation. A barebones Nix project for any programming language at least starts off looking like this for me.

Most of the work is done in the flake.nix file, which provides a devshell, package, and app. You should customize this flake as needed.

I use [direnv](https://direnv.net/) to load the Nix dev shell into my environment. You need to have direnv set up correctly in order for this to work.

You can either use this as a template in GitHub or as a flake template when running `nix flake init` like so:

```sh
nix flake init -t github:rfaulhaber/nix-project-template
```
