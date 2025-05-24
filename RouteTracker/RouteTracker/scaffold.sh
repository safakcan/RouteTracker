#!/bin/bash

echo "📁 Creating folder structure..."

# App Layer
mkdir -p App
mkdir -p Resources
mkdir -p SupportingFiles

# Core Services
mkdir -p Core/Location
mkdir -p Core/Geocoding
mkdir -p Core/Storage
mkdir -p Core/Networking

# Shared
mkdir -p Shared/Components
mkdir -p Shared/Extensions
mkdir -p Shared/Utilities

# Onboarding Module
mkdir -p Modules/Onboarding/View/XIB
mkdir -p Modules/Onboarding/ViewModel
mkdir -p Modules/Onboarding/Model
mkdir -p Modules/Onboarding/Coordinator

# MapTracking Module
mkdir -p Modules/MapTracking/View/XIB
mkdir -p Modules/MapTracking/ViewModel
mkdir -p Modules/MapTracking/Model
mkdir -p Modules/MapTracking/Coordinator

echo "✅ Folders created successfully."

