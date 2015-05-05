require 'pathname'

ROOT = Pathname.new(__FILE__).expand_path.dirname


Vagrant.configure('2') do |config|
  config.vm.define 'ubuntu1204' do |machine|
    machine.vm.provider 'docker' do |docker|
      docker.build_dir = ROOT.join 'docker/ubuntu1204'
      docker.build_args = ['--rm=true', '--tag=wikia/fpm-recipes/ubuntu:12.04']

      # Avoid leaving unused containers behind.
      docker.create_args = ['--rm=true']
    end
  end
end
