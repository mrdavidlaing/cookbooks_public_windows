# TODO: Find a nice way to do this in either boot or operational scripts, this method only works for boot
unless @node[:mnt_utils_hostname_set]
  powershell "Set the computer hostname to the same as the RightScale nickname" do
    parameters({'RS_SERVER_NAME' => @node[:mnt_utils][:rs_server_name]})

    powershell_script = <<'EOF'
    $programFilesPath = "C:\Program Files"
    echo "The progam files dir is set to $programFilesPath"
    $ec2ConfigFile = "$programFilesPath\Amazon\Ec2ConfigService\Settings\config.xml"
    [xml]$ec2configXml = get-content $ec2ConfigFile
    $compNameNode = $ec2ConfigXml.SelectSingleNode("/Ec2ConfigurationSettings/Plugins/Plugin[Name='Ec2SetComputerName']")
    $compNameNode.State = 'Disabled'
    if (Test-Path "$programFilesPath\Amazon\Ec2ConfigService\Settings\config.xml.bak") {
      del "$programFilesPath\Amazon\Ec2ConfigService\Settings\config.xml.bak"
    }
    move $ec2ConfigFile "$programFilesPath\Amazon\Ec2ConfigService\Settings\config.xml.bak"
    $ec2ConfigXml.save($ec2ConfigFile)

    $NewComputerName = $env:RS_SERVER_NAME
    $computerinfo = Get-WmiObject -class win32_computersystem
    $computerinfo.Rename($NewComputerName)
    # Don't forget to reboot when you're done!
EOF

    source(powershell_script)
  end

  @node[:mnt_utils_hostname_set] = true

  include_recipe 'utilities::system_reboot'
end