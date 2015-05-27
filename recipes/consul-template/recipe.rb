class ConsulTemplate < FPM::Cookery::Recipe
    source 'http://github.com/hashicorp/consul-template/releases/download/v0.9.0/consul-template_0.9.0_linux_amd64.tar.gz' 
    sha256 '3d8c9fcaee18a4369cc731528ce9d6a5be03d88b954a2fea0f4406fc54c70fc8'

    name 'consul-template'
    
    version  '0.9.0'
    revision '1'
    def install
    	bin.install ['consul-template']
    end

    def build
    end
end
