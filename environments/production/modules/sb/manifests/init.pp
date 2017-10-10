class sb {
  notify { 'Hello World!': }


  #$packages = [ 'php7.0', 'libapache2-mod-php7.0', 'php7.0-mcrypt', 'php7.0-mbstring']

  #package { $packages :
  #  ensure => 'present',
  #}

  # Clone Service B code from Github
  vcsrepo { '/var/www/html/serviceb/serviceb':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/2dv514-grupp3/serviceb',
  }

  # Install Apache Web Server
  class { 'apache':
    default_vhost => false,
    mpm_module => 'prefork'
  }

  # Add support for PHP in Apache
  class {'::apache::mod::php': }

  # Add vhost for Service B
  apache::vhost { 'sb.acme.example.com':
    port    => '80',
    docroot => '/var/www/html/serviceb/serviceb/public',
    override => 'All',
  }

  # Enable rewrite module to handle routing in Laravel
  class { 'apache::mod::rewrite' : }

}
