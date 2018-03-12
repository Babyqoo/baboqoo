Pod::Spec.new do |spec|
  spec.name         = 'Gbbq'
  spec.version      = '{{.Version}}'
  spec.license      = { :type => 'GNU Lesser General Public License, Version 3.0' }
  spec.homepage     = 'https://github.com/babyqoo/baboqoo'
  spec.authors      = { {{range .Contributors}}
		'{{.Name}}' => '{{.Email}}',{{end}}
	}
  spec.summary      = 'iOS Baboqoo Client'
  spec.source       = { :git => 'https://github.com/babyqoo/baboqoo.git', :commit => '{{.Commit}}' }

	spec.platform = :ios
  spec.ios.deployment_target  = '9.0'
	spec.ios.vendored_frameworks = 'Frameworks/Gbbq.framework'

	spec.prepare_command = <<-CMD
    curl https://gbbqstore.blob.core.windows.net/builds/{{.Archive}}.tar.gz | tar -xvz
    mkdir Frameworks
    mv {{.Archive}}/Gbbq.framework Frameworks
    rm -rf {{.Archive}}
  CMD
end
