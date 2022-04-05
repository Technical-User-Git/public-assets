# Oracle Client Side, Full procedure including Java Install

Windows have changed the way that Java is installed. Now it creates a **`C:\ProgramData\Oracle\Java\javapath`** folder that is added to the **PATH**, and this folder is a symlink to C:\ProgramData\Oracle\Java\javapath_target_115109593 which contains java.exe, javaw.exe, and javaws.exe (the main Java executables).

With Windows x64 the regedit keys are in **`HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft (32bit)`** and **`HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\JavaSoft (64bit)`**


```
mklink java.exe "C:\Program Files\Java\jdk1.8.0_102\bin\java.exe"
mklink javaw.exe "C:\Program Files\Java\jdk1.8.0_102\bin\javaw.exe"
mklink javaws.exe "C:\Program Files\Java\jdk1.8.0_102\bin\javaws.exe"
```

### AWS Corretto 11.0.14

- https://github.com/corretto/corretto-11/releases


1. Remove all Java installations: uninstall Java 8.0_144 and Java 8 8.0_144 (64-bit)

![java](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/VERSIONS-java-preinstall.png)

2. Clean up any lingering register keys with regedit **if some keys remain**:

![HKLM 64](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/REG-java-preinstall.png)

![HKLM 32](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/REG64-java-preinstall.png)

3. Clean up `Path` variable if needed by removing javapath location:

![Path](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/PATH-java-preinstall.png)

4. Clean up any lingering file/folder structures:
- `C:\Program Files\Java\`
- `C:\Program Files (x86)\Java\`
- `C:\ProgramData\Oracle\Java`

### Install sources

AWS-Corretto 11 Packages (both 32-bit and 64-bit): 
- Release x64 format .msi: **`amazon-corretto-11.0.14.10.1-windows-x64.zip`**
- Signature MD5: **`amazon-corretto-11.0.14.10.1-windows-x64.md5`**
- Release x86 format .msi: **`amazon-corretto-11.0.14.10.1-windows-x86.zip`**
- Signature MD5: **`amazon-corretto-11.0.14.10.1-windows-x86.md5`**

Verify md5 checksums for each release to deploy:

```shell=
C:\sources\AwsCorretto\x86> certutil -hashfile amazon-corretto-11.0.14.10.1-windows-x86.zip MD5
Hachage MD5 de amazon-corretto-11.0.14.10.1-windows-x86.zip :
208210598ad37fa9328a3cd06fc47c0e
CertUtil: -hashfile La commande s’est terminée correctement.

C:\sources\AwsCorretto\x86> type amazon-corretto-11.0.14.10.1-windows-x86.md5
208210598ad37fa9328a3cd06fc47c0e
```

If hashes match you can unzip the files and run both msi installers (x86/x64).

![aws corretto](https://raw.githubusercontent.com/Technical-User-Git/public-assets/main/ora/assets/AWS-corretto-x86.png)

Note that 32-bit version will be install to **`C:\Program Files (x86)\Amazon Corretto\jdk11.0.14_10`** while 64-bit version will be in **`C:\Program Files\Amazon Corretto\jdk11.0.14_10`**

### Environment variables

Ensure that  environment variables are correctly set:
- JAVA_HOME
```shell=
JAVA_HOME  C:\Program Files\Amazon Corretto\jdk11.0.14_10 
```
- Path
```shell=
C:\Users\a-yvidil>echo %Path%
C:\Program Files\Amazon Corretto\jdk11.0.14_10\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Gemalto\Access Client\v5\;C:\Program Files (x86)\Gemalto\Access Client\v5\;C:\Program Files\SafeNet\Authentication\SAC\x64;C:\Program Files\SafeNet\Authentication\SAC\x32;C:\Program Files (x86)\Sennheiser\SenncomSDK\;C:\Users\a-yvidil\AppData\Local\Microsoft\WindowsApps;
```

Remove `C:\Program Files\Amazon Corretto\jdk11.0.14_10\bin;` from the head of **Path** and append it to the tail, so it looks like:

```
C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Gemalto\Access Client\v5\;C:\Program Files (x86)\Gemalto\Access Client\v5\;C:\Program Files\SafeNet\Authentication\SAC\x64;C:\Program Files\SafeNet\Authentication\SAC\x32;C:\Program Files (x86)\Sennheiser\SenncomSDK\;C:\Users\a-yvidil\AppData\Local\Microsoft\WindowsApps;C:\Program Files\Amazon Corretto\jdk11.0.14_10\bin;
```

## Full client install

`C:\> mkdir c:\Oracle`

Download and install Oracle x86 Client, for example into **`C:\Oracle\product\ora12.2.0\client_x86`**

Download and install Oracle x64 Client into different folder, for example to **`C:\Oracle\product\ora12.2.0\client_x64`**

**Note:** Both client folder structure **should be the same** (e.g. presence of /bin directory)

Go to folder **`%WINDIR%\System32`** and create a symbolic link **`ora122`** to folder **`C:\Oracle\product\ora12.2.0\client_x64`**

```bash
cd %WINDIR%\System32
mklink /d ora122 C:\Oracle\product\ora12.2.0\client_x64
Lien symbolique créé pour ora122 <<===>> C:\Oracle\product\ora12.2.0\client_x64
```

Switch to folder **`%WINDIR%\SysWOW64`** and create a symbolic link **`ora122`** to folder **`C:\Oracle\product\ora12.2.0\client_x86`**

```bash
cd %WINDIR%\SysWOW64
mklink /d ora122 C:\Oracle\product\ora12.2.0\client_x86
Lien symbolique créé pour ora122 <<===>> C:\Oracle\product\ora12.2.0\client_x86
```

**Note**: Both symbolic links must have the same name, e.g. **`ora122`**

Remove existing jdk and symlink corretto jdk for each version of client:

```
C:\Oracle\product\ora12.2.0\client_x86>rmdir /Q /S jdk

