Vagrant.configure("2") do |config|
  config.vm.define "centos-ansible"
  config.vm.box = "lubux/centos-ansible"
  config.vm.hostname = "centos-ansible"
  config.vm.boot_timeout = 3600
  config.vm.network "private_network", ip: "192.168.56.101"
  config.vm.network "forwarded_port", guest: 2181, host: 2181
  config.vm.network "forwarded_port", guest: 9092, host: 9092
  config.vm.synced_folder '.', disabled: true
  config.vm.synced_folder 'playbooks', '/home/vagrant/playbooks', type: :virtualbox
  config.vm.synced_folder 'work', '/home/vagrant/work', type: :virtualbox

  config.vm.provider :virtualbox do |vb|
    vb.name = "centos-ansible"
    vb.gui = false
    vb.cpus = 2
    vb.memory = 8192
  end

  if ((!File.file?("#{File.dirname(__FILE__)}/.vagrant/machines/centos-ansible/virtualbox/id") and ARGV.include?('up')) or ARGV.include?('provision') or ARGV.include?('--provision')) and !ARGV.include?('--no-provision')
    print "Nexus username: "
    username = STDIN.gets.chomp
    print "Nexus password: "
    password = STDIN.noecho(&:gets).chomp
    print "\n"

    config.vm.provision "shell" do |s|
      s.inline = "cd ~/playbooks;ansible-playbook setup.yml -i hosts --connection=local --extra-vars \"nexus_username=$1 nexus_password=$2\""
      s.args   = [username, password]
      s.privileged = false
    end
  end

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
end
