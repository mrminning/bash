#!/bin/bash

# Here we set the Bluetooth device address
device_address="50:C2:ED:B9:39:7E"

# Get the connection status of the device
connection_status=$(bluetoothctl info $device_address | grep "Connected:" | awk '{print $2}')

# Here we determine status based on connection status
if [ "$connection_status" == "yes" ]; then
  status="connected"
else
  status="disconnected"
fi

# Let's print initial status
echo "Device $device_address is currently $status"

# If the device is connected, disconnect it
if [ "$connection_status" == "yes" ]; then
  echo "Disconnecting from $device_address..."
  status="disconnected"
  bluetoothctl << EOF
  disconnect $device_address
EOF
  sleep 4
  echo "Connecting to $device_address..."
  status="connected"
  bluetoothctl << EOF
  connect $device_address
EOF
fi

# Print final status
echo "Device $device_address is now $status"
