#!/bin/bash

cmake ../ \
      -DCMAKE_BUILD_TYPE=Release \
      -DWITH_EVENTTRACE=ON \
      -DWITH_RDMA=ON \
      -DWITH_SPDK=ON \
      -DWITH_BLUESTORE_PMEM=ON
