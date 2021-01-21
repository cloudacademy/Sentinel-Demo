resource "kubernetes_deployment" "webserver-fail" {
  metadata {
    name = "front-end-webserver"
    namespace = "fail-front-end"
    labels = {
      webserver = "front-end-nginx"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        test = "front-end-webserver"
      }
    }

    template {
      metadata {
        labels = {
          test = "front-end-webserver"
        }
      }

      spec {
        container {
          image = "nginx:1.7.8"
          name  = "nginx"

          liveness_probe {
            http_get {
              path = "/nginx_status"
              port = 80

              http_header {
                name  = "X-Custom-Header"
                value = "At_least_I_have_liveness_probes"
              }
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}