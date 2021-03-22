# =============================================================================
# Policy Names
# -----------------------------------------------------------------------------

variable "intersight_api_secret" {
  type = string
}

variable "ntp_policy_name" {
  default = "terraform-ntp-policy"
}
variable "localuser_policy_name" {
  default = "terraform-localuser-policy"
}
variable "ldap_policy_name" {
  default = "terraform-ldap-policy"
}
variable "kvm_policy_name" {
  default = "terraform-kvm-policy"
}
variable "netconnectivity_policy_name" {
  default = "terraform-netconnectivity-policy"
}
variable "deviceconnector_policy_name" {
  default = "terraform-deviceconnector-policy"
}
variable "vmedia_policy_name" {
  default = "terraform-vmedia-policy"
}
variable "persistentmemory_policy_name" {
  default = "terraform-persistentmemory-policy"
}
variable "ipmioverlan_policy_name" {
  default = "terraform-ipmioverlan-policy"
}
variable "diskgroup_policy_name" {
  default = "terraform-diskgroup-policy"
}
variable "storage_policy_name" {
  default = "terraform-storage-policy"
}
variable "bootorder_policy_name" {
  default = "terraform-bootorder-policy"
}

# =============================================================================
# Disk names
# -----------------------------------------------------------------------------
variable "virtual_dvd_name" {
  default = "NFS_DVD"
}
variable "virtual_disk_name" {
  default = "RAID1_01"
}


# =============================================================================
# Descriptions
# -----------------------------------------------------------------------------
variable "description" {
  default = "Created by Terraform. Do not edit manually."
}

# =============================================================================
# Organization
# -----------------------------------------------------------------------------
variable "organization" {
  default = "default"
}

# =============================================================================
# Tags
# -----------------------------------------------------------------------------
variable "owner" {
  default = "wwdc-labadmins"
}

# =============================================================================
# Local users
# -----------------------------------------------------------------------------
variable "imc_admin_password" {
  default = "!Ciscodc123"
  sensitive = true
}
variable "imc_admin_username" {
  default = "tfadmin"
}

# =============================================================================
# Servers and profile names
# -----------------------------------------------------------------------------
# MAP: moid of physical server = name of server profile
variable "server_list" {
  type = map(string)
  default = {
    # "C220-FCH2109V1RJ" = "5fd8c3b26176752d30db2c81"
    # "C220-FCH2109V1DX" = "5fd9012c6176752d30eb498a"
    # "C220-FCH2109V1PH" = "5fd902eb6176752d30ebba88"
    # "C220-FCH2109V0J3" = "5fd9048a6176752d30ec31b5"
    # "C220-FCH2109V1EB" = "6001ce406176752d30a8bf06"
    # "C220-FCH2109V2JC" = "5fd914606176752d30f04941"
    # "C220-FCH2109V1PL" = "5fd9147e6176752d30f04dd1"
    # "C220-FCH2109V2J7" = "5fd93a576176752d30fa86f4"
    "C220-FCH2109V2JB" = "5fd93a846176752d30fa9106"
    "C220-FCH2109V2EA" = "5fd93ab36176752d30fa9965"
    "C220-FCH2109V2JS" = "5fd93b696176752d30fad76f"
    "C220-FCH2109V2GV" = "5fd93b8f6176752d30fae527"
    "C220-FCH2109V2K6" = "5fd93bae6176752d30faeff1"
    "C220-FCH2109V2K5" = "5fd966026176752d3007aa24"
    "C220-FCH2109V2EN" = "5fd9663b6176752d3007b928"
    "C220-FCH2109V2KG" = "5fd9665e6176752d3007c282"
    # "C220-FCH2114V2ZY" = "5fd968ba6176752d30084fb8"
    # "C220-FCH2115V368" = "5fd968e56176752d30085dab"
    # "C220-FCH2114V31M" = "5fd9690c6176752d30086cb8"
    # "C220-FCH2114V31A" = "5fd969366176752d30087885"
    # "C220-FCH2114V304" = "5fd987256176752d300fb842"
    # "C220-FCH2114V2Q9" = "5fd9873f6176752d300fbd9d"
    # "C220-FCH2114V1SH" = "5fd9875e6176752d300fc490"
    # "C220-FCH2114V2E9" = "5fd9878a6176752d300fcf4b"
    # "C220-FCH2115V0FQ" = "5fda3d5e6176752d303d4298"
    # "C220-FCH2115V0T1" = "5fda3d746176752d303d4718"
    # "C220-FCH2115V0RN" = "5fda3db56176752d303d59cf"
    # "C220-FCH2115V0T6" = "5fda3dce6176752d303d6235"
    # "C220-FCH2115V0T5" = "5fda3e626176752d303d9a9e"
    # "C220-FCH2115V0T4" = "5fda3e816176752d303da386"
    # "C220-FCH2115V0M9" = "5fda3ea06176752d303dace1"
    # "C220-FCH2115V0G6" = "5fda3eb76176752d303db318"
    # "C220-FCH2115V0R1" = "5fda40066176752d303e1800"
    # "C220-FCH2115V0QZ" = "5fda40286176752d303e2113"
    # "C220-FCH2115V0F8" = "5fda40606176752d303e2fd1"
    # "C220-FCH2115V0FB" = "5fda40766176752d303e3586"
  }
}
