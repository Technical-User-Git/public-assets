---
tags: oracle, client19
---

# Oracle Full Client 19.3 Dual Arch. x86 and x64

***Note:*** *with Windows 10 x64, the oracle registry keys are stored in:*
- **`HKEY_LOCAL_MACHINE\SOFTWARE\Oracle (for 64bit application data)`** 
- **`HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\ORACLE (for 32bit application data)`**

```diff
- To perform a clean install the deployment should be done on a fresh and running version of Windows 10,
- with no previous installation of Oracle Full Client nor Instantclient.
```

# 1. x86 Client install

**[+] Step 1**: Create the **Oracle base** folder

Open a powershell terminal and run the command: 

:arrow_forward: **`mkdir C:\Oracle`**

:arrow_forward: **`mkdir C:\Temp\Oracle`**

**[+] Step 2**: Get the installer source files

**2.1** - Download the source from the infraserver

In your running terminal enter the commands:

```ps=
If (([System.Net.Dns]::GetHostName()).split('-')[0] -eq 'ISS1') { $MyInfraServer='ISS1-SV00091' } Elseif (([System.Net.Dns]::GetHostName()).split('-')[0] -eq 'REI1') { $MyInfraServer='REI1-SV00301' }

$MyGuids='{b3958201-c674-4e2f-bfdd-2fd55c091207}','{d104d5ba-67dc-4bf9-9615-fa201beee4f0}'

foreach ($c in $MyGuids) { Copy-Item -Path \\$MyInfraServer\pkgsvrhoste$\$c\cache\* -Destination c:\Temp\Oracle -Recurse }
```

Place yourself in **`C:\Temp\Oracle`**.

:arrow_forward: **`cd C:\Temp\Oracle`** to enter the source folder

:arrow_forward: **`Get-ChildItem .\Client32`** to list the content of Client32 folder

The last command will list 5 files and 3 directories:

```shell=
PS C:\temp\Oracle\Client32> Get-ChildItem .\Client32


    Répertoire : C:\temp\Oracle\Client32


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        23/08/2023     13:38                install
d-----        23/08/2023     13:38                response
d-----        23/08/2023     13:38                stage
-a----        10/07/2023     17:51           1266 CORP-Oracle-Customization_x32-19.3.vbs
-a----        10/07/2023     17:54            573 desinstall_OraClient19x32_Valeo.rsp
-a----        06/06/2019     22:04         224608 setup.exe   <-- here is the Oracle client installer
-a----        06/06/2019     22:04             78 setup.ini
-a----        06/06/2019     22:03            514 welcome.html
```

**[+] Step 2**: Run the client installer

In your terminal session, run the setup executable:

:arrow_forward: **`.\Client32\setup.exe ORACLE_HOME_NAME=OraClient19Home1_32bit -waitforcompletion -responseFile "C:\Temp\Oracle\Client32\response\clientx32_install19c_Valeo.rsp" -force -silent -noconsole -ignorePrereq`** 

The setup is launched, it will run silently so you won't see any progression. Just be patient it will take 2 or 3 minutes...

You can monitor the execution by having a look at the **task manager**: under the main process of your powershell terminal you will find some child processes for the **setup.exe** you just ran and the **oui.exe** (oracle universal installer). Once both child processes will disappear you can consider that this step of the setup is complete.

