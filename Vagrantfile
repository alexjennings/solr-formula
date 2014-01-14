Vagrant.configure("2") do |config|
  config.vm.box = "precise64.box"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :public_network
  config.vm.synced_folder ".", "/srv/salt/"

  config.vm.provider :virtualbox do |vb|
  end


  config.vm.define :vagrantsolr1 do |vagrantsolr1|
    vagrantsolr1.vm.hostname = "vagrant-solr1"
    vagrantsolr1.vm.network :private_network, ip:"192.168.0.31"
  end

  config.vm.define :vagrantsolr2 do |vagrantsolr2|
    vagrantsolr2.vm.hostname = "vagrant-solr2"
    vagrantsolr2.vm.network :private_network, ip:"192.168.0.32"
  end

  config.vm.provision :salt do |salt|
    salt.run_highstate = true
    salt.minion_config = "minion"
    salt.verbose = true
  end

end
