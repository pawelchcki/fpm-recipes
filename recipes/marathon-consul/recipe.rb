class MarathonConsul < FPM::Cookery::Recipe
  source 'file:///vagrant/recipes/marathon-consul/recipe.rb'
  name 'marathon-consul'
  description 'Registers docker containers in consul'
  homepage 'https://github.com/pchojnacki/fpm-recipes'
  
  version  '0.2.1'
  revision 'wikia1'

  def install
    bin.install workdir("/bin/marathon-consul")
  end

  def build
    ENV['GOPATH'] = workdir("tmp-build/gopath")
    distDir = ENV['GOPATH'] + "/src/github.com/allegro/marathon-consul"

    safesystem('go get github.com/tools/godep')
    safesystem("git clone https://github.com/allegro/marathon-consul.git #{distDir}")
    safesystem("cd #{distDir}; git reset --hard origin/master")
    safesystem("cd #{distDir}; go get")
    safesystem("cd #{distDir}; go build -o #{workdir}/bin/marathon-consul")
  end
end
