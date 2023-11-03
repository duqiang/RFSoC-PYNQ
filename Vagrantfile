Vagrant.configure("2") do |config|
	# Based on Ubuntu focal64; this is the default VM
	# run `vagrant up focal`
	config.vm.define "focal", primary: true do |focal|
		focal.vm.box = "ubuntu/focal64"
        focal.vm.synced_folder ".", "/pynq", 
			owner: "vagrant", group: "vagrant"
		# assume Vivado, Vitis and Petalinux are installed at /opt/xilinx_2022.1
        focal.vm.synced_folder "/opt/xilinx_2022.1", "/opt/xilinx_2022.1", 
			owner: "vagrant", group: "vagrant"
		focal.vm.provider "virtualbox" do |vb|
			vb.gui = false
			vb.name = "pynq_ubuntu_20_04"
			vb.memory = "8192"
			vb.customize ["modifyvm", :id, "--vram", "128"]
			vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
			disk_image = File.join(File.dirname(File.expand_path(__FILE__)), 
				'ubuntu_20_04.vdi')
			unless File.exist?(disk_image)
			vb.customize ['createhd', 
						'--filename', disk_image, 
						'--size', 160 * 1024]
			end
			vb.customize ['storageattach', :id, 
						  '--storagectl', 'SCSI', 
						  '--port', 2, '--device', 0, 
						  '--type', 'hdd', 
						  '--medium', disk_image]
			vb.customize ['storageattach', :id, 
						  '--storagectl', 'IDE', 
						  '--port', '0', '--device', '1', 
						  '--type', 'dvddrive', 
						  '--medium', 'emptydrive']
		end

		focal.vm.provision "shell", inline: <<-SHELL
			parted /dev/sdc mklabel msdos
			parted /dev/sdc mkpart primary 100 100%
			partprobe
			mkfs.xfs /dev/sdc1
			mkdir /workspace
			echo `blkid /dev/sdc1 | awk '{print$2}' | sed -e 's/"//g'` \
				/workspace   xfs   noatime   0   0 >> /etc/fstab
			mount /workspace
			chown -R vagrant:vagrant /workspace
			# chmod 777 -R /workspace
		SHELL

		focal.vm.provision "shell",
			inline: "apt-get update"

		focal.vm.provision "shell", 
			inline: "/bin/bash /pynq/setup_host.sh"

		focal.vm.provision "shell", 
			inline: "apt-get install -y --force-yes ubuntu-desktop"

		focal.vm.provision "shell", inline: <<-SHELL
			cat /root/.profile | grep PATH >> /home/vagrant/.profile
		SHELL
	end
end
