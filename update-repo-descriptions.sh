#!/bin/bash

# GitHub Repository Description Updater
# This script updates repository descriptions using GitHub CLI

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo -e "${RED}❌ GitHub CLI is not installed!${NC}"
    echo "Please install it from: https://cli.github.com"
    exit 1
fi

# Check if user is authenticated
if ! gh auth status &> /dev/null; then
    echo -e "${RED}❌ Not authenticated with GitHub CLI${NC}"
    echo "Please run: gh auth login"
    exit 1
fi

echo -e "${BLUE}🚀 Starting Repository Description Update...${NC}\n"

# Define repositories and their new descriptions
declare -A repos=(
    ["Breeze1203/AiDevOps"]="🤖 LLM-Driven Infrastructure Diagnostic System - Intelligent troubleshooting for cloud operations"
    ["Breeze1203/SpringCloud"]="☁️ Production-Grade Microservices Architecture - Complete ecosystem with Eureka, Config Server, Bus, and Monitoring"
    ["Breeze1203/shardingsphere-example"]="🔀 Distributed Database Solutions - Master sharding, read-write splitting, and distributed transactions"
    ["Breeze1203/design-patterns"]="🎨 23 Gang of Four Design Patterns - Comprehensive Java implementations with real-world use cases"
    ["Breeze1203/springsecurity6.0"]="🔐 Spring Security 6.0 Masterclass - Authentication, Authorization, OAuth2, JWT, and RBAC implementation"
    ["Breeze1203/JavaAdvanced"]="☕ Enterprise Java Deep Dive - JVM internals, concurrency, messaging middleware, and performance optimization"
    ["Breeze1203/Go"]="🐹 Go Language Complete Guide - From basics to advanced with Gin framework, gRPC, and production patterns"
    ["Breeze1203/study-essay"]="📖 Technical Knowledge Base - In-depth articles on architecture, performance, and best practices"
)

# Counter for success/failure
success_count=0
failed_count=0

# Update each repository
for repo in "${!repos[@]}"; do
    description="${repos[$repo]}"
    
    echo -e "${BLUE}📝 Updating: $repo${NC}"
    echo "   Description: $description"
    
    # Update repository description using GitHub CLI
    if gh repo edit "$repo" --description "$description" 2>/dev/null; then
        echo -e "${GREEN}✅ Success${NC}\n"
        ((success_count++))
    else
        echo -e "${RED}❌ Failed${NC}\n"
        ((failed_count++))
    fi
done

# Summary
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Successfully updated: $success_count repositories${NC}"
if [ $failed_count -gt 0 ]; then
    echo -e "${RED}❌ Failed to update: $failed_count repositories${NC}"
fi
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

if [ $failed_count -eq 0 ]; then
    echo -e "\n${GREEN}🎉 All repositories updated successfully!${NC}"
    exit 0
else
    echo -e "\n${RED}⚠️  Some updates failed. Please check the errors above.${NC}"
    exit 1
fi
