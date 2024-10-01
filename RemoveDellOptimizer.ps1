#stop dell optimizer services
Get-Service -Name "DellOptimizer" | Stop-Service

#Get Dell Optimizer from registry
$Remover = get-itemproperty 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' | Where-Object { $PSitem.DisplayName -match "optimizer service"}

#get the uninstall string for dell optimizer
$uninstring = $Remover.UninstallString

#add the silent parameter and run throguh cmd to uninstall
cmd /c $uninstring -silent