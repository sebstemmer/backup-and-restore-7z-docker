#!/bin/sh

# parameters
backup_dir_path="/path/to/backup_me"
output_dir_path="/path/to/cloud_storage"
encryption_password="my_password"
split_size=50M

# setup folder structure for processing
mkdir tmp
mkdir ./tmp/in
mkdir ./tmp/out

backup_dir=backup_$(date '+%Y_%m_%d_%H_%M')

mkdir ./tmp/in/$backup_dir

# copy directory to backup
cp -r $backup_dir_path ./tmp/in/$backup_dir

# docker
cd src
docker build --build-arg script=backup.ash -t backup:1.0 .
cd ..

mount_point="$(readlink -f .)/tmp"

docker run --rm -v $mount_point:/usr/local/bin/tmp \
    -e split_size=$split_size \
    -e password=$encryption_password \
    -e backup_dir=$backup_dir \
    backup:1.0

# copy result to output directory
cp -r ./tmp/out/$backup_dir $output_dir_path

# cleanup
docker image rm backup:1.0
rm -rf tmp
