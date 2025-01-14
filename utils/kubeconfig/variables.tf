variable "f5xc_api_url" {
  type = string
}

variable "f5xc_api_token" {
  type = string
}

variable "f5xc_k8s_cluster_name" {
  type = string
}

variable "f5xc_rest_uri_sites" {
  type    = string
  default = "web/namespaces/system/sites"
}

variable "f5xc_k8s_config_type" {
  type = string
}

variable "f5xc_k8s_config_types" {
  type    = map(string)
  default = {
    global = "global-kubeconfigs"
    local  = "local-kubeconfigs"
  }
}

variable "output_dir_path" {
  type    = string
  default = ""
}