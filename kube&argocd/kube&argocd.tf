####################################ArgoCD############################################

resource "helm_release" "argocd-helm" {
  name = "argocd-helm"

  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  create_namespace = true
  namespace        = "argocd"
}

###################################updatekubeconfig###################################

# resource "null_resource" "merge_kubeconfig" {
#   triggers = {
#     always = timestamp()
#   }

#   provisioner "local-exec" {
#     interpreter = ["/bin/bash", "-c"]
#     command = <<EOT
#       set -e
#       echo 'Applying Auth ConfigMap with kubectl...'
#       aws eks wait cluster-active --name 'new-cluster-2'
#       aws eks update-kubeconfig --name 'new-cluster-2' --alias 'new-cluster-2-ap-southeast-1' --region=ap-southeast-1 --profile=produser
#     EOT
#   }
# }

resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --region ap-southeast-1 --name new-cluster-2 --profile produser"
  }
}
