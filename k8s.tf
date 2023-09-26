# Create a new VPC for the Kubernetes cluster
resource "digitalocean_vpc" "my_vpc" {
  name       = "my-vpc"
  region     = "lon1"  # Deploying in London
  ip_range = "10.0.0.0/16"
}

resource "digitalocean_kubernetes_cluster" "my_cluster" {
  name   = "my-cluster"
  region = "lon1"

  version = "1.28.2-do.0" # Kubernetes Version to use

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 1 # Note this would usually be greater than 1 to ensure redundancy, but of course more nodes cost more. 1 node would not be good for a production system
  }

  vpc_uuid = digitalocean_vpc.my_vpc.id
}
