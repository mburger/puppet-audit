# Puppet module: audit

This is a Puppet module for audit based on the second generation layout ("NextGen") of Example42 Puppet Modules.

Made by Alessandro Franceschi / Lab42

Official site: http://www.example42.com

Official git repository: http://github.com/example42/puppet-audit

Released under the terms of Apache 2 License.

This module requires functions provided by the Example42 Puppi module (you need it even if you don't use and install Puppi)

For detailed info about the logic and usage patterns of Example42 modules check the DOCS directory on Example42 main modules set.


## USAGE - Basic management

* Install audit with default settings

        class { 'audit': }

* Install a specific version of audit package

        class { 'audit':
          version => '1.0.1',
        }

* Disable audit service.

        class { 'audit':
          disable => true
        }

* Remove audit package

        class { 'audit':
          absent => true
        }

* Enable auditing without without making changes on existing audit configuration *files*

        class { 'audit':
          audit_only => true
        }

* Module dry-run: Do not make any change on *all* the resources provided by the module

        class { 'audit':
          noops => true
        }


## USAGE - Overrides and Customizations
* Use custom sources for main config file 

        class { 'audit':
          source => [ "puppet:///modules/example42/audit/audit.conf-${hostname}" , "puppet:///modules/example42/audit/audit.conf" ], 
        }


* Use custom source directory for the whole configuration dir

        class { 'audit':
          source_dir       => 'puppet:///modules/example42/audit/conf/',
          source_dir_purge => false, # Set to true to purge any existing file not present in $source_dir
        }

* Use custom template for main config file. Note that template and source arguments are alternative. 

        class { 'audit':
          template => 'example42/audit/audit.conf.erb',
        }

* Automatically include a custom subclass

        class { 'audit':
          my_class => 'example42::my_audit',
        }


## USAGE - Example42 extensions management 
* Activate puppi (recommended, but disabled by default)

        class { 'audit':
          puppi    => true,
        }

* Activate puppi and use a custom puppi_helper template (to be provided separately with a puppi::helper define ) to customize the output of puppi commands 

        class { 'audit':
          puppi        => true,
          puppi_helper => 'myhelper', 
        }

* Activate automatic monitoring (recommended, but disabled by default). This option requires the usage of Example42 monitor and relevant monitor tools modules

        class { 'audit':
          monitor      => true,
          monitor_tool => [ 'nagios' , 'monit' , 'munin' ],
        }

* Activate automatic firewalling. This option requires the usage of Example42 firewall and relevant firewall tools modules

        class { 'audit':       
          firewall      => true,
          firewall_tool => 'iptables',
          firewall_src  => '10.42.0.0/24',
          firewall_dst  => $ipaddress_eth0,
        }


## CONTINUOUS TESTING

Travis {<img src="https://travis-ci.org/example42/puppet-audit.png?branch=master" alt="Build Status" />}[https://travis-ci.org/example42/puppet-audit]
