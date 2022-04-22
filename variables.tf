variable "name" {
  description = "Your install name for this chart"
  type    = string
  default = "ingress-nginx"
}
  
variable "chart_repository" {
  description = "The repository to pull the chart from"
  type    = string
  default = "https://kubernetes.github.io/ingress-nginx"
}

variable "chart_name" {
  description = "The name of the chart to install"
  type    = string
  default = "ingress-nginx"
}

variable "chart_version" {
    description = "The version of the chart to install"
  type    = string
  default = "4.0.19"
}

variable "chart_namespace" {
  description = "The namespace to install the chart into"
  type    = string
  default = "ingress-nginx"
}
  
variable "chart_timeout" {
  description = "The timeout for the helm install"
  type    = string
  default = "1500"
}

/*variable "set_yaml_values" {
  type = map
    default = {
        "controller.replicaCount" = "2",
        "controller.service.externalTrafficPolicy" = "Local",
        "controller.service.loadBalancerIP" = "var.lb_public_ip",
    }
}*/
  

# We're using Locals here instead of variables because sometimes the values need to be dynamically
# set. Locals support interpolation where variables do not.
locals {
   yaml_values = [{
      name        = "controller.replicaCount"
      value = "2"
   },
   {
      name        = "controller.service.externalTrafficPolicy"
      value = "Local"
   },
   {
      name        = "controller.service.loadBalancerIP"
      value = ""
   }]
}