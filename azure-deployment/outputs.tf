output "UCPDNSTarget" {
  description = "Use this name to update your DNS records"
  value       = "${module.ucp_app_lb.fqdn}"
}

output "DTRDNSTarget" {
  description = "Use this name to update your DNS records"
  value       = "${module.dtr_app_lb.fqdn}"
}

output "LinAppDNSTarget" {
  description = "Use this name to update your DNS records"
  value       = "${module.lin_app_lb.fqdn}"
}

output "WinAppDNSTarget" {
  description = "Use this name to update your DNS records"
  value       = "${module.win_app_lb.fqdn}"
}
