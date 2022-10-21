---
tags: oracle, client x86
---

# Oracle Full Client x86 v12

***Note:*** *with Windows 10 x64, the oracle registry keys are stored in:*
- **`HKEY_LOCAL_MACHINE\SOFTWARE\Oracle (for 64bit application data)`** 
- **`HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\ORACLE (for 32bit application data)`**

```diff
- To perform a clean install the deployment should be done on a fresh and running version of Windows 10,
- with no previous installation of Oracle Full Client nor Instantclient.
```

# I. Full Client install

**[+] Step 1**: Create the **Oracle base** folder

In a cmd terminal run the command: 

:arrow_forward: **`mkdir C:\Oracle`**

**[+] Step 2**: Check the installer source file 

**2.1** - You should have the following two files in your source directory (if already downloaded)

- Release x86 filename: **OracleClient-12201-x86.zip**
- Signature md5 filename: **OracleClient-12201-x86.md5**

Alternatively you could download the files from the fileserver:
_`\\iss1-sv00033\Local-Software\Métiers\Informatique\Oracle\ora_deployment_x86_x64\OracleFullClient12\x86`_

**2.2** - Verify the source file integrity

Compute the hash value for the file **OracleClient-12201-x86.zip** (checksum process).
This "Best Pratice" helps verify that the file has not changed since it was digitally signed (not corrupted or altered in anyway).

In your running terminal enter the commands:

:arrow_forward: **`cd C:\mes_sources\OraClient12\x86`** to place yourself in the source file directory 
Change `mes_sources\OraClient12\x86` accordingly to the location of your source file.

:arrow_forward: **`certutil -hashfile OracleClient-12201-x86.zip MD5`** to run the checksum against the source file

Last command will output:

```shell=
Hachage MD5 de OracleClient-12201-x86.zip :
2c396644d7b029967f74b95da5094493     <-- here is the signature (computed md5 hash)
CertUtil: -hashfile La commande s’est terminée correctement.
```

You will now display the content of the original signature file.

In the same terminal run the command:

:arrow_forward: **`type OracleClient-12201-x86.md5`** 

The command ouputs the signature hash:

```shell=
2C396644D7B029967F74B95DA5094493
```

You will now verify that the first computed hash matches the signature file one.

`2c396644d7b029967f74b95da5094493 = 2c396644d7b029967f74b95da5094493`, the **hashes are equal**, file integrety is verified.


**[+] Step 3**: Unzip the source file

Always in your opened terminal session, run the commands:

:arrow_forward: **`unzip -q OracleClient-12201-x86.zip -d c:\Temp`** 

It will unarchive the file to **client32** folder inside the **C:\Temp** directory, then place yourself in **`C:\Temp\client32`**.

:arrow_forward: **`cd C:\Temp\client32`** to enter the client folder

:arrow_forward: **`dir /O:E`** to list the content of client32 folder

The last command will list 3 files and 5 directories:

```shell=
 Le volume dans le lecteur C s’appelle WINDOWS
 Le numéro de série du volume est F4B0-A0A0

 Répertoire de c:\Temp\client32

14/02/2017  13:55    <DIR>          ..
14/02/2017  13:41    <DIR>          install
14/02/2017  13:47    <DIR>          response
14/02/2017  13:47    <DIR>          stage
14/02/2017  13:55    <DIR>          .
25/02/2013  21:01            67 432 setup.exe      <-- here is the Oracle client installer
06/02/2013  21:25               514 welcome.html
21/01/2015  15:14                78 setup.ini
               3 fichier(s)           68 024 octets
               5 Rép(s)  126 414 049 280 octets libres
```

**[+] Step 4**: Run **OUI (Oracle Universal Installer)**

In your terminal session, run the OUI setup executable:

:arrow_forward: **`setup.exe`** 

And OUI will be launched.

![oui step0](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/OUI-setup.png)

Just after the GUI will popup, asking for the expected type of setup.

![oui step1](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/OUI-stg01-admin.png)

Select **`Administrateur`** setup as shown in the previous screenshot, and click on **`Suivant`** button.

On the next screen, you will have to specify **Oracle base directory** and **Client deployment location**:

![oui step3](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/OUI-stg03.png)

Just input **`C:\Oracle`** as Oracle base directory and **`C:\Oracle\product\ora12.2.0\client_x86`** for the client location and validate.

The Client x86 will be installed, be patient it will takes some minutes...

**[+] Step 5**: Environment variables

Open the **System Properties** window, then click the **Environment Variables** button near the bottom of the tab.

You will need to verify that all of the following variables are available in the **system environment** not in user environment, if not just create them.

**5.1** - ORACLE_BASE

