# Configure the DigitalOcean Provider
provider "digitalocean" {
    token = "${var.do_token}"
}

resource "digitalocean_droplet" "drone" {
    name      = "drone"
    size      = "1gb"
    image     = "docker"
    region    = "sfo1"
    ssh_keys  = THROW YOUR SSH KEYS IN HERE

    # have to do a remote-exec before local-exec b/c known_hosts
    provisioner "remote-exec" {
        inline = ["echo ಠ_ಠ > /etc/motd"]
        connection {
            key_file = "~/.ssh/id_rsa"
            timeout = "4m"
        }
    }

    provisioner "local-exec" {
        command = "echo ${digitalocean_droplet.drone.ipv4_address} > hosts"
    }

    provisioner "local-exec" {
        command = "sed -i \"\" '/${digitalocean_droplet.drone.ipv4_address}/d' ~/.ssh/known_hosts"
    }

    provisioner "local-exec" {
        command = "OPTS=-vvvv make bootstrap"
    }

    provisioner "local-exec" {
        command = "OPTS=-vvvv make site"
    }
}

output "ip_addr" {
    value = "${digitalocean_droplet.drone.ipv4_address}"
}
