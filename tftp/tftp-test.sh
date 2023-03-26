#!/bin/bash
apt -y install tftp

tftp $1
tftp put test.txt
tftp sleep 1
tftp get text.txt
