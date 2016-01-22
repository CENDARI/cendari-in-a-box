# vi: set ft=ruby :
#
# prefer vagrant.pp over default site.pp
if File.exist?("manifests/vagrant.pp")
  manifestfile = "vagrant.pp"
else
  manifestfile = "site.pp"
end

Vagrant.configure(2) do |config|

  config.vm.define "box" do |box|
    box.vm.box = "dariah-trusty64"
    box.vm.box_url = "http://ci.de.dariah.eu/dariah-vagrant/dariah-trusty/metadata.json"
    box.vm.hostname = "box.cendari.local"
    box.vm.network :private_network, ip: "192.168.33.55"
    box.ssh.forward_agent = true
    box.ssh.insert_key = false
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
      config.cache.auto_detect = true
      config.cache.enable :apt
    end
    box.vm.provision "puppet" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file = manifestfile
      puppet.module_path = ["site","modules"]
      puppet.hiera_config_path = "vagrantdata/hiera.yaml"
      puppet.options = "--environment cendari_local --verbose --show_diff"
      puppet.working_directory = "/vagrant"
    end
    box.vm.provider :virtualbox do |vb|
      vb.name = "cendari-in-a-box"
      vb.memory = 2048
      vb.customize ["modifyvm", :id, "--nictype1", "Am79C973"]
      vb.customize ["modifyvm", :id, "--nictype2", "Am79C973"]
    end
    if Vagrant.has_plugin?("vagrant-vbguest")
      config.vbguest.auto_update = false
    end
  end

end

