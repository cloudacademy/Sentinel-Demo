resource "kubernetes_namespace" "tfer--cert-002D-manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "kubernetes_namespace" "tfer--default" {
  metadata {
    name = "default"
  }
}

resource "kubernetes_namespace" "tfer--kube-002D-node-002D-lease" {
  metadata {
    name = "kube-node-lease"
  }
}

resource "kubernetes_namespace" "tfer--kube-002D-public" {
  metadata {
    name = "kube-public"
  }
}

resource "kubernetes_namespace" "tfer--kube-002D-system" {
  metadata {
    name = "kube-system"
  }
}

resource "kubernetes_namespace" "tfer--plexweb" {
  metadata {
    name = "plexweb"
  }
}
