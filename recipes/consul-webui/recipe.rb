class ConsulWebUi < FPM::Cookery::Recipe
    source 'https://releases.hashicorp.com/consul/0.6.1/consul_0.6.1_web_ui.zip' 
    sha256 'afccdd540b166b778c7c0483becc5e282bbbb1ee52335bfe94bf757df8c55efc'

    name 'consul-webui'
    
    version  '0.6.1'
    revision '2'
    def install    	
    	share('consul-webui').install  Dir['./*']
    end

    def build
    end
end
