# = Class: audit
#
# This is the main audit class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, audit class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $audit_myclass
#
# [*dependency_class*]
#   Name of the class that provides third module dependencies
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, audit main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $audit_source
#
# [*source_dir*]
#   If defined, the whole audit configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $audit_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $audit_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, audit main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $audit_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $audit_options
#
# [*service_autorestart*]
#   Automatically restarts the audit service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $audit_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $audit_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $audit_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $audit_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for audit checks
#   Can be defined also by the (top scope) variables $audit_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $audit_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $audit_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $audit_puppi_helper
#   and $puppi_helper
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $audit_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $audit_audit_only
#   and $audit_only
#
# [*noops*]
#   Set noop metaparameter to true for all the resources managed by the module.
#   Basically you can run a dryrun for this specific module if you set
#   this to true. Default: undef
#
# Default class params - As defined in audit::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of audit package
#
# [*service*]
#   The name of audit service
#
# [*service_status*]
#   If the audit service init script supports status argument
#
# [*process*]
#   The name of audit process
#
# [*process_args*]
#   The name of audit arguments. Used by puppi and monitor.
#   Used only in case the audit process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user audit runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
#
# See README for usage patterns.
#
class audit (
  $my_class                   = params_lookup( 'my_class' ),
  $dependency_class           = params_lookup( 'dependency_class' ),
  $source                     = params_lookup( 'source' ),
  $source_dir                 = params_lookup( 'source_dir' ),
  $source_dir_purge           = params_lookup( 'source_dir_purge' ),
  $template                   = params_lookup( 'template' ),
  $service_autorestart        = params_lookup( 'service_autorestart' , 'global' ),
  $options                    = params_lookup( 'options' ),
  $version                    = params_lookup( 'version' ),
  $absent                     = params_lookup( 'absent' ),
  $disable                    = params_lookup( 'disable' ),
  $disableboot                = params_lookup( 'disableboot' ),
  $monitor                    = params_lookup( 'monitor' , 'global' ),
  $monitor_tool               = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target             = params_lookup( 'monitor_target' , 'global' ),
  $puppi                      = params_lookup( 'puppi' , 'global' ),
  $puppi_helper               = params_lookup( 'puppi_helper' , 'global' ),
  $debug                      = params_lookup( 'debug' , 'global' ),
  $audit_only                 = params_lookup( 'audit_only' , 'global' ),
  $noops                      = params_lookup( 'noops' ),
  $package                    = params_lookup( 'package' ),
  $service                    = params_lookup( 'service' ),
  $service_status             = params_lookup( 'service_status' ),
  $process                    = params_lookup( 'process' ),
  $process_args               = params_lookup( 'process_args' ),
  $process_user               = params_lookup( 'process_user' ),
  $config_dir                 = params_lookup( 'config_dir' ),
  $config_file                = params_lookup( 'config_file' ),
  $config_file_mode           = params_lookup( 'config_file_mode' ),
  $config_file_owner          = params_lookup( 'config_file_owner' ),
  $config_file_group          = params_lookup( 'config_file_group' ),
  $config_file_init           = params_lookup( 'config_file_init' ),
  $config_file_init_source    = params_lookup( 'config_file_init_source'),
  $config_file_init_template  = params_lookup( 'config_file_init_template' ),
  $pid_file                   = params_lookup( 'pid_file' ),
  $data_dir                   = params_lookup( 'data_dir' ),
  $log_dir                    = params_lookup( 'log_dir' ),
  $log_file                   = params_lookup( 'log_file' ),
  $port                       = params_lookup( 'port' ),
  $protocol                   = params_lookup( 'protocol' )
  ) inherits audit::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $audit::bool_absent ? {
    true  => 'absent',
    false => $audit::version,
  }

  $manage_service_enable = $audit::bool_disableboot ? {
    true    => false,
    default => $audit::bool_disable ? {
      true    => false,
      default => $audit::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $audit::bool_disable ? {
    true    => 'stopped',
    default =>  $audit::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $audit::bool_service_autorestart ? {
    true    => Service[audit],
    false   => undef,
  }

  $manage_file = $audit::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $audit::bool_absent == true
  or $audit::bool_disable == true
  or $audit::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  $manage_audit = $audit::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $audit::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $audit::source ? {
    ''        => undef,
    default   => $audit::source,
  }

  $manage_file_content = $audit::template ? {
    ''        => undef,
    default   => template($audit::template),
  }

  $manage_config_file_init_source = $audit::config_file_init_source ? {
    ''        => undef,
    default   => $audit::config_file_init_source,
  }

  $manage_config_file_init_template = $audit::config_file_init_template ? {
    ''        => undef,
    default   => template($audit::config_file_init_template),
  }


  ### Include custom class if $my_class is set
  if $audit::my_class {
    include $audit::my_class
  }

  ### Include dependencies provided by other modules
  if $audit::dependency_class {
    require $audit::dependency_class
  }

  ### Managed resources
  case $audit::bool_absent {
    true: {
      class { 'audit::service': } ->
      class { 'audit::config': } ->
      class { 'audit::install': } ->
      Class['audit']
    }
    false:{
      class { 'audit::install': } ->
      class { 'audit::config': } ->
      class { 'audit::service': } ->
      Class['audit']
    }
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $audit::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'audit':
      ensure    => $audit::manage_file,
      variables => $classvars,
      helper    => $audit::puppi_helper,
      noop      => $audit::noops,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $audit::bool_monitor == true {
    if $audit::service != '' {
      monitor::process { 'audit_process':
        process  => $audit::process,
        service  => $audit::service,
        pidfile  => $audit::pid_file,
        user     => $audit::process_user,
        argument => $audit::process_args,
        tool     => $audit::monitor_tool,
        enable   => $audit::manage_monitor,
        noop     => $audit::noops,
      }
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $audit::bool_debug == true {
    file { 'debug_audit':
      ensure  => $audit::manage_file,
      path    => "${settings::vardir}/debug-audit",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
      noop    => $audit::noops,
    }
  }

}
