class DockerRegistry < FPM::Cookery::Recipe
  source 'file:///vagrant/recipes/docker-registry/recipe.rb'
  name 'docker-registry'
  description 'DockerRegistry dep package'
  homepage 'https://github.com/pchojnacki/fpm-recipes'
  
  version  '2.1.1'
  revision 'wikia2'

  # post_install 'post-install'
  # pre_install 'pre-install'
  # pre_uninstall 'pre-uninstall'

  def install
    bin.install workdir("tmp-build/bin/registry")
    # bin.install workdir('gopath/bin/consul')
    # etc('consul.d').mkdir
    # etc('init').install_p workdir('consul.conf')
    etc('docker/registry').mkdir     
    var('/var/lib/registry').mkdir
  end

  def build
    ENV['GOPATH'] = workdir("tmp-build/gopath")
    distDir = ENV['GOPATH'] + "/src/github.com/docker/distribution"

    safesystem('go get github.com/tools/godep')
    safesystem("git clone https://github.com/lorieri/distribution.git #{distDir}")
    safesystem("cd #{distDir}; git reset --hard radosgw")
    safesystem("cd #{distDir}; GOPATH=`$GOPATH/bin/godep path`:$GOPATH make PREFIX=#{workdir("tmp-build")} binaries")
  end
end
