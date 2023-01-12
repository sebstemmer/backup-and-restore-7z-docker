#!/bin/sh

# parameters
backup_dir_path="/path/to/backup_files"
output_dir_path="/path/to/output"
decryption_password="my_password"

# setup folder structure for processing
mkdir tmp
mkdir ./tmp/in
mkdir ./tmp/out

# copy backup directory
cp -r $backup_dir_path/* ./tmp/in

# docker
cd src
docker build --build-arg script=restore.ash -t restore:1.0 .
cd ..

mount_point="$(readlink -f .)/tmp"
backup_dir=$(basename $backup_dir_path)

docker run --rm -v $mount_point:/usr/local/bin/tmp \
    -e password=$decryption_password \
    -e backup_dir=$backup_dir \
    restore:1.0

# copy result to output directory
cp -r ./tmp/out/$backup_dir $output_dir_path

# cleanup
docker image rm restore:1.0
rm -rf tmp
