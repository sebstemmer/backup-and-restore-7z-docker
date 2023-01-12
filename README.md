# secure backup and restore

this tool helps you to backup your data to the cloud. your data is **compressed** and **encrypted** before transfer. in
this
process your data is also split up into **chunks of a specific size**, making uploading to the cloud easier also with
slower
internet connection. this tool works on unix-like systems and requires
only [Docker](https://docs.docker.com/get-docker/). internally [7z](https://www.7-zip.org/download.html) is utilized,
which uses the **secure AES256** for encryption. 

## backup

assume the folder `backup_me` that you want to backup lies under the path `/path/to/backup_me`. the resulting backup
files should go in `/path/to/cloud_storage`, because you mounted this directory to your favourite cloud provider. You
want your backup files to be of maximum size of 50 MB. The encryption password should be `my_password`. Then set the
parameters in `main_backup.sh` to

```
backup_dir_path="/path/to/backup_me"
output_dir_path="/path/to/cloud_storage"
encryption_password="my_password"
split_size=50M (or e.g. 1G for 1 GB)
```

the folder containing the shell script `main_backup.sh` must be outside `backup_me`. start the process via

```
sh main_backup.sh
```

## restore

if the backup files are located in `/path/to/backup_files`, the encryption password used was `my_password` and the
result should go in `/path/to/output` then set the parameters in `main_restore.sh` to

```
backup_dir_path="/path/to/backup_files"
output_dir_path="/path/to/output"
decryption_password="my_password"
```

start the process via

```
sh main_restore.sh
```