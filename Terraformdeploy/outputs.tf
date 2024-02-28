output "static_website_url" {
  value = azurerm_storage_account.resume.primary_web_endpoint
}

output "cdn_endpoint_hostname" {
  value = azurerm_cdn_endpoint.resume_cdn_endpoint.host_name
}
