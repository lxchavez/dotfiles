# dotfiles

Repo contains dotfiles for:

- git
- nvim
- prezto
- zsh

## Workstation build

Instructions adapted from [@fatih](https://github.com/fatih/dotfiles/tree/master/workstation).

This terraform script creates a workstation on a DigitalOcean droplet. Can use my personal iPad to connect via mosh.

### Install Pre-Reqs
1. Get a hold of a Linux box (AWS ECS free tier instances are great for this)
1. Install Snap ([instructions for Amazon Linux 2](https://github.com/albuild/snap))
1. Install doctl: `sudo snap install doctl`
1. Install terraform: `sudo snap install terraform --classic`

### Deploy

1. Generate a Digital Ocean API key. Install doctl and run `doctl auth init`. Check that auth is working with `doctl account get`. 

1. If you haven't already, generate SSH key pair and add public key for the machine you're using to provision this on in Digital Ocean. Take note of your SSH key id on Digital Ocean via `doctl compute ssh-key list`. 

1. Create workstation droplet:

```
$ terraform init
$ terraform plan
$ terraform apply -var "ssh_key_id=ssh key id from doctl" -var "do_token=your digitalocean api key"  --auto-approve
```

1. SSH via mosh:

```
$ mosh --no-init --ssh="ssh -o StrictHostKeyChecking=no -i ~/.ssh/id_rsa -p 22" root@<DROPLET_IP> -- tmux new-session -ADs main
```
