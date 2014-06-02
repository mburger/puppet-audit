# Class: audit::service
#
# This class manages audit service
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
class audit::service {

  service { 'audit':
    ensure     => $audit::manage_service_ensure,
    name       => $audit::service,
    enable     => $audit::manage_service_enable,
    hasstatus  => $audit::service_status,
    pattern    => $audit::process,
    noop       => $audit::noops,
  }
}
