### To Provision FireWall rule ###

resource "google_compute_firewall" "jenkins" {
  name = "jenkins-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["8080", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}


### To provision Jenkins Master ###

resource "google_compute_instance" "jenkins-server" {
   name = "jenkins-server"
   machine_type = "f1-micro"
   zone = "us-west1-a"
   tags = ["jenkins"]
   boot_disk {
      initialize_params {
      image = "ubuntu-1604-lts"
   }
}
network_interface {
   network = "default"
   access_config {}
}
service_account {
   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
   }

  provisioner "file" {
    source      = "install.sh"
    destination = "/tmp/install.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("gcloud")}"      ##Path of private key
      agent       = false
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("gcloud")}"        ##Path of private key
      agent       = false
    }

    inline = [
      "chmod +x /tmp/install.sh",
      "sudo /tmp/install.sh",
    ]
}


 metadata {
    sshKeys = "ubuntu:${file("gcloud.pub")}"       ##Path of public key
   }
}

output "jenkins_server_public_ip" {
   value = ["${google_compute_instance.jenkins-server.*.network_interface.0.access_config.0.assigned_nat_ip}"]
}
