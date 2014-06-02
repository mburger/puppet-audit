# Class: audit::install
#
# This class installs audit
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
class audit::install {

  package { $audit::package:
    ensure  => $audit::manage_package,
    noop    => $audit::noops,
  }
}
