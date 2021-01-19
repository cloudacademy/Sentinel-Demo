resource "kubernetes_service" "tfer--cert-002D-manager-002F-cert-002D-manager" {
  metadata {
    labels = {
      app = "cert-manager"
    }

    name      = "cert-manager"
    namespace = "cert-manager"
  }

  spec {
    cluster_ip             = "10.105.213.39"
    health_check_node_port = "0"

    port {
      node_port   = "0"
      port        = "9402"
      protocol    = "TCP"
      target_port = "9402"
    }

    publish_not_ready_addresses = "false"

    selector = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "cert-manager"
      "app.kubernetes.io/name"      = "cert-manager"
    }

    session_affinity = "None"
    type             = "ClusterIP"
  }
}

resource "kubernetes_service" "tfer--cert-002D-manager-002F-cert-002D-manager-002D-webhook" {
  metadata {
    labels = {
      app = "webhook"
    }

    name      = "cert-manager-webhook"
    namespace = "cert-manager"
  }

  spec {
    cluster_ip             = "10.98.109.97"
    health_check_node_port = "0"

    port {
      name        = "https"
      node_port   = "0"
      port        = "443"
      protocol    = "TCP"
      target_port = "10250"
    }

    publish_not_ready_addresses = "false"

    selector = {
      "app.kubernetes.io/component" = "webhook"
      "app.kubernetes.io/instance"  = "cert-manager"
      "app.kubernetes.io/name"      = "webhook"
    }

    session_affinity = "None"
    type             = "ClusterIP"
  }
}

resource "kubernetes_service" "tfer--default-002F-kubernetes" {
  metadata {
    labels = {
      component = "apiserver"
      provider  = "kubernetes"
    }

    name      = "kubernetes"
    namespace = "default"
  }

  spec {
    cluster_ip             = "10.96.0.1"
    health_check_node_port = "0"

    port {
      name        = "https"
      node_port   = "0"
      port        = "443"
      protocol    = "TCP"
      target_port = "8443"
    }

    publish_not_ready_addresses = "false"
    session_affinity            = "None"
    type                        = "ClusterIP"
  }
}

resource "kubernetes_service" "tfer--kube-002D-system-002F-ingress-002D-nginx-002D-controller-002D-admission" {
  metadata {
    name      = "ingress-nginx-controller-admission"
    namespace = "kube-system"
  }

  spec {
    cluster_ip             = "10.103.140.148"
    health_check_node_port = "0"

    port {
      name        = "https-webhook"
      node_port   = "0"
      port        = "443"
      protocol    = "TCP"
      target_port = "webhook"
    }

    publish_not_ready_addresses = "false"

    selector = {
      "app.kubernetes.io/component" = "controller"
      "app.kubernetes.io/instance"  = "ingress-nginx"
      "app.kubernetes.io/name"      = "ingress-nginx"
    }

    session_affinity = "None"
    type             = "ClusterIP"
  }
}

resource "kubernetes_service" "tfer--kube-002D-system-002F-kube-002D-dns" {
  metadata {
    annotations = {
      "prometheus.io/port"   = "9153"
      "prometheus.io/scrape" = "true"
    }

    labels = {
      k8s-app = "kube-dns"
    }

    name      = "kube-dns"
    namespace = "kube-system"
  }

  spec {
    cluster_ip             = "10.96.0.10"
    health_check_node_port = "0"

    port {
      name        = "dns"
      node_port   = "0"
      port        = "53"
      protocol    = "UDP"
      target_port = "53"
    }

    port {
      name        = "dns-tcp"
      node_port   = "0"
      port        = "53"
      protocol    = "TCP"
      target_port = "53"
    }

    port {
      name        = "metrics"
      node_port   = "0"
      port        = "9153"
      protocol    = "TCP"
      target_port = "9153"
    }

    publish_not_ready_addresses = "false"

    selector = {
      k8s-app = "kube-dns"
    }

    session_affinity = "None"
    type             = "ClusterIP"
  }
}

resource "kubernetes_service" "tfer--plexweb-002F-apache" {
  metadata {
    labels = {
      app = "apache-deployment"
    }

    name      = "apache"
    namespace = "plexweb"
  }

  spec {
    cluster_ip              = "10.99.222.176"
    external_traffic_policy = "Cluster"
    health_check_node_port  = "0"

    port {
      name        = "insecure"
      node_port   = "31375"
      port        = "80"
      protocol    = "TCP"
      target_port = "80"
    }

    port {
      name        = "secure"
      node_port   = "31417"
      port        = "443"
      protocol    = "TCP"
      target_port = "443"
    }

    publish_not_ready_addresses = "false"

    selector = {
      app = "apache-deployment"
    }

    session_affinity = "ClientIP"
    type             = "NodePort"
  }
}

resource "kubernetes_service" "tfer--plexweb-002F-apache-002D-exporter" {
  metadata {
    name      = "apache-exporter"
    namespace = "plexweb"
  }

  spec {
    cluster_ip             = "10.103.144.26"
    health_check_node_port = "0"

    port {
      name        = "exporter"
      node_port   = "0"
      port        = "9117"
      protocol    = "TCP"
      target_port = "9117"
    }

    publish_not_ready_addresses = "false"

    selector = {
      app = "apache-deployment"
    }

    session_affinity = "None"
    type             = "ClusterIP"
  }
}

resource "kubernetes_service" "tfer--plexweb-002F-mysql-002D-deployment" {
  metadata {
    labels = {
      app = "mysql-deployment"
    }

    name      = "mysql-deployment"
    namespace = "plexweb"
  }

  spec {
    cluster_ip             = "10.105.38.6"
    health_check_node_port = "0"

    port {
      node_port   = "0"
      port        = "3306"
      protocol    = "TCP"
      target_port = "3306"
    }

    publish_not_ready_addresses = "false"

    selector = {
      app = "mysql-deployment"
    }

    session_affinity = "None"
    type             = "ClusterIP"
  }
}
