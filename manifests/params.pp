# Class: audit::params
#
# This class defines default parameters used by the main module class audit
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to audit class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class audit::params {

  ### Application related parameters

  $package = $::operatingsystem ? {
    default => 'audit',
  }

  $service = $::operatingsystem ? {
    default => 'auditd',
  }

  $service_status = $::operatingsystem ? {
    default => true,
  }

  $process = $::operatingsystem ? {
    default => 'auditd',
  }

  $process_args = $::operatingsystem ? {
    default => '',
  }

  $process_user = $::operatingsystem ? {
    default => 'audit',
  }

  $config_dir = $::operatingsystem ? {
    default => '/etc/audit',
  }

  $config_file = $::operatingsystem ? {
    default => '/etc/audit/auditd.conf',
  }

  $config_file_mode = $::operatingsystem ? {
    default => '0640',
  }

  $config_file_owner = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_group = $::operatingsystem ? {
    default => 'root',
  }

  $config_file_init = $::operatingsystem ? {
    /(?i:Debian|Ubuntu|Mint)/ => '/etc/default/auditd',
    default                   => '/etc/sysconfig/auditd',
  }

  $pid_file = $::operatingsystem ? {
    default => '/var/run/auditd.pid',
  }

  $data_dir = $::operatingsystem ? {
    default => '/etc/audit',
  }

  $log_dir = $::operatingsystem ? {
    default => '/var/log/audit',
  }

  $log_file = $::operatingsystem ? {
    default => '/var/log/audit/audit.log',
  }

  # General Settings
  $my_class = ''
  $dependency_class = ''
  $source = ''
  $source_dir = ''
  $source_dir_purge = false
  $template = ''
  $options = ''
  $service_autorestart = true
  $version = 'present'
  $absent = false
  $disable = false
  $disableboot = false
  $config_file_init_source = ''
  $config_file_init_template = ''

  ### General module variables that can have a site or per module default
  $monitor = false
  $monitor_tool = ''
  $monitor_target = $::ipaddress
  $puppi = false
  $puppi_helper = 'standard'
  $debug = false
  $audit_only = false
  $noops = undef

}
