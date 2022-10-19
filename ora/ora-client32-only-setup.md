# Oracle Full Client x86 v12

**Note:** with Windows 10 x64, the oracle registry keys are stored in:
- **`HKEY_LOCAL_MACHINE\SOFTWARE\Oracle (for 64bit)`** 
- **`HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\ORACLE (for 32bit)`**


**To perform a clean install the deployment should be done on a fresh and running version of Windows 10 with no previous installation of Oracle Full Client or Instantclient.** 


## Oracle Full Client 12.2

**Step 1**: Create the **Oracle base** folder
In a cmd terminal run the command `mkdir C:\Oracle`

**Step 2**: Check the installer source file 

2.1 - You should have the following two files in your source or download directory:

- Release x86 filename: **OracleClient-12201-x86.zip**
- Signature md5 filename: **OracleClient-12201-x86.md5**

2.2 - Control checksum on files (optionnal):
Verify the source file integrity by checking file signature. 

In the terminal run the commands:
`cd C:\mes_sources\OracleClient12\x86` to place yourself in the source file directory
`certutil -hashfile OracleClient-12201-x86.zip MD5` to run MD5 checksum against the source file

Last command will output:
```shell
Hachage MD5 de OracleClient-12201-x86.zip :
2c396644d7b029967f74b95da5094493
CertUtil: -hashfile La commande s’est terminée correctement.
```

You can now verify the returned MD5 hash matches the one in signature file.
In the terminal run the command:
`type OracleClient-12201-x86.md5` to display the content of signature file

The command ouputs the signature hash:
`2C396644D7B029967F74B95DA5094493`

Both hashes should be equal!

### OUI (Oracle Universal Installer)

**Step 3**: Unzip the source file
In the terminal run the command:
`unzip -q OracleClient-12201-x86.zip -d c:\Temp` 

It will unarchive the file to client32 in the Temp directory, then place yourself in `C:\Temp\client32`
In the terminal run the commands:
`cd C:\Temp\client32` to enter the client folder
`dir /O:E` to list the content

The last command will list 3 files and 5 folders:

```shell
 Le volume dans le lecteur C s’appelle WINDOWS
 Le numéro de série du volume est F4B0-A0A0

 Répertoire de c:\Temp\client32

14/02/2017  13:55    <DIR>          ..
14/02/2017  13:41    <DIR>          install
14/02/2017  13:47    <DIR>          response
14/02/2017  13:47    <DIR>          stage
14/02/2017  13:55    <DIR>          .
25/02/2013  21:01            67 432 setup.exe
06/02/2013  21:25               514 welcome.html
21/01/2015  15:14                78 setup.ini
               3 fichier(s)           68 024 octets
               5 Rép(s)  126 414 049 280 octets libres
```

From the terminal run the executable to launch OUI (Oracle Universal Installer)
`setup.exe` 

OUI will be started.




2. Unzip archive and install Oracle x86 Client (running setup.exe), for example into **`C:\Oracle\product\ora12.2.0\client_x86`**

![oui step0](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/OUI-setup.png)

3. Choose `Administrator` setup:

![oui step1](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/OUI-stg01-admin.png)

4. Specify Oracle base directory and Client deployment location:

![oui step3](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/OUI-stg03.png)


### Environment variables

- **Path** should contain `C:\Oracle\product\ora12.2.0\client_x86\bin`:

```shell=
C:\> echo %Path%

C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Gemalto\Access Client\v5\;C:\Program Files (x86)\Gemalto\Access Client\v5\;C:\Program Files\SafeNet\Authentication\SAC\x64;C:\Program Files\SafeNet\Authentication\SAC\x32;C:\Program Files (x86)\Sennheiser\SenncomSDK\;C:\Program Files\Amazon Corretto\jdk11.0.14_10\bin;C:\Oracle\product\ora12.2.0\client_x86\bin;C:\Users\a-yvidil\AppData\Local\Microsoft\WindowsApps
```

- Set **`ORACLE_HOME`** environment variable to point to **`C:\Oracle\product\ora12.2.0\client_x86`** 
- Set **`ORACLE_BASE`** to **`C:\Oracle`**.

### Registry Keys

Check the Registry Editor (hit `Windows+r` then type `regedit`):

- Check that Registry value `HKLM\Software\Wow6432Node\ORACLE\KEY_OraClient12Home1_32bit\ORACLE_HOME` points to `C:\Oracle\product\ora12.2.0\client_x86`

- **`HKLM\SOFTWARE\WOW6432Node\ORACLE\`** should look like:

![OLEDB](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/clientx86_OLEDB.png)

- **`HKLM\SOFTWARE\WOW6432Node\ODBC\`** should look like:

![ODBC](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/clientx86_ODBC.png)

### Fix permission properties on ORACLE_BASE

Set permissions as follow:
**Full control** - Administrators, SYSTEM, ORA_<HOMENAME>_SVCSIDS, and the Oracle Base User (ex: **iss1-w41404\Utilisateurs**)
**Read, execute, and list content** - **Authenticated Users**

How to:
1. Open properties frame for `%ORACLE_BASE%`
2. Security tab and click on **Avancé**
3. Click on **Add**
4. Select local users account like `ISS1-W41404\Utilisateurs`
5. Validate by clicking on **OK**
6. Checkbox ***Redefine permissions on all child objects and permit propagation of inherited permissions** (Remplacer toutes les entrées d'autorisation des objets enfants par des entrées d'autorisation pouvant hérités de cet object).
7. **OK**

![perm01](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/folder_property_perms_recursive.png)

![perm02](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/folder_property_perms_auth_users.png)

Note: 
- The group `ORA_<HomeName>_SVCSIDS` (ex: `ORA_OraClient12Home1_SVCSIDS`) is for Oracle's internal use and is automatically populated. It contains Service SIDs for all Windows services (e.g. Oracle Services for MTS, Listener, and Connection Manager) on client homes installed through custom installs. This group is granted full control to the specific client Oracle Home and client Oracle Base.
- Key for Inventory path: `Ordinateur\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\ORACLE`
