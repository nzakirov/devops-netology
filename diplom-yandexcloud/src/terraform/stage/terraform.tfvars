zones      = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
cidr       = ["192.168.11.0/24", "192.168.12.0/24", "192.168.13.0/24"]
name       = ["app", "db01", "db02", "gitlab", "monitoring", "runner"]
hostname   = ["app.nzakirov.ru", "db01.nzakirov.ru", "db02.nzakirov.ru", "gitlab.nzakirov.ru", "monitoring.nzakirov.ru", "runner.nzakirov.ru"]
subdomain  = ["@", "www", "gitlab", "grafana", "prometheus", "alertmanager"]
rproxy_ip  = "192.168.11.10"
dns_domain = "nzakirov.ru"
