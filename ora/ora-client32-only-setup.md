# Oracle Full Client x86 v12

**Note:** with Windows x64 10 the registry keys are in **`HKEY_LOCAL_MACHINE\SOFTWARE\Oracle (64bit)`** and **`HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\ORACLE (32bit)`**


**First remove all previous Oracle Client and Instant-Client installations: uninstall via OUI (Oracle Universal Installer) or uninstaller and check that registry keys, environnement variables (ORACLE_BASE, ORACLE_HOME, Path) and folders are all cleaned and removed!** 


## Oracle Full Client 12.2

Create **Oracle base** folder: `C:\> mkdir C:\Oracle`

**Client Release file**:

- Release x86: x86/OracleClient-12201-x86.zip
- Signature md5: x86/OracleClient-12201-x86.md5

### OUI (Oracle Universal Installer)

1. Control checksum on files (optionnal):

```
C:\sources\OracleClient12\x86> certutil -hashfile OracleClient-12201-x86.zip MD5
Hachage MD5 de OracleClient-12201-x86.zip :
2c396644d7b029967f74b95da5094493
CertUtil: -hashfile La commande s’est terminée correctement.

C:\sources\OracleClient12\x86> type OracleClient-12201-x86.md5
2C396644D7B029967F74B95DA5094493
```

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

### Fix permission properties on ORACLE_HOME

Set permissions as follow:
**Full control** - Administrators, SYSTEM, ORA_<HOMENAME>_SVCSIDS, and the Oracle Home User (ex: **iss1-w41404\Utilisateurs**)
**Read, execute, and list content** - **Authenticated Users**

How to:
1. Open properties frame for `%ORACLE_HOME%`
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
