#!/bin/bash
echo "sleeping for 2 seconds"
sleep 2

echo mongo_setup.sh time now: `date +"%T" `
mongosh --host mongodb:27017 <<EOF
  var cfg = {
    "_id": "rs0",
    "version": 1,
    "members": [
      {
        "_id": 0,
        "host": "mongodb:27017",
        "priority": 2
      }
    ]
  };
  rs.initiate(cfg);
EOF