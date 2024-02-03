#!/bin/bash

# Web Application Security Scanner

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <target_url>"
    exit 1
fi

target_url="$1"

# Function to check for SQL injection vulnerability
check_sql_injection() {
    echo "Checking for SQL Injection..."
    result=$(curl -s -L "$target_url' OR '1'='1" | grep -i "error\|exception\|warning")
    
    if [ -n "$result" ]; then
        echo "Potential SQL Injection Vulnerability detected."
    else
        echo "No SQL Injection Vulnerability detected."
    fi
}

# Function to check for Cross-Site Scripting (XSS) vulnerability
check_xss() {
    echo "Checking for Cross-Site Scripting (XSS)..."
    result=$(curl -s -L "$target_url<script>alert('XSS');</script>" | grep -i "<script>alert('XSS');</script>")
    
    if [ -n "$result" ]; then
        echo "Potential XSS Vulnerability detected."
    else
        echo "No XSS Vulnerability detected."
    fi
}

# Perform security checks
check_sql_injection
check_xss
