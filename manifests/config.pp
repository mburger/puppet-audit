# Class: audit::config
#
# This class manages audit configuration
#
# == Variables
#
# Refer to audit class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It's automatically included by audit
#
class audit::config {

  file { 'audit.conf':
    ensure  => $audit::manage_file,
    path    => $audit::config_file,
    mode    => $audit::config_file_mode,
    owner   => $audit::config_file_owner,
    group   => $audit::config_file_group,
    notify  => $audit::manage_service_autorestart,
    source  => $audit::manage_file_source,
    content => $audit::manage_file_content,
    replace => $audit::manage_file_replace,
    audit   => $audit::manage_audit,
    noop    => $audit::noops,
  }

  if ($audit::config_file_init_source or $audit::config_file_init_template) {
    file { 'audit.init.conf':
      ensure  => $audit::manage_file,
      path    => $audit::config_file_init,
      mode    => $audit::config_file_mode,
      owner   => $audit::config_file_owner,
      group   => $audit::config_file_group,
      source  => $audit::manage_config_file_init_source,
      content => $audit::manage_config_file_init_template,
      replace => $audit::manage_file_replace,
      audit   => $audit::manage_audit,
      noop    => $audit::noops,
    }
  }

  # The whole audit configuration directory can be recursively overriden
  if $audit::source_dir {
    file { 'audit.dir':
      ensure  => directory,
      path    => $audit::config_dir,
      notify  => $audit::manage_service_autorestart,
      source  => $audit::source_dir,
      recurse => true,
      purge   => $audit::bool_source_dir_purge,
      force   => $audit::bool_source_dir_purge,
      replace => $audit::manage_file_replace,
      audit   => $audit::manage_audit,
      noop    => $audit::noops,
    }
  }
}
