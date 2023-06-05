# Define an application-wide HTTP permissions policy. For further
# information see https://developers.google.com/web/updates/2018/06/feature-policy
# https://github.com/w3c/webappsec-permissions-policy/blob/master/features.md#policy-controlled-features
# ActionDispatch::PermissionsPolicy.const_get(:DIRECTIVES)
#
Rails.application.config.permissions_policy do |f|
  f.accelerometer      :none
  f.autoplay           :self
  f.camera             :none
  f.fullscreen         :self
  f.gyroscope          :none
  f.magnetometer       :none
  f.microphone         :none
  f.payment            :none
  f.picture_in_picture :none
  f.midi               :none
  f.usb                :none
  f.vr                 :none
end
