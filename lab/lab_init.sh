#!/bin/bash

# Create directory structure
mkdir -p raw rar/multipart 7z/multipart zip/multipart tar.xz/multipart tar.bz2/multipart tar.gz/multipart

# Create raw files with random data

# Step 1: Create dummy1G file (50 MB compressed)
echo "Creating 50 MB dummy file..."
dd if=/dev/urandom of=raw/dummy50M bs=1M count=50 status=none

# Step 2: Create dummy3G file (100 MB compressed)
echo "Creating 100 MB dummy file..."
dd if=/dev/urandom of=raw/dummy100M bs=1M count=100 status=none

echo "All raw files created. Starting compression..."

# Compress dummy50M

## Singlepart Archives
echo "Creating singlepart archives for dummy50M..."
rar a -r rar/dummy50M.rar raw/dummy50M
7z a 7z/dummy50M.7z raw/dummy50M
zip zip/dummy50M.zip raw/dummy50M
tar -cJf tar.xz/dummy50M.tar.xz raw/dummy50M
tar -cjf tar.bz2/dummy50M.tar.bz2 raw/dummy50M
tar -czf tar.gz/dummy50M.tar.gz raw/dummy50M

echo "Singlepart archives for dummy50M created."

## Multipart Archives for dummy100M

echo "Creating multipart archives for dummy100M..."
rar a -v6M -r rar/multipart/dummy100M.rar raw/dummy100M
7z a -v6m 7z/multipart/dummy100M.7z raw/dummy100M
zip -s 6m -r zip/multipart/dummy100M.zip raw/dummy100M
tar -cf tar.xz/multipart/dummy100M.tar raw/dummy100M
split -b 6M -d tar.xz/multipart/dummy100M.tar tar.xz/multipart/dummy100M.tar.part
tar -cf tar.bz2/multipart/dummy100M.tar raw/dummy100M
bzip2 -z tar.bz2/multipart/dummy100M.tar
split -b 6M -d tar.bz2/multipart/dummy100M.tar.bz2 tar.bz2/multipart/dummy100M.tar.bz2.part
tar -cf tar.gz/multipart/dummy100M.tar raw/dummy100M
gzip tar.gz/multipart/dummy100M.tar
split -b 6M -d tar.gz/multipart/dummy100M.tar.gz tar.gz/multipart/dummy100M.tar.gz.part

echo "All archives created successfully."