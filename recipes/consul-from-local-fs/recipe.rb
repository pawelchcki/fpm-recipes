class Consul < FPM::Cookery::Recipe
  source 'file:///vagrant/recipes/consul-from-local-fs/consul.conf'
  name 'consul'
  description 'Consul with TCP fallback backport, package built using https://github.com/pchojnacki/fpm-recipes'
  homepage 'https://github.com/pchojnacki/fpm-recipes'
  
  version  '0.5.2'
  revision 'wikia7'

  post_install 'post-install'
  pre_install 'pre-install'
  pre_uninstall 'pre-uninstall'

  def install
    bin.install workdir('gopath/bin/consul')
    etc('consul.d').mkdir
    etc('init').install_p workdir('consul.conf')
    var('lib/consul').mkdir
  end

  def build
    ENV['GOPATH'] = workdir("gopath")
    safesystem('cd /vagrant; git submodule update --init --recursive')
    safesystem('cd $GOPATH/src/github.com/hashicorp/consul; make')
  end
end
