class ConsulTemplate < FPM::Cookery::Recipe
    source 'https://github.com/hashicorp/consul-template/releases/download/v0.10.0/consul-template_0.10.0_linux_amd64.tar.gz' 
    sha256 'ef298a2ae54cf51dbfc4108194299a9055b252ff9b917e7dd40c72fa30820096'

    name 'consul-template'
    
    version  '0.10.0'
    revision 'wikia1'
    def install
        bin.install ['consul-template']
    end

    def build
    end
end
