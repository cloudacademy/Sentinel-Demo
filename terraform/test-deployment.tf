resource "kubernetes_deployment" "tfer--plexweb-002F-mysql-002D-deployment" {
  metadata {
    labels = {
      app = "mysql-deployment"
    }

    name      = "mysql-deployment"
  }

  spec {
    min_ready_seconds         = "0"
    paused                    = "false"
    progress_deadline_seconds = "600"
    replicas                  = "1"
    revision_history_limit    = "10"

    selector "match_labels" {
      app = "mysql-deployment"
    }

    strategy {
      rolling_update {
        max_surge       = "25%"
        max_unavailable = "25%"
      }

      type = "RollingUpdate"
    }

    template {
      metadata {
        generation = "0"

        labels {
          app = "mysql-deployment"
        }
      }

      spec {
        active_deadline_seconds         = "0"
        automount_service_account_token = "false"

        container {
          env {
            name = "MYSQL_ROOT_PASSWORD"

            value_from {
              secret_key_ref {
                key      = "root-password"
                name     = "db-secrets"
                optional = "false"
              }
            }
          }

          env {
            name = "MYSQL_DATABASE"

            value_from {
              secret_key_ref {
                key      = "mysql-db"
                name     = "db-secrets"
                optional = "false"
              }
            }
          }

          image             = "mysql:5.7"
          image_pull_policy = "IfNotPresent"
          name              = "mysql"

          port {
            container_port = "3306"
            host_port      = "0"
            protocol       = "TCP"
          }

          stdin                      = "false"
          stdin_once                 = "false"
          termination_message_path   = "/dev/termination-log"
          termination_message_policy = "File"
          tty                        = "false"

          volume_mount {
            mount_path = "/docker-entrypoint-initdb.d"
            name       = "init-script"
            read_only  = "false"
          }
        }

        dns_policy           = "ClusterFirst"
        enable_service_links = "true"
        host_ipc             = "false"
        host_network         = "false"
        host_pid             = "false"

        init_container {
          args                       = ["-o", "/tmp/data/init.sql", "https://raw.githubusercontent.com/tsarlewey/PlexWeb-1/master/includes/tables.sql"]
          image                      = "appropriate/curl"
          image_pull_policy          = "IfNotPresent"
          name                       = "init-curl"
          stdin                      = "false"
          stdin_once                 = "false"
          termination_message_path   = "/dev/termination-log"
          termination_message_policy = "File"
          tty                        = "false"

          volume_mount {
            mount_path = "/tmp/data"
            name       = "init-script"
            read_only  = "false"
          }
        }

        restart_policy                   = "Always"
        share_process_namespace          = "false"
        termination_grace_period_seconds = "30"

        volume {
          name = "mysql-pv-local"

          persistent_volume_claim {
            claim_name = "mysql-pvc"
            read_only  = "false"
          }
        }

        volume {
          name = "init-script"

          persistent_volume_claim {
            claim_name = "init-script"
            read_only  = "false"
          }
        }
      }
    }
  }
}