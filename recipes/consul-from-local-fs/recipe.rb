class Consul < FPM::Cookery::Recipe
  source 'file:///vagrant/recipes/consul-from-local-fs/consul'
  name 'consul'
  description 'Consul with TCP fallback backport, package built using https://github.com/pchojnacki/fpm-recipes'
  homepage 'https://github.com/pchojnacki/fpm-recipes'
  
  version  '0.6.3'
  revision 'wikia1'

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
    # workdir('/vagrant')
    # mkdir_p('build')
    # workdir('/vagrant/build')
    safesystem("chmod +x /usr/local/bin/godep")
    safesystem('curl -sSL https://github.com/hashicorp/consul/archive/v0.6.3.tar.gz | tar --strip-components 1 -xzf  -')
    safesystem("mkdir Godeps && cp deps/v0-6-3.json Godeps/Godeps.json")
    safesystem("mkdir #{workdir("gopath")}/src/github.com/hashicorp; ln -s #{builddir} #{workdir("gopath")}/src/github.com/hashicorp/consul || true")
    safesystem("godep restore")
    safesystem("cd #{workdir("gopath")}/src/github.com/hashicorp/consul && make")
    # safesystem('cd /vagrant; git submodule update --init --recursive')
    # safesystem("cd /vagrant; git submodule foreach git reset --hard")
    # safesystem("cd $GOPATH/src/github.com/hashicorp/consul; git apply #{workdir("0001-Change-configs-to-reduce-the-chance-of-node-being-ma.patch")}")
    # safesystem('cd $GOPATH/src/github.com/hashicorp/consul; make')
    # safesystem("cd /vagrant; git submodule foreach git reset --hard") # cleanup after self
  end
end
