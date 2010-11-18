# Handy DCPROMO answer file templates http://support.microsoft.com/kb/947034

answers_file = "C:\\answers.txt"

template answers_file do
  source "answers_demote.txt.erb"
end

powershell "Demote AD" do
  powershell_script = <<'POWERSHELL_SCRIPT'
  start-process -FilePath "$env:windir\Sysnative\dcpromo.exe" -ArgumentList /answer:C:\answers.txt -Wait

  del "C:\answers.txt"
POWERSHELL_SCRIPT

  source(powershell_script)
end