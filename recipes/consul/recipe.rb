class Consul < FPM::Cookery::Recipe
    source 'https://releases.hashicorp.com/consul/0.6.1/consul_0.6.1_linux_amd64.zip' 
    sha256 'dbb3c348fdb7cdfc03e5617956b243c594a399733afee323e69ef664cdadb1ac'

    name 'consul'
    
    version  '0.6.1'
    revision '2'

    post_install 'post-install'
    pre_install 'pre-install'
    pre_uninstall 'pre-uninstall'

    def install
        bin.install ['consul']
        etc('consul.d').mkdir
        etc('init').install_p workdir('consul.conf')
        var('lib/consul').mkdir
        etc('init').install_p workdir('consul.conf')
    end

    def build
    end
end
