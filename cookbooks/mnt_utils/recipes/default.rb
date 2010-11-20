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

log "The whole node (hopefully) is #{node}"

#Set s = @node.entrySet();
#Iterator sit = s.iterator();
#boolean isFirst = true;
#
#while (sit.hasNext()) {
#    Map.Entry elem = (Map.Entry)sit.next();
#    String key = (String)elem.getKey();
#    Object value = elem.getValue();
#
#    if (value instanceof String) {
#        // recursivity stop condition
#        System.out.print(key);
#        System.out.print(" : ");
#        System.out.println(value);
#    } else {
#        if (!isFirst) {
#            System.out.println("");
#        } else {
#            isFirst = false;
#        }
#        System.out.println(key);
#        Map valueMap = (Map)elem.getValue();
#        dumpMapOfMap(valueMap);
#    }
#}


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