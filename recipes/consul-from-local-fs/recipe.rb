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
    ENV['PATH'] = ENV['PATH'] + ":" + ENV['GOPATH'] + "/bin"
    ENV['XC_ARCH'] = "amd64"
    ENV['XC_OS'] = "linux"

    consul_dir = workdir("gopath/src/github.com/hashicorp/consul")
    safesystem("git clone https://github.com/hashicorp/consul.git #{consul_dir} || true")
    safesystem("cd #{consul_dir} && git reset --hard v0.6.3")
    safesystem("mkdir Godeps && cp #{consul_dir}/deps/v0-6-3.json Godeps/Godeps.json")
    safesystem("godep restore")
    safesystem("cd #{consul_dir} && git apply #{workdir("0001-Wikia-Consul-tunings.patch")}")
    safesystem("cd #{consul_dir} && make bin")
  end
end
