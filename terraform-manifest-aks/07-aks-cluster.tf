resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "${azurerm_resource_group.aks_rg.name}-cluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "${azurerm_resource_group.aks_rg.name}-cluster"
  kubernetes_version  = data.azurerm_kubernetes_service_versions.current.latest_version
  node_resource_group = "${azurerm_resource_group.aks_rg.name}-nrg"

  default_node_pool {
    name       = "systempool"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    orchestrator_version = data.azurerm_kubernetes_service_versions.current.latest_version
    # enable_auto_scaling = true
    os_disk_size_gb = 30
    type = "VirtualMachineScaleSets"
    node_labels = {
        "nodepool-type" = "system"
        "environment"   = "dev"
        "nodepoolos"    = "linux"
        "app"           = "system-apps"
    }
    tags = {
        "nodepool-type" = "system"
        "environment"   = "dev"
        "nodepoolos"    = "linux"
        "app"           = "system-apps"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  windows_profile {
      admin_username = var.windows_admin_username
      admin_password = var.windows_admin_password
  }

  linux_profile {
      admin_username = "ubuntu"
      ssh_key {
          key_data = file(var.ssh_public_key)
      }
  }

  network_profile {
      network_plugin = "azure"
      load_balancer_sku = "Standard"
  }

  tags = {
    Environment = "dev"
  }
}