![task_mgr](https://technical-user-git.github.io/hosted-img/ora/oui_task_manager.png)

To check for the completion, you can have have a look to Oracle base directory **`C:\Oracle\Client32`** and verify that size of **`Clientx32-19.3.0`** folder is more or less **`1.3 Go`** 

:point_right: **Summary:**

![setup](https://technical-user-git.github.io/hosted-img/ora/ora_home_name_x86.png)

**[+] Step 3**: Run the Visual Basic script

It will fix the permission properties on ORACLE_BASE and generate all environment variables.

In your terminal session, run the script **`CORP-Oracle-Customization_x32-19.3.vbs`**:

:arrow_forward: **`cscript.exe .\Client32\CORP-Oracle-Customization_x32-19.3.vbs`**


:point_right: **Summary:**

![setup](https://technical-user-git.github.io/hosted-img/ora/ora_home_name_x86_vbs_script.png)

Once client32 install is done, you can close the powershell terminal.


# 2. x64 Client install

[+] Step 1: Get the installer source files

Open a **new** powershell terminal. 

At this point you already have downloaded the source files.

Ensure you are in **`C:\Temp\Oracle`**.

:arrow_forward: **`cd C:\Temp\Oracle`** to enter the source folder

:arrow_forward: **`Get-ChildItem .\Client64`** to list the content of Client64 folder

The last command will list 5 files and 3 directories:

```shell=
PS C:\temp\Oracle> Get-ChildItem .\Client64


    Répertoire : C:\temp\Oracle\Client64


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
d-----        23/08/2023     13:39                install
d-----        23/08/2023     13:39                response
d-----        23/08/2023     13:40                stage
-a----        10/07/2023     17:52           1266 CORP-Oracle-Customization_x64-19.3.vbs
-a----        10/07/2023     17:55            573 desinstall_OraClient19x64_Valeo.rsp
-a----        14/11/2018     09:42         234848 setup.exe
-a----        21/01/2015     07:14             78 setup.ini
-a----        06/02/2013     13:25            514 welcome.html
```

**[+] Step 2**: Run the x64 client installer

:exclamation: Verify ORACLE_HOME environment variable declaration, **it should not be referenced**!
So in your terminal session enter the following command:

:arrow_forward: **`Get-ChildItem env:ORACLE_HOME`**

If it outputs any value for ORACLE_HOME like the following:

```
Name                           Value
----                           -----
ORACLE_HOME                    C:\Oracle\Client32\clientx32-19.3.0
```

You will need to **unset the variable** for three scopes. Type in your terminal session:

:arrow_forward: **`[Environment]::SetEnvironmentVariable("ORACLE_HOME", $null ,"Machine")`**

:arrow_forward: **`[Environment]::SetEnvironmentVariable("ORACLE_HOME", $null ,"User")`**

:arrow_forward: **`[Environment]::SetEnvironmentVariable("ORACLE_HOME", $null ,"Process")`**

Important: As all variables are already loaded in your current session, you will need to close it and reopen a new powershell terminal as administrator.

In your terminal session, run the setup executable:

Note that parameter **ORACLE_HOME_NAME** value has changed from `OraClient19Home1_32bit` to **`OraClient19Home1`**

:arrow_forward: **`.\Client64\setup.exe ORACLE_HOME_NAME=OraClient19Home1 -waitforcompletion -responseFile "C:\Temp\Oracle\Client64\response\clientx64_install19c_Valeo.rsp" -force -silent -noconsole -ignorePrereq`** 

Again be patient, it will run silently and will take 2 or 3 minutes... And you can open the task manager to monitor the execution

![task manager x64](https://technical-user-git.github.io/hosted-img/ora/oui_task_mgr_setup_x64.png)

To check for the completion, you can have have a look to Oracle base directory **`C:\Oracle`** and verify that size of **`Clientx64-19.3.0`** folder is more or less **`1.3 Go`** 

:point_right: **Summary:**

![setup](https://technical-user-git.github.io/hosted-img/ora/ora_home_name_x86.png)

**[+] Step 3**: Run the Visual Basic script

It will fix the permission properties on ORACLE_BASE and generate all environment variables.

In your terminal session, run the script **`CORP-Oracle-Customization_x32-19.3.vbs`**:

:arrow_forward: **`cscript.exe .\Client64\CORP-Oracle-Customization_x64-19.3.vbs`**



# 3.  Environment variables

Open the **System Properties** window, then click the **Environment Variables** button near the bottom of the tab.

**3.1** - ORACLE

You will need to verify that both of the following variables are <b>non-existent</b> in the **system environment** or in user environment.
- **`ORACLE_BASE`**
- **`ORACLE_HOME`**

**3.2** - Path

**`Path`** should contain the absolute paths to the **bin** directory (provide access to Oracle binaries and libraries) of each client.

**`C:\Oracle\Client64\Clientx64-19.3.0\bin`** and **`C:\Oracle\Client32\Clientx32-19.3.0\bin`** have to be included under all "system32" entries (as shown in the following screenshot). Note that in the **first place** it matters to reference the x64 path and only after the x32 path.

![bin dir in path](https://technical-user-git.github.io/hosted-img/ora/ora-path-bindir-declaration.png)

**3.3** - TNS_ADMIN

Create or modify the TNS_ADMIN variable:

**`TNS_ADMIN`** should be set to **`\\iss1-sv00052\MES_ISS\Oracle\Tns_Admin_Issoire`**

**3.4** - Final check

Run the command in a cmd session:

:arrow_forward: **`get-childitem env:* | findstr /i /r ora.*`**

It displays all Oracle required variables that the system own:

```ps=
Path        C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Oracle\Client64\Clientx64-19.3.0\bin;C:\Oracle\Client32\Clientx32...
TNS_ADMIN    \\iss1-sv00052\MES_ISS\Oracle\Tns_Admin_Issoire
```


## Sanity check

### Instance name resolution

Run the command:

:arrow_forward: **`tnsping V208R`**

The command output will validate that instance name resolution is working as expected!

```ps=
TNS Ping Utility for 64-bit Windows: Version 19.0.0.0.0 - Production on 25-AOUT -2023 14:03:11

Copyright (c) 1997, 2019, Oracle.  All rights reserved.

Fichiers de paramètres utilisés :
\\iss1-sv00052\MES_ISS\Oracle\Tns_Admin_Issoire\sqlnet.ora

Adaptateur TNSNAMES utilisÚ pour la rÚsolution de l'alias
Tentative de contact de (DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = REI1-SV00302.vnet.valeo.com)(PORT = 1521))) (CONNECT_DATA = (SID = REI1PVA1) (SERVER = DEDICATED)))
OK (70 msec)
```


### Registry Keys

Check the Registry Editor (hit `Windows+r` then type `regedit`):

- Check that Registry value `HKLM\Software\Wow6432Node\ORACLE\KEY_OraClient19Home1_32bit\ORACLE_HOME` points to `C:\Oracle\Client32\Clientx32-19.3.0`
- Check that Registry value `HKLM\Software\Wow6432Node\ORACLE\KEY_OraClient19Home1\ORACLE_HOME` points to `C:\Oracle\Client64\Clientx64-19.3.0`

- **`HKLM\SOFTWARE\WOW6432Node\ODBC\ODBCINST.INI\Oracle dans OraClient12Home1_32bit`** has a path reference to the main driver file `C:\Oracle\Client32\Clientx32-19.3.0\BIN\SQORA32.DLL`:

![ODBC](https://technical-user-git.github.io/hosted-img/ora/ora_client_x32_odbc_hklm.png)

## II. Fix permission properties on ORACLE_BASE

Set permissions on `C:\Oracle` as follow:

**Full control** - Administrators, SYSTEM, ORA_<HOMENAME>_SVCSIDS, and the Oracle Base User (ex: **iss1-w41404\Utilisateurs**)
**Read, execute, and list content** - **Authenticated Users**

**How to:**
    
1. Right click on C:\Oracle (`%ORACLE_BASE%`) and choose properties on contextual menu.
2. Select the Security tab and click on **Avancé**
3. Click on **Add**
4. Select a local user account (HOSTNAME\Utilisateurs) like `ISS1-W41404\Utilisateurs` or `ISS1-W41404\Utilisateurs authentifiés` (change hostname ISS1-W41404 accordingly to your system) 
5. Validate by clicking on **OK**
6. Checkbox ***Redefine permissions on all child objects and permit propagation of inherited permissions** (Remplacer toutes les entrées d'autorisation des objets enfants par des entrées d'autorisation pouvant hérités de cet object).
7. Click on **OK**

![perm01](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/folder_property_perms_recursive.png)

![perm02](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/folder_property_perms_auth_users.png)

## III. Cleanup
 
Temp folder and source should be cleaning
 
In a cmd terminal run the commands: 

:arrow_forward: **`cd C:\Temp`**
 
:arrow_forward: **`rmdir /S /Q .\Oracle`** to delete temp Oracle directory with its subfolders
 
 
---
*Footnotes:* 
- *The group **`ORA<HomeName>SVCSIDS`** (ex: `ORAOraClient12Home1SVCSIDS`) is for **Oracle's internal use** and is automatically populated. It contains **Service SIDs for all Windows services** (e.g. Oracle Services for MTS, Listener, and Connection Manager) on client homes installed through custom installs. **This group is granted full control to the specific client Oracle Home and client Oracle Base**.*
- *RegKey for Inventory path: **inst_loc** located in `Ordinateur\HKEYLOCALMACHINE\SOFTWARE\WOW6432Node\ORACLE`*



