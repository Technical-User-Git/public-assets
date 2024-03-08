## DEPLOY Procedure

Open a Powershell terminal with Administrator privileges.
From this shell open the Task Manager:

`PS C:\Windows\System32> taskmgr`

### :arrow_forward: STEP 1:

Oneliner configuration

`PS C:\Windows\System32> $o="$($Env:USERPROFILE)\Downloads\Configure.ps1";IWR -Uri 'http://iss1-appserver-mis.vnet.valeo.com/static/src/latest/Configure.txt' -OutFile $o;Unblock-File $o;powershell -F $o`

### :arrow_forward: STEP 2:

Run the setup using **non-interactive** method accordingly to your site:

***Issoire** flavour*
`PS C:\Windows\System32> cd C:\Temp\modules;$Env:MY_SITE='ISS1';Unblock-File Setup.ps1;.\Setup.ps1`

***Reilly** flavour*
`PS C:\Windows\System32> cd C:\Temp\modules;$Env:MY_SITE='REI1';Unblock-File Setup.ps1;.\Setup.ps1`
