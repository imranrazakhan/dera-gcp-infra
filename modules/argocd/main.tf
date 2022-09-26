resource "random_password" "argocd_admin_password" {
  length  = 16
  special          = true
}

resource "time_sleep" "wait_120_seconds" {
  create_duration = "120s"
  destroy_duration = "120s"
}

resource "helm_release" "argocd" {
  name              = "argocd"
  chart             = "argo-cd"
  repository        = "https://argoproj.github.io/argo-helm"
  version           = var.argocd_chart_version
  namespace         = var.argocd_namespace
  create_namespace  = var.argocd_namespace_create
  timeout           = 600
  wait              = true
  wait_for_jobs     = true
  atomic            = true
  dependency_update = true

  values = var.argocd_chart_value_files
  
  ## Server params
  set { # Argo CD server name
    name  = "server.name"
    value = "argocd-server"
  }
  
  set {
    name  = "server.extraArgs"
    value = "{--request-timeout=\"5m\"}"}
  }
  
  
  depends_on = [
    time_sleep.wait_120_seconds, kubernetes_namespace.argocd
  ]

}

resource "helm_release" "argocd-apps" {
  count = (var.argocd_projects_file || var.argocd_applications_file) ? 1 : 0

  name              = "argocd-apps"
  chart             = "argocd-apps"
  repository        = "https://argoproj.github.io/argo-helm"
  version           = var.argocd_apps_chart_version
  namespace         = helm_release.argocd.namespace
  create_namespace  = false
  timeout           = 600
  wait              = true
  wait_for_jobs     = true
  atomic            = true
  dependency_update = true

  values = [var.argocd_projects_file, var.argocd_applications_file]
  
  depends_on = [
    time_sleep.wait_120_seconds, helm_release.argocd
  ]
  
}
