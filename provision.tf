terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


# Set the variable value using -var="do_token=..." CLI option
variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

variable "region" {
  default = "sfo2"
}

variable "ssh_key" { 
  default = "~/.ssh/id_rsa"
}

# Set the variable value using -var="ssh_key_id=..." CLI option
variable "ssh_key_id" {}

resource "digitalocean_droplet" "dev" {
  name               = "cloud-dev-desktop"
  image              = "ubuntu-20-04-x64"
  size               = "s-2vcpu-4gb"
  region             = "${var.region}"
  backups            = true
  ipv6               = true
  ssh_keys           = ["${var.ssh_key_id}"] # doctl compute ssh-key list

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file(var.ssh_key)}"
      timeout     = "2m"
      host = "${digitalocean_droplet.dev.ipv4_address}"
    }
  }

  provisioner "file" {
    source      = "bootstrap-zsh.sh"
    destination = "/tmp/bootstrap-zsh.sh"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file(var.ssh_key)}"
      timeout     = "2m"
      host = "${digitalocean_droplet.dev.ipv4_address}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "/tmp/bootstrap.sh initialize",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file(var.ssh_key)}"
      timeout     = "2m"
      host = "${digitalocean_droplet.dev.ipv4_address}"
    }
  }
}

resource "digitalocean_firewall" "dev" {
  name = "dev"

  droplet_ids = ["${digitalocean_droplet.dev.id}"]

  inbound_rule {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
	}

  inbound_rule {
      protocol         = "udp"
      port_range       = "60000-60010"
      source_addresses = ["0.0.0.0/0", "::/0"]
	}

  outbound_rule  {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
	}

  outbound_rule  {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
	}

  outbound_rule  {
      protocol              = "icmp"
      destination_addresses = ["0.0.0.0/0", "::/0"]
	}
}

resource "digitalocean_floating_ip" "dev" {
  droplet_id = "${digitalocean_droplet.dev.id}"
  region     = "${digitalocean_droplet.dev.region}"
}

output "public_ip" {
  value = "${digitalocean_floating_ip.dev.ip_address}"
}
