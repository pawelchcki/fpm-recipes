class Consul < FPM::Cookery::Recipe
    source 'file:///vagrant/recipes/consul-from-local-fs/consul' 
    name 'consul'
    
    version  '0.5.2'
    revision 'wikia2'
    def install
    	bin.install ['consul']
    end

    def build
    end
end
