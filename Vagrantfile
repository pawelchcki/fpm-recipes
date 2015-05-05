require 'pathname'

ROOT = Pathname.new(__FILE__).expand_path.dirname

Vagrant.configure('2') do |config|
  %w{ubuntu1204 ubuntu1404}.each do |host|
    config.vm.define host do |machine|
      machine.vm.provider 'docker' do |docker|
        docker.build_dir = ROOT.join "docker/#{host}"
        docker.build_args = ['--rm=true', "--tag=wikia_fpm_recipes/#{host}"]

        # Avoid leaving unused containers behind.
        docker.create_args = ['--rm=true', '--privileged=true']
      end
    end
  end
end
