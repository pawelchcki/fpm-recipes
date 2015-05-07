class ConsulWikiaTools < FPM::Cookery::Recipe
    builddir="/gopath/src"

    source 'file:///vagrant/recipes/consul-wikia-tools/tools/' 
    name 'consul-wikia-tools'

    version  '0.0.1'
    revision '1'

    def install
    	bin.install ["tools/consul_url"]
    end

    def build        
        safesystem("go get github.com/hashicorp/consul/api")
        safesystem("go build -i tools/consul_url.go")
    end
end
