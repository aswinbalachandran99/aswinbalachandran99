locals {
  custom_data = <<CUSTOM_DATA
#!/bin/bash
# Update and install required packages
apt-get update
apt-get install -y default-jdk
cd /opt
wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.93/bin/apache-tomcat-9.0.93.tar.gz
tar -xzvf apache-tomcat-9.0.93.tar.gz
chmod +x apache-tomcat-9.0.93/bin/startup.sh
chmod +x apache-tomcat-9.0.93/bin/shutdown.sh
ln -s /opt/apache-tomcat-9.0.93/bin/startup.sh /usr/local/bin/tomcatup
ln -s /opt/apache-tomcat-9.0.93/bin/shutdown.sh /usr/local/bin/tomcatdown
tomcatup

CUSTOM_DATA
}

# Create a public IP address
resource "azurerm_public_ip" "public_ip" {
  name                = "tomcat-vm-public-ip"
  location            = "Central India"
  resource_group_name = "wims-rg"
  allocation_method   = "Dynamic"
}

# Create a network interface
resource "azurerm_network_interface" "nic" {
  name                = "tomcat-vm-nic"
  location            = "Central India"
  resource_group_name = "wims-rg"

  ip_configuration {
    name                          = "internal-1"
    subnet_id                     = "/subscriptions/a0e2d268-250a-48f7-8aff-017336700865/resourceGroups/wims-rg/providers/Microsoft.Network/virtualNetworks/wims-vnet/subnets/wims-subnet"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Create a Linux virtual machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "tomcat-vm"
  location            = "Central India"
  resource_group_name = "wims-rg"
  size                = "Standard_B2s"
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

    custom_data = base64encode(local.custom_data)
}