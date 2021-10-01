<#
   ? A Custom Powershell script. Will run on every start up on this system.
#>


<#
   Makes sure oh-my-posh is active in the new terminal.
#>
Import-Module oh-my-posh
<#
   makes sure posh has git support.
#>
Import-Module posh-git
<#
   Sets my posh theme on load.
#>
Set-PoshPrompt -Theme M365Princess
<#
   Will always load into the desktop dir and not root user.
#>
cd desktop
<#
   Custom Message for fun!
#>
echo "Your Terminal is ready ThatGuyjamal! Happy coding, enjoy your day ^~^"
