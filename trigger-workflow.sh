#!/bin/bash

# This script triggers the cinema-images workflow
# It creates a dummy commit to trigger the workflow

echo "Triggering cinema-images workflow..."

# Create a dummy file to trigger the workflow
touch .github/workflows/trigger-$(date +%s).txt

# Add and commit
git add .github/workflows/trigger-$(date +%s).txt
git commit -m "Trigger cinema-images workflow $(date)"
git push origin main

echo "Workflow triggered successfully!"