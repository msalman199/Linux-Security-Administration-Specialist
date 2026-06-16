#!/bin/bash
# Custom application script
echo "Custom app starting..."
touch /var/log/custom_app.log
echo "$(date): Application started" >> /var/log/custom_app.log
echo "Custom app completed."
