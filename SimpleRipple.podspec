Pod::Spec.new do |s|
  s.name             = 'SimpleRipple'
  s.version          = '1.0.0'
  s.summary          = 'A simple ripple effect for any iOS UIView.'

  s.description      = <<-DESC
This pod includes a UIView extension that allows any UIView to show a ripple effect.
                       DESC

  s.homepage         = 'https://github.com/maurodec/SimpleRipple'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mauro de Carvalho' => 'mauro.dec@gmail.com' }
  s.source           = { :git => 'https://github.com/maurodec/SimpleRipple.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'SimpleRipple/**/*'
end
