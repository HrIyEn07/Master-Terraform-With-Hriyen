environment = {
  name   = "staging"
  type   = "staging" 
  region = {
    primary   = "eastus"
    secondary = "westus"
  }
}

resource_group = {
  name = "stg-rg"
}

tags = {
  environment    = "staging"               
  App_owner      = "Hriyen"           
  managed_by     = "Terraform"                     
  cost_center    = "CC-12345"  
  business_unit  = "Finance"           
  project        = "E-Commerce-Portal" 
  backup_policy  = "enabled"           
  retention      = "30-days"           
  auto_shutdown  = "enabled"          
  provisioned_by = "Terraform"        
  expiry_date    = "N/A"       
  patching_group = "Group-A"        
  sla            = "99.9%"          
  support_team   = "DevOps"    
}