#!/bin/bash

ALIAS="minio"
URL="http://minio:9000"

echo "Minio Dev Setup"

# Creating Alias
echo "Connecting to $ALIAS"
set -e # exit on error
mc alias set $ALIAS $URL $MINIO_ROOT_USER $MINIO_ROOT_PASSWORD
set +e # disable exit on error

# Creating Bucket
echo "Creating Bucket $ALIAS/$MINIO_BUCKET"
mc mb --ignore-existing $ALIAS/$MINIO_BUCKET

# Creating RW user
echo "Creating RW User $MINIO_RW_USER"
mc admin user add $ALIAS $MINIO_RW_USER $MINIO_RW_PASSWORD
mc admin policy attach $ALIAS readwrite --user $MINIO_RW_USER 2>/dev/null

# Creating RO user
echo "Creating RO User $MINIO_RO_USER"
mc admin user add $ALIAS $MINIO_RO_USER $MINIO_RO_PASSWORD
mc admin policy attach $ALIAS readonly --user $MINIO_RO_USER 2>/dev/null

# Creating WO user
echo "Creating WO User $MINIO_WO_USER"
mc admin user add $ALIAS $MINIO_WO_USER $MINIO_WO_PASSWORD
mc admin policy attach $ALIAS writeonly --user $MINIO_WO_USER 2>/dev/null

echo "Setup Complete"
exit 0
