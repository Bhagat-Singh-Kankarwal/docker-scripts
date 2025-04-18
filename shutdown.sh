#!/bin/bash
# Shutdown script for blockvote.live Fabric-Supertoken application

BASE_DIR=/opt/fabric-supertoken
BACKEND_DIR=$BASE_DIR/blockvote/asset-transfer-basic/application-gateway-javascript
NETWORK_DIR=$BASE_DIR/blockvote/test-network

# Stop PM2 processes
pm2 stop fabric-api
pm2 delete all

# Remove wallet directory
echo "Removing wallet directory..."
if [ -d "$BACKEND_DIR/src/wallet" ]; then
    rm -rf $BACKEND_DIR/src/wallet
    echo "✓ Wallet directory removed"
else
    echo "! Wallet directory not found"
fi

# Stop Docker containers
cd $BASE_DIR
docker-compose down -v

# Shutdown Fabric network
cd $NETWORK_DIR
./network.sh down

echo "All services have been stopped."