C:\Oracle\product\ora12.2.0\client_x86>mklink /d jdk "C:\Program Files (x86)\Amazon Corretto\jdk11.0.14_10"
Lien symbolique créé pour jdk <<===>> C:\Program Files (x86)\Amazon Corretto\jdk11.0.14_10
```


```
C:\Oracle\product\ora12.2.0\client_x64>rmdir /Q /S jdk

C:\Oracle\product\ora12.2.0\client_x64>mklink /d jdk "C:\Program Files\Amazon Corretto\jdk11.0.14_10"
Lien symbolique créé pour jdk <<===>> C:\Program Files\Amazon Corretto\jdk11.0.14_10
```

## Environment variables


Modify **Path** environment variable, replace all entries like **`C:\Oracle\product\ora12.2.0\client_x86`** and **`C:\Oracle\product\ora12.2.0\client_x64`** by **C:\Windows\System32\ora122\bin**. 

***Note:*** *`C:\Windows\SysWOW64\ora122`* ***must not be in the PATH.***

**Path** should look like:

```shell=
echo %Path%

C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\Gemalto\Access Client\v5\;C:\Program Files (x86)\Gemalto\Access Client\v5\;C:\Program Files\SafeNet\Authentication\SAC\x64;C:\Program Files\SafeNet\Authentication\SAC\x32;C:\Program Files (x86)\Sennheiser\SenncomSDK\;C:\Program Files\Amazon Corretto\jdk11.0.14_10\bin;C:\Windows\System32\ora122\bin;C:\Users\a-yvidil\AppData\Local\Microsoft\WindowsApps
```

- Set **`ORACLE_HOME`** environment variable to point to **`C:\Windows\System32\ora122`** 
- Set **`ORACLE_BASE`** to **`C:\Oracle`**.
- Set **`TNS_ADMIN`** to **`\\ISS1-SV00052\MES_ISS\Oracle\Tns_Admin_Issoire`**

## Registry Keys

Fire up the Registry Editor:

- Set Registry value `HKLM\Software\ORACLE\KEY_OraClient12Home1\ORACLE_HOME` to `C:\Windows\System32\ora122`
- Set Registry value `HKLM\Software\Wow6432Node\ORACLE\KEY_OraClient12Home1_32bit\ORACLE_HOME` to `C:\Windows\System32\ora122` (**and not C:\Windows\SysWOW64\ora122**)


*We can now use x86 and x64 Oracle Full Client seamless together, i.e. an x86 application will load the 32-bit libraries while an x64 application will deal with the 64-bit libraries.*


## SQLDeveloper

Create JRE packages:

```shell=
# x86 version
C:\Program Files (x86)\Amazon Corretto\jdk11.0.14_10\bin>jlink.exe --output ..\jre --add-modules java.se

# x64 version
C:\Program Files\Amazon Corretto\jdk11.0.14_10\bin>jlink.exe --output ..\jre --add-modules java.se
```



Declare **`JRE_HOME`** to point to **`C:\Program Files\Amazon Corretto\jdk11.0.14_10\jre\bin`**

**`JAVA_HOME` should already reside in env:vars.**


Finally install SQL Developer ("no-jre" version for Windows 32-bit/64-bit):
- https://www.oracle.com/tools/downloads/sqldev-downloads.html
