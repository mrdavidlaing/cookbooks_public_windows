log "Hello World"
log "This here server is #{@node[:rs_server_name]}"

powershell "Printing some stuff" do
  powershell_script = <<'EOF'
  echo "$env:windir\Sysnative"
  if(Test-Path "$env:windir\Sysnative\dcpromo.exe") {
    echo "THAAAARR SHE BLOWS!!"
  }
EOF
  source(powershell_script)
end
#
#server_collection "servers" do
#  tags ["rs_monitoring:*"]
#end
#
#@node[:server_collection]["servers"].each do | server |
#  log "Has EC2 attribute was " + server.attribute?("ec2")
#end


#
#powershell "Just some PS stuff for now" do
#  @node[:server_collection]["servers"].each do | server |
#    #server[:ec2][:local_ipv4]
#  end
#
#  powershell_script = <<'POWESHELL_SCRIPT'
#  echo 'something'
#POWESHELL_SCRIPT
#
#  source(powershell_script)
#end