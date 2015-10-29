class Prometheus < FPM::Cookery::Recipe
    source 'https://github.com/prometheus/prometheus/releases/download/0.16.1/prometheus-0.16.1.linux-amd64.tar.gz' 
    sha256 '596329f13f250846468a0f4eca027bce466b46b976c9ff6d3abc4829745d9815'

    name 'prometheus'
    
    version  '0.16.1'
    revision '1'
    def install
        bin.install ['prometheus', 'promtool']
        share('prometheus').install %w( consoles console_libraries )

    end

    def build
    end
end
