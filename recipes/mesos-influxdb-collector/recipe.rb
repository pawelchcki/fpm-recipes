class MesosInfluxDbCollector < FPM::Cookery::Recipe
  source 'file:///vagrant/recipes/mesos-influxdb-collector/recipe.rb'
  name 'mesos-influxdb-collector'
  description 'Saves information provided by mesos and marathon into influxdb'
  homepage 'https://github.com/pchojnacki/fpm-recipes'
  
  version  '0.5.0'
  revision 'wikia1'

  def install
    bin.install workdir("/bin/mesos-influxdb-collector")
    etc('mesos-influxdb-collector').mkdir
    etc('mesos-influxdb-collector').install_p workdir('config.hcl')
    etc('init').install_p workdir('mesos-influxdb-collector.conf')    
  end

  def build
    ENV['GOPATH'] = workdir("tmp-build/gopath")
    distDir = ENV['GOPATH'] + "/src/github.com/kpacha/mesos-influxdb-collector"

    safesystem('go get github.com/tools/godep')
    safesystem("git clone https://github.com/kpacha/mesos-influxdb-collector.git #{distDir}")
    safesystem("cd #{distDir}; git reset --hard 0.5.0")
    safesystem("cd #{distDir}; go get")
    safesystem("cd #{distDir}; go build -o #{workdir}/bin/mesos-influxdb-collector")
  end
end
