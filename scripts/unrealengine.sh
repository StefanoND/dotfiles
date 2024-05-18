#!/usr/bin/env bash

# Unreal Engine 5.4.1
LINK='https://ucs-blob-store.s3-accelerate.amazonaws.com/blobs/ba/26/dde3-4b7d-4309-a978-8099a533cd39?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIA2SBBZFECCYQWRK6G%2F20240518%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20240518T133638Z&X-Amz-Expires=3600&X-Amz-Signature=08fd2016eb359e69191c9de25adc3ce3f45e4d7bc43c7214f88910bced4cd6ab&X-Amz-SignedHeaders=host&response-content-disposition=inline%3Bfilename%3D%22file.zip%22%3Bfilename%2A%3DUTF-8%27%27Linux_Unreal_Engine_5.4.1.zip&x-id=GetObject'

echo
echo "Ubuntu 22.04 64-Bit Recommended"
echo "Downloading Unreal Engine 5.4.1 for Linux"
echo "Download size = 23.09GB"
echo
wget -v --show-progress "$LINK" -o Linux_Unreal_Engine_5.4.1.zip
