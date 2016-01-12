class Registrator < FPM::Cookery::Recipe
  source 'file:///vagrant/recipes/registrator/recipe.rb'
  name 'registrator'
  description 'Registers docker containers in consul'
  homepage 'https://github.com/pchojnacki/fpm-recipes'
  
  version  '0.7-v7-dev'
  revision 'wikia1'

  def install
    bin.install workdir("/bin/registrator")
  end

  def build
    ENV['GOPATH'] = workdir("tmp-build/gopath")
    distDir = ENV['GOPATH'] + "/src/github.com/gliderlabs/registrator"

    safesystem('go get github.com/tools/godep')
    safesystem("git clone https://github.com/gliderlabs/registrator.git #{distDir}")
    safesystem("cd #{distDir}; git reset --hard origin/master")
    safesystem("cd #{distDir}; go get")
    safesystem("cd #{distDir}; go build -ldflags \"-X main.Version=#{version}\" -o #{workdir}/bin/registrator")
  end
end
