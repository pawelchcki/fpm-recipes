class PrometheusNodeExporter < FPM::Cookery::Recipe
  source 'https://github.com/prometheus/mesos_exporter/releases/download/0.1.0/mesos_exporter-0.1.0.linux-amd64.tar.gz' 
  sha256 'e38bad9180d91acaf137381c05a2a559c2b2a655cf7f862d3448816b7ce31899'
  
  version  '0.12.0rc1'
  revision '1'

  post_install 'post-install'

  def install
    etc('init').install_p workdir('prometheus-node-exporter.conf')
    bin.install ['node_exporter']
  end

  def build
  end
end
