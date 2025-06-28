resource "azurerm_servicebus_namespace" "sbus" {
  name                = "${var.project}-${var.environment}-sbns"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name


  local_auth_enabled = false

  network_rule_set {
    default_action                = "Allow"
    public_network_access_enabled = true
    trusted_services_allowed      = false
  }
  public_network_access_enabled = true
  sku                           = "Standard"
  tags                          = local.tags


}

resource "azurerm_servicebus_topic" "sbus_topic" {
  name         = "${var.project}-${var.environment}-topic"
  namespace_id = azurerm_servicebus_namespace.sbus.id

  partitioning_enabled  = true
  max_size_in_megabytes = 1024
  default_message_ttl   = "P14D"
  status                = "Active"

  #   tags = local.tags
}


resource "azurerm_servicebus_queue" "sbus_queue" {
  name         = "queue01"
  namespace_id = azurerm_servicebus_namespace.sbus.id

  default_message_ttl                     = "P14D"
  dead_lettering_on_message_expiration    = true
  duplicate_detection_history_time_window = "PT10M"
  enable_batched_operations               = true
  partitioning_enabled                    = true
  lock_duration                           = "PT1M"
  max_delivery_count                      = 10
  max_size_in_megabytes                   = 1024
  requires_duplicate_detection            = false
  requires_session                        = false

}