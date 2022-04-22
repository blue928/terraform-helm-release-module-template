resource "kubernetes_namespace_v1" "helm_app_namespace" {
  metadata {
    name = var.chart_namespace
  }
  
}
resource "helm_release" "ingress_nginx" {
  name       = var.name
  repository = var.chart_repository
  chart      = var.chart_name
  version = var.chart_version

  # todo change this to a variable
  namespace        = kubernetes_namespace_v1.helm_app_namespace.metadata[0].name
  timeout          = var.chart_timeout

  #values = [file("nginx_ingress_values.yaml")]

  dynamic "set" {
    for_each = local.yaml_values
    content {
      name = "${set.value.name}"
      value = "${set.value.value}"
    }
  }
}