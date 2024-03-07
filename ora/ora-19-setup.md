## DEPLOY Procedure

Open a Powershell terminal with Administrator privileges.
From this shell open the Task Manager:

`PS C:\Windows\System32> taskmgr`

### STEP 1:

~~Allow execution of powershell script for the host.~~

~~`PS C:\Temp> Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force`~~

~~You will be prompt for a strategy validation:~~

```sh
Modification de la stratégie d'exécution
[...]
Voulez-vous modifier la stratégie d’exécution ?
[O] Oui  [T] Oui pour tout  [N] Non  [U] Non pour tout  [S] Suspendre  [?] Aide (la valeur par défaut est « N ») : T <== Answer "T"
```

### STEP 2:

Oneliner configuration

`PS C:\Temp> $o="$($Env:USERPROFILE)\Downloads\Configure.ps1";IWR -Uri 'http://iss1-sv00118.vnet.valeo.com/static/src/latest/Configure.txt' -OutFile $o;Unblock-File $o;powershell -F $o`

### STEP 3:

Run the setup

`PS C:\Temp> cd C:\Temp\modules;.\Setup.ps1`

or to setup using **non-interactive** method, run:

*Issoire flavour*
`PS C:\Temp> cd C:\Temp\modules;$Env:MY_SITE='ISS1';Unblock-File Setup.ps1;.\Setup.ps1`

*Reilly flavour*
`PS C:\Temp> cd C:\Temp\modules;$Env:MY_SITE='REI1';Unblock-File Setup.ps1;.\Setup.ps1`
