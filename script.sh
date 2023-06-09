#!/bin/bash

# Default values
name="demo"
dependencies=""

# Function to display the script usage
function display_usage() {
    echo "Usage: $0 [-n|--name=<name>] [-d|--dependencies=<dependencies>]"
    echo "  -n, --name=<name>           Project name (default: demo)"
    echo "  -d, --dependencies=<dependencies>   Project dependencies (default: none)"
}

# Parse command-line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -n=*|--name=*)
            name="${1#*=}"
            shift
            ;;
        -d=*|--dependencies=*)
            dependencies="${1#*=}"
            shift
            ;;
        *)
            echo "Unknown parameter: $1"
            display_usage
            exit 1
            ;;
    esac
done

name_project="$name"
# Remove "-" from the name and store it in name_project
artifact=$(echo "$name" | sed 's/-//g')
name=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1')

# Use the option arguments in the command
spring init --build=gradle -t=gradle-project -l=java -b=3.1.0 -g=com.example -a="$artifact" -n="$name" -d="$dependencies" -p=jar -j=17 -x "$name_project"