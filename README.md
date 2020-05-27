# dotfiles

Repo contains dotfiles for:

- git
- nvim
- prezto
- zsh

## Workstation build

Instructions adapted from [@fatih](https://github.com/fatih/dotfiles/tree/master/workstation).

This terraform script creates a workstation on DigitalOcean with my personal iPad ready to connect via mosh.

### Install

1. Install doctl and run `doctl run init`

1. Create workstation droplet

```
$ terraform init
$ terraform plan
$ terraform apply --auto-approve
```

1. SSH via mosh:

```
$ mosh --no-init --ssh="ssh -o StrictHostKeyChecking=no -i ~/.ssh/ipad_rsa -p 22" root@<DROPLET_IP> -- tmux new-session -ADs main
```