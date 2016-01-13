class Consul < FPM::Cookery::Recipe
    source 'https://releases.hashicorp.com/consul/0.6.1/consul_0.6.1_linux_amd64.zip' 
    sha256 'dbb3c348fdb7cdfc03e5617956b243c594a399733afee323e69ef664cdadb1ac'

    name 'consul'
    
    version  '0.6.1'
    revision '1'
    def install
    	bin.install ['consul']
    end

    def build
    end
end
