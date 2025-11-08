#!/bin/bash

# Script to download Spring Boot dependencies using curl
# This workaround is needed due to Maven DNS resolution issues

set -e

MAVEN_REPO="$HOME/.m2/repository"
MAVEN_CENTRAL="https://repo.maven.apache.org/maven2"
SPRING_BOOT_VERSION="3.3.5"

echo "Downloading Spring Boot dependencies..."

# Function to download Maven artifact
download_artifact() {
    local group_path=$1
    local artifact=$2
    local version=$3
    local filename=$4

    local target_dir="$MAVEN_REPO/$group_path/$artifact/$version"
    mkdir -p "$target_dir"

    local url="$MAVEN_CENTRAL/$group_path/$artifact/$version/$filename"
    local target_file="$target_dir/$filename"

    if [ ! -f "$target_file" ]; then
        echo "Downloading $filename..."
        curl -L -s -o "$target_file" "$url" || echo "Failed to download $url"
    fi
}

# Download Spring Boot Dependencies
download_artifact "org/springframework/boot" "spring-boot-dependencies" "$SPRING_BOOT_VERSION" "spring-boot-dependencies-$SPRING_BOOT_VERSION.pom"

# Download Spring Boot Starters
download_artifact "org/springframework/boot" "spring-boot-starter" "$SPRING_BOOT_VERSION" "spring-boot-starter-$SPRING_BOOT_VERSION.pom"
download_artifact "org/springframework/boot" "spring-boot-starter" "$SPRING_BOOT_VERSION" "spring-boot-starter-$SPRING_BOOT_VERSION.jar"

download_artifact "org/springframework/boot" "spring-boot-starter-web" "$SPRING_BOOT_VERSION" "spring-boot-starter-web-$SPRING_BOOT_VERSION.pom"
download_artifact "org/springframework/boot" "spring-boot-starter-web" "$SPRING_BOOT_VERSION" "spring-boot-starter-web-$SPRING_BOOT_VERSION.jar"

download_artifact "org/springframework/boot" "spring-boot-starter-actuator" "$SPRING_BOOT_VERSION" "spring-boot-starter-actuator-$SPRING_BOOT_VERSION.pom"
download_artifact "org/springframework/boot" "spring-boot-starter-actuator" "$SPRING_BOOT_VERSION" "spring-boot-starter-actuator-$SPRING_BOOT_VERSION.jar"

download_artifact "org/springframework/boot" "spring-boot-starter-test" "$SPRING_BOOT_VERSION" "spring-boot-starter-test-$SPRING_BOOT_VERSION.pom"
download_artifact "org/springframework/boot" "spring-boot-starter-test" "$SPRING_BOOT_VERSION" "spring-boot-starter-test-$SPRING_BOOT_VERSION.jar"

# Core Spring Boot artifacts
download_artifact "org/springframework/boot" "spring-boot" "$SPRING_BOOT_VERSION" "spring-boot-$SPRING_BOOT_VERSION.pom"
download_artifact "org/springframework/boot" "spring-boot" "$SPRING_BOOT_VERSION" "spring-boot-$SPRING_BOOT_VERSION.jar"

download_artifact "org/springframework/boot" "spring-boot-autoconfigure" "$SPRING_BOOT_VERSION" "spring-boot-autoconfigure-$SPRING_BOOT_VERSION.pom"
download_artifact "org/springframework/boot" "spring-boot-autoconfigure" "$SPRING_BOOT_VERSION" "spring-boot-autoconfigure-$SPRING_BOOT_VERSION.jar"

echo "Basic dependencies downloaded. You may need to run 'mvn dependency:go-offline' with network access for complete dependency resolution."
