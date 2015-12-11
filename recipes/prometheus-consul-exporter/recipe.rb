class PrometheusConsulExporter < FPM::Cookery::Recipe
    source "file:///vagrant/recipes/prometheus-consul-exporter/prometheus-consul-exporter.conf"
    name 'prometheus-consul-exporter'
    
    version  '0.2.0'
    revision 'wikia1'
    post_install 'post-install'

    def install
        etc('init').install_p workdir('prometheus-consul-exporter.conf')
    	bin.install [File.join(workdir("gopath"), "bin/consul_exporter")]
    end
  def build
    ENV['GOPATH'] = workdir("gopath")
    #TODO: pin the build to some specific version
    safesystem("go get github.com/prometheus/consul_exporter")
  end
end
