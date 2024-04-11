# Manage the default connection string in SQLDeveloper

## Install sqldeveloper

### Notes on setup

- Extract the **SQLDeveloper** archive to the basepath **`C:\Oracle`** like any other Oracle product: 

![sqldevel basepath](https://technical-user-git.github.io/hosted-img/assets/setup/ora_sqldevel_install_basepath.png)

- On the first run, SQLDeveloper will ask for previous preferences import, just answer **NO** to get a fresh install.

![sqldevel install](https://technical-user-git.github.io/hosted-img/assets/setup/ora_sqldevel_install.png)

- Unticked the checkbox **authorize sending report to Oracle** 

![ora metrics](https://technical-user-git.github.io/hosted-img/assets/setup/ora_suivi_metrics_no.png)

## Create the connection string

### Step 1

To define the data source, right click on **`Oracle connexions`** and select **`Importer des connexions`**.

![conn 1](https://technical-user-git.github.io/hosted-img/ora/ora_add_conn.png)

You will be prompted to locate the connections file **ora_conn.json** you previously downloaded

![conn 2](https://technical-user-git.github.io/hosted-img/ora/ora_add_conn_2.png)

### Step 2

Once selected, SqlDeveloper will ask for a key to decrypt the password hash cipher string defined in the file. Just enter <!-- pwd4oracle --> and press **Next** button.

![conn 3](https://technical-user-git.github.io/hosted-img/ora/ora_add_conn_3.png)

### Step 3

Check the connection and hit **Next** button:

![conn 3b](https://technical-user-git.github.io/hosted-img/ora/ora_add_conn_3B.png)

### Step 4

Validate the digest by pressing the **End** button

![conn 4](https://technical-user-git.github.io/hosted-img/ora/ora_add_conn_4.png)

Finally the connexion **`USINE`** will be available in the connection frame

![conn 5](https://technical-user-git.github.io/hosted-img/ora/ora_add_conn_5.png)
