resource "kubernetes_deployment" "tfer--plexweb-002F-apache-002D-deployment" {
  metadata {
    labels = {
      app = "apache-deployment"
    }

    name      = "apache-deployment"
    namespace = "plexweb"
  }

  spec {
    min_ready_seconds         = "0"
    paused                    = "false"
    progress_deadline_seconds = "600"
    replicas                  = "1"
    revision_history_limit    = "10"

    selector "match_labels" {
      app = "apache-deployment"
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
          app = "apache-deployment"
        }
      }

      spec {
        active_deadline_seconds         = "0"
        automount_service_account_token = "false"

        container {
          image             = "tsarlewey/plexweb:Web1"
          image_pull_policy = "IfNotPresent"
          name              = "webserver"

          port {
            container_port = "80"
            host_port      = "0"
            protocol       = "TCP"
          }

          port {
            container_port = "443"
            host_port      = "0"
            protocol       = "TCP"
          }

          stdin                      = "false"
          stdin_once                 = "false"
          termination_message_path   = "/dev/termination-log"
          termination_message_policy = "File"
          tty                        = "false"

          volume_mount {
            mount_path = "/var/www/html"
            name       = "var-www"
            read_only  = "false"
          }

          volume_mount {
            mount_path = "/var/www/html/includes/config.php"
            name       = "php-config-map"
            read_only  = "false"
            sub_path   = "config.php"
          }
        }

        dns_policy           = "ClusterFirst"
        enable_service_links = "true"
        host_ipc             = "false"
        host_network         = "false"
        host_pid             = "false"

        init_container {
          args                       = ["clone", "--single-branch", "--", "https://github.com/tsarlewey/PlexWeb-1.git", "/var/www/html"]
          image                      = "alpine/git"
          image_pull_policy          = "IfNotPresent"
          name                       = "git-cloner"
          stdin                      = "false"
          stdin_once                 = "false"
          termination_message_path   = "/dev/termination-log"
          termination_message_policy = "File"
          tty                        = "false"

          volume_mount {
            mount_path = "/var/www/html"
            name       = "var-www"
            read_only  = "false"
          }
        }

        init_container {
          command                    = ["bash", "-c", "python3 ./includes/build.py"]
          image                      = "tsarlewey/plexweb:init"
          image_pull_policy          = "IfNotPresent"
          name                       = "minify-all"
          stdin                      = "false"
          stdin_once                 = "false"
          termination_message_path   = "/dev/termination-log"
          termination_message_policy = "File"
          tty                        = "false"

          volume_mount {
            mount_path = "/var/www/html"
            name       = "var-www"
            read_only  = "false"
          }

          working_dir = "/var/www/html"
        }

        restart_policy                   = "Always"
        share_process_namespace          = "false"
        termination_grace_period_seconds = "30"

        volume {
          name = "var-www"
        }

        volume {
          config_map {
            default_mode = "0644"

            items {
              key  = "config.php"
              path = "config.php"
            }

            name     = "php-config"
            optional = "false"
          }

          name = "php-config-map"
        }
      }
    }
  }
}


