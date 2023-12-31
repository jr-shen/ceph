#!/bin/bash

MON_ID=$(hostname)
IP=$(hostname --ip-address)
systemctl stop ceph-mon@$MON_ID
systemctl stop ceph-mgr@$MON_ID
cp ceph.conf /etc/ceph/ceph.conf
rm -rf /var/lib/ceph/*
mkdir -p /var/lib/ceph/mon/ceph-$MON_ID
mkdir -p /var/lib/ceph/mgr/ceph-$MON_ID
#ceph-authtool --create-keyring /tmp/ceph.mon.keyring --gen-key -n mon. --cap mon 'allow *'                                                           
#ceph-authtool --create-keyring /var/lib/ceph/mgr/ceph-$MON_ID/keyring --gen-key -n mon. --cap mon 'allow *'                                          
monmaptool --clobber --create --add $MON_ID $IP --fsid 2287cda5-0250-49e2-98e3-125e65f18daa /tmp/monmap
ceph-mon --mkfs -i $MON_ID --monmap /tmp/monmap
chown -R ceph:ceph /var/lib/ceph
systemctl start ceph-mon@$MON_ID
systemctl start ceph-mgr@$MON_ID
