output "you_can_access_jenkins_server_with_below_details" {
   value = ["${google_compute_instance.jenkins-server.*.network_interface.0.access_config.0.assigned_nat_ip}"]
}