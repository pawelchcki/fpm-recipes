class PrometheusMesosExporter < FPM::Cookery::Recipe
    source "file:///vagrant/recipes/prometheus-mesos-exporter/prometheus-mesos-exporter.conf"
    name 'prometheus-mesos-exporter'
    
    version  '0.1.0'
    revision 'wikia1'
    post_install 'post-install'

    def install
        etc('init').install_p workdir('prometheus-mesos-exporter.conf')
    	bin.install [File.join(workdir("gopath"), "bin/mesos_exporter")]
    end
  def build
    ENV['GOPATH'] = workdir("gopath")
    #TODO: pin the build to some specific version
    safesystem("go get github.com/prometheus/mesos_exporter")
  end
end
