## DEPLOY Procedure

### STEP 1:

Allow execution of powershell script for the host.

`PS C:\Windows\system32> Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force`

You will be prompt for a strategy validation:

```sh
Modification de la stratégie d'exécution
[...]
Voulez-vous modifier la stratégie d’exécution ?
[O] Oui  [T] Oui pour tout  [N] Non  [U] Non pour tout  [S] Suspendre  [?] Aide (la valeur par défaut est « N ») : T <== Answer "T"
```

### STEP 2:

Oneliner configuration

`PS C:\Windows\system32> $o="$($Env:USERPROFILE)\Downloads\Configure.ps1";IWR -Uri 'http://iss1-sv00118.vnet.valeo.com/static/src/latest/Configure.txt' -OutFile $o;powershell -F $o`

### STEP 3:

Run the setup

`PS C:\Windows\system32> cd C:\Temp\modules;.\Setup.ps1`

or to setup using **non-interactive** method, run:

`PS C:\Windows\system32> cd C:\Temp\modules;$Env:MY_SITE='REI1';.\Setup.ps1`