**`ORACLE_BASE`** should be set to **`C:\Oracle`**.

**5.2** - ORACLE_HOME

**`ORACLE_HOME`** should be point to **`C:\Oracle\product\ora12.2.0\client_x86`**. 

**5.3** - Path

**`Path`** should contain the absolute path **`C:\Oracle\product\ora12.2.0\client_x86\bin`** (the **bin** directory is where are stored the Oracle dll and binaries).

**`C:\Oracle\product\ora12.2.0\client_x86\bin`** have to be included at the end of the entries (as shown in Sanity check section).

**5.4** - TNS_ADMIN

**`TNS_ADMIN`** should be set to **`\\iss1-sv00052\MES_ISS\Oracle\Tns_Admin_Issoire`**

## Sanity check

### System environment variables

Open a new cmd terminal and run the command:

:arrow_forward: **`powershell $Env:Path -split ';'`**

It ouputs the Path variable which should contains the oracle bin path:

```ps=
C:\Windows\system32;
C:\Windows;
C:\Windows\System32\Wbem;
C:\Windows\System32\WindowsPowerShell\v1.0\;
C:\Windows\System32\OpenSSH\;
C:\Program Files\Gemalto\Access Client\v5\;
C:\Program Files (x86)\Gemalto\Access Client\v5\;
C:\Program Files\SafeNet\Authentication\SAC\x64;
C:\Program Files\SafeNet\Authentication\SAC\x32;
C:\Program Files (x86)\Sennheiser\SenncomSDK\;
C:\Program Files\Amazon Corretto\jdk11.0.14_10\bin;
C:\Users\a-yvidil\AppData\Local\Microsoft\WindowsApps;
C:\Oracle\product\ora12.2.0\client_x86\bin      <-- here is the declared bin directory!
```

Run the command:

:arrow_forward: **`powershell gci env: | findstr /i /r ora.*`**

It displays all Oracle required variables that the system own:

```ps=
ORACLE_BASE                    C:\Oracle
ORACLE_HOME                    C:\Oracle\product\ora12.2.0\client_x86
Path                           C:\Windows\system32;C:\Windows;C:\Windows\...
TNS_ADMIN                      \\iss1-sv00052\MES_ISS\Oracle\Tns_Admin_Issoire
```

### Instance name resolution

Run the command:

:arrow_forward: **`tnsping V208R`**

The command output will validate that instance name resolution is working as expected!

```ps=
TNS Ping Utility for 32-bit Windows: Version 12.2.0.1.0 - Production on 19-OCT. -2022 11:49:38

Copyright (c) 1997, 2016, Oracle.  All rights reserved.

Fichiers de paramètres utilisés :
\\iss1-sv00052\MES_ISS\Oracle\Tns_Admin_Issoire\sqlnet.ora


Adaptateur TNSNAMES utilisé pour la résolution de l'alias
Tentative de contact de (DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = REI1-SV00302.vnet.valeo.com)(PORT = 1521))) (CONNECT_DATA = (SID = REI1PVA1) (SERVER = DEDICATED)))
OK (50 msec)
```


### Registry Keys

Check the Registry Editor (hit `Windows+r` then type `regedit`):

- Check that Registry value `HKLM\Software\Wow6432Node\ORACLE\KEY_OraClient12Home1_32bit\ORACLE_HOME` points to `C:\Oracle\product\ora12.2.0\client_x86`

![OLEDB](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/clientx86_OLEDB.png)

- **`HKLM\SOFTWARE\WOW6432Node\ODBC\ODBCINST.INI\Oracle dans OraClient12Home1_32bit`** has a path reference to the main driver file `C:\Oracle\product\ora12.2.0\client_x86\BIN\SQORA32.DLL`:

![ODBC](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/clientx86_ODBC.png)

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
 
:arrow_forward: **`rmdir /S /Q .\client32`** to delete main directory and subfolders
 
:arrow_forward: **`cd C:\mes_sources`**
 
:arrow_forward: **`rmdir /S /Q .\OracleClient12`** to delete the source directory
 
 
---
*Footnotes:* 
- *The group **`ORA<HomeName>SVCSIDS`** (ex: `ORAOraClient12Home1SVCSIDS`) is for **Oracle's internal use** and is automatically populated. It contains **Service SIDs for all Windows services** (e.g. Oracle Services for MTS, Listener, and Connection Manager) on client homes installed through custom installs. **This group is granted full control to the specific client Oracle Home and client Oracle Base**.*
- *RegKey for Inventory path: **inst_loc** located in `Ordinateur\HKEYLOCALMACHINE\SOFTWARE\WOW6432Node\ORACLE`*


