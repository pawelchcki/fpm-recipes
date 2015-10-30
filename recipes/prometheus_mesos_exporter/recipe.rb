class PrometheusMesosExporter < FPM::Cookery::Recipe
    source 'https://github.com/prometheus/mesos_exporter/releases/download/0.1.0/mesos_exporter-0.1.0.linux-amd64.tar.gz' 
    sha256 'e38bad9180d91acaf137381c05a2a559c2b2a655cf7f862d3448816b7ce31899'

    name 'prometheus_mesos_exporter'
    
    version  '0.1.0'
    revision '1'
    def install
    	bin.install ['mesos_exporter']
    end

    def build
    end
end
