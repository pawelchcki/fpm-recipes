class PrometheusNodeExporter < FPM::Cookery::Recipe
    source 'https://github.com/prometheus/node_exporter/releases/download/0.12.0rc1/node_exporter-0.12.0rc1.linux-amd64.tar.gz' 
    sha256 'a68d188c994740e5a4d10fb2dfde3628f8979977cd3ce798cfc9f1e1b4968bce'

    name 'prometheus_node_exporter'
    
    version  '0.12.0rc1'
    revision '1'

    post_install 'post-install'

    def install
        etc('init').install_p workdir('prometheus_node_exporter.conf')
    	bin.install ['node_exporter']
    end

    def build
    end
end
