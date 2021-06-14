$root_directory = "D:\dev\70-Vbox\Vagrant\Gemini"
$url = "file:///d:/dev/70-vbox/Vagrant/Gemini/"

Push-Location
Set-Location $root_directory
$date = Get-Date -Format "yyyyMMdd"
$image = "dockermaster_$date" 
$box  =  "$image.box"

Write-Host "----------------------------------------------------------------------------------------------------------------------"
Write-Host "WeatherDB - Automation - Backup DockerMaster image"
Write-Host "----------------------------------------------------------------------------------------------------------------------"

# Clean image extra files
Write-Host "Clean current image..."

vagrant ssh dockermaster -c "sudo yum clean all -y"
vagrant ssh dockermaster -c "sudo dd if=/dev/zero of=/EMPTY bs=1M"
vagrant ssh dockermaster -c "sudo rm -f /EMPTY"

# Stop vagrant image
Write-Host "Halt current image..."
vagrant halt dockermaster

# Create vagrant image
Write-Host "Create vagrant image/box pair : $image/$box"
vagrant package dockermaster --output $box --vagrantfile vagrantfile

# Add to box repository
Write-Host "Add box to vagrant repo..."
vagrant box add --name $image $box
vagrant box add $image $url/$box

# Update vagrantfile with new image name.
Write-Host "Replace Dockermaster image name to $image"
((Get-Content -path $root_directory\Vagrantfile_TPL -Raw) -replace "ring.dockermaster","$image") | Set-Content -Path $root_directory\Vagrantfile

# Stop vagrant image
Write-Host "Restart current image..."
vagrant up dockermaster

Write-Host "Automation ends here..."
Write-Host "----------------------------------------------------------------------------------------------------------------------"
Pop-Location