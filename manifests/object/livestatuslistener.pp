# == Defined type: icinga2::object::livestatuslistener
#
# This is a defined type for Icinga 2 apply objects that create Livestatus Listener
# See the following Icinga 2 doc page for more info:
# http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-livestatuslistener
#
# === Parameters
#
# See the inline comments.
#

define icinga2::object::livestatuslistener (
  $ensure                         = 'file',
  $object_livestatuslisternername = $name,
  $socket_type                    = undef,
  $bind_host                      = undef,
  $bind_port                      = undef,
  $socket_path                    = undef,
  $compat_log_path                = undef,
  $target_dir                     = '/etc/icinga2/objects/livestatuslistener',
  $target_file_name               = "${name}.conf",
  $target_file_owner              = 'root',
  $target_file_group              = 'root',
  $target_file_mode               = '0644'
) {

  #Do some validation of the class' parameters:
  if $object_livestatuslisternername {
    validate_string($object_livestatuslisternername)
  }
  if $socket_type {
    validate_string($socket_type)
  }
  if $bind_host {
    validate_string($bind_host)
  }
  if $bind_port {
    validate_string($bind_port)
  }
  if $socket_path {
    validate_string($socket_path)
  }
  if $compat_log_path {
    validate_string($compat_log_path)
  }
  validate_string($target_dir)
  validate_string($target_file_name)
  validate_string($target_file_owner)
  validate_string($target_file_group)
  validate_re($target_file_mode, '^\d{4}$')


  file {"${target_dir}/${target_file_name}":
    ensure  => $ensure,
    owner   => $target_file_owner,
    group   => $target_file_group,
    mode    => $target_file_mode,
    content => template('icinga2/object_livestatuslistener.conf.erb'),
    notify  => Service['icinga2'],
  }

}
