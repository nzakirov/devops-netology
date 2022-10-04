resource "yandex_dns_recordset" "domains" {
  count   = 6
  zone_id = yandex_dns_zone.dns_domain.id
  #name    = join("", [var.subdomain[count.index], "."])
  name = var.subdomain[count.index]
  type = "A"
  ttl  = 60
  #data    = "${yandex_compute_instance.rproxy.network_interface.0.nat_ip_address}"
  data = [yandex_compute_instance.rproxy.network_interface.0.nat_ip_address]

}
