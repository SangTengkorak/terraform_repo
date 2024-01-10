# Create K8s namespace
resource "kubernetes_namespace" "example" {
  metadata {
    name = "k8slab-tf"
  }
}

# Create a Kubernetes deployment
resource "kubernetes_deployment" "example_deployment" {
  metadata {
    name = "example-deployment"
    labels = {
      app = "example-app"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "example-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "example-app"
        }
      }
      spec {
        container {
          name  = "mastengweb-tf"
          image = "nginx:alpine"
          # Other container configurations as needed

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

# Create a Kubernetes service
resource "kubernetes_service" "example_service" {
  metadata {
    name = "example-service"
  }
  spec {
    selector = {
      app = "example-app"
    }
    port {
      port        = 8080
      target_port = 80
    }
  }
}