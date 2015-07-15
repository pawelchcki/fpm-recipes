class Consul < FPM::Cookery::Recipe
  source 'file:///vagrant/recipes/consul-from-local-fs/consul' 
  name 'consul'
  description 'Consul with TCP fallback backport, package built using https://github.com/pchojnacki/fpm-recipes'
  homepage 'https://github.com/pchojnacki/fpm-recipes'
  
  version  '0.5.2'
  revision 'wikia4'

  post_install 'post-install'
  pre_install 'pre-install'
  pre_uninstall 'pre-uninstall'


  def install
    bin.install ['consul']
    etc('consul.d').mkdir
    etc('init').install_p workdir('consul.conf')
    var('lib/consul').mkdir
  end

  def build
  end
end
