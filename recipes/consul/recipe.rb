class Consul < FPM::Cookery::Recipe
    source 'https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip' 
    sha256 '171cf4074bfca3b1e46112105738985783f19c47f4408377241b868affa9d445'

    name 'consul'
    
    version  '0.5.2'
    revision '1'
    def install
    	bin.install ['consul']
    end

    def build
    end
end
