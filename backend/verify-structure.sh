#!/bin/bash

# Verification script for Spring Boot project structure

echo "================================================"
echo "Dofus Tools API - Project Structure Verification"
echo "================================================"
echo ""

# Check directory structure
echo "📁 Directory Structure Check:"
echo ""

check_dir() {
    if [ -d "$1" ]; then
        echo "  ✅ $1"
        return 0
    else
        echo "  ❌ $1 (missing)"
        return 1
    fi
}

check_file() {
    if [ -f "$1" ]; then
        echo "  ✅ $1"
        return 0
    else
        echo "  ❌ $1 (missing)"
        return 1
    fi
}

# Check main directories
check_dir "src/main/java/com/dofustools"
check_dir "src/main/java/com/dofustools/config"
check_dir "src/main/java/com/dofustools/controller"
check_dir "src/main/java/com/dofustools/service"
check_dir "src/main/java/com/dofustools/repository"
check_dir "src/main/java/com/dofustools/model"
check_dir "src/main/java/com/dofustools/util"
check_dir "src/main/resources"
check_dir "src/test/java/com/dofustools"

echo ""
echo "📄 Critical Files Check:"
echo ""

# Check critical files
check_file "pom.xml"
check_file "src/main/java/com/dofustools/DofusToolsApplication.java"
check_file "src/main/resources/application.yml"
check_file "README.md"

echo ""
echo "📋 POM Configuration:"
echo ""

if [ -f "pom.xml" ]; then
    echo "  Group ID: $(grep -A1 '<parent>' pom.xml | grep '<groupId>' | sed 's/.*<groupId>\(.*\)<\/groupId>.*/\1/' | head -1)"
    echo "  Artifact ID: $(grep '<artifactId>dofus-tools-api</artifactId>' pom.xml | sed 's/.*<artifactId>\(.*\)<\/artifactId>.*/\1/')"
    echo "  Version: $(grep '<version>1.0.0-SNAPSHOT</version>' pom.xml | head -1 | sed 's/.*<version>\(.*\)<\/version>.*/\1/')"
    echo "  Java Version: $(grep '<java.version>' pom.xml | sed 's/.*<java.version>\(.*\)<\/java.version>.*/\1/')"
    echo "  Spring Boot: $(grep -A2 '<parent>' pom.xml | grep '<version>' | sed 's/.*<version>\(.*\)<\/version>.*/\1/' | head -1)"
fi

echo ""
echo "🔧 Application Configuration:"
echo ""

if [ -f "src/main/resources/application.yml" ]; then
    echo "  Server Port: $(grep 'port:' src/main/resources/application.yml | awk '{print $2}')"
    echo "  Context Path: $(grep 'context-path:' src/main/resources/application.yml | awk '{print $2}')"
    echo "  App Name: $(grep 'name:' src/main/resources/application.yml | awk '{print $2}' | head -1)"
fi

echo ""
echo "📊 Main Application Class:"
echo ""

if [ -f "src/main/java/com/dofustools/DofusToolsApplication.java" ]; then
    echo "  ✅ DofusToolsApplication.java exists"
    if grep -q "@SpringBootApplication" "src/main/java/com/dofustools/DofusToolsApplication.java"; then
        echo "  ✅ @SpringBootApplication annotation found"
    fi
    if grep -q "SpringApplication.run" "src/main/java/com/dofustools/DofusToolsApplication.java"; then
        echo "  ✅ SpringApplication.run() found"
    fi
fi

echo ""
echo "================================================"
echo "Project structure verification complete!"
echo "================================================"
