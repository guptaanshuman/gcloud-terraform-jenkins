provider "google" {
credentials = "${file("account.json")}"   #Path of authentication key json file
project = " "			# Project ID
region = "us-central1"
}