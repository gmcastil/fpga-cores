set vivado_version [version -short]
set vivado_home "$::env(HOME)/.Xilinx/Vivado"

# Generic Vivado configuration options
puts "Applying generic configuration options"

# Version specific Vivado configuration options
switch "${vivado_version}" {

  "2022.1" {
    set vivado_version_init "${vivado_home}/init_${vivado_version}.tcl"
    if { [file exists "${vivado_version_init}"] } {
      puts "Applying ${vivado_version} configuration settings"
      source "${vivado_version_init}"
    } else {
      puts "Could not find ${vivado_version_init}"
    }
  }

  default {
    puts "No configuration options for Vivado ${vivado_version}"
  }

}


