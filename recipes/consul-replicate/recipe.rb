class ConsulReplicate < FPM::Cookery::Recipe
    source 'https://github.com/hashicorp/consul-replicate/releases/download/v0.2.0/consul-replicate_0.2.0_linux_amd64.tar.gz' 
    sha256 'cc94f3b9638ff5bade91c1d8c3f49b50cdc04509981c2a1acd57f45963b9239e'

    name 'consul-replicate'
    
    version  '0.2.0'
    revision '1'
    def install
    	bin.install ['consul-replicate']
    end

    def build
    end
end
