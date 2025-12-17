#!/bin/bash

# Bash script to run Selenium tests on Linux/Mac

echo "============================================================"
echo "SELENIUM TEST SUITE - FACULTY MANAGEMENT SYSTEM"
echo "============================================================"
echo ""

# Check if Python is installed
echo "Checking Python installation..."
if command -v python3 &> /dev/null; then
    PYTHON_CMD=python3
    echo "✓ Python installed: $(python3 --version)"
elif command -v python &> /dev/null; then
    PYTHON_CMD=python
    echo "✓ Python installed: $(python --version)"
else
    echo "✗ Python not found. Please install Python 3.8+"
    exit 1
fi

# Install dependencies
echo ""
echo "Installing dependencies..."
$PYTHON_CMD -m pip install -r requirements.txt

if [ $? -eq 0 ]; then
    echo "✓ Dependencies installed successfully"
else
    echo "✗ Failed to install dependencies"
    exit 1
fi

# Run tests
echo ""
echo "Running Selenium tests..."
echo "------------------------------------------------------------"
echo ""

$PYTHON_CMD -m pytest test_faculty_system.py -v --html=test_report.html --self-contained-html -s

echo ""
echo "------------------------------------------------------------"

if [ $? -eq 0 ]; then
    echo "✅ ALL TESTS PASSED!"
else
    echo "❌ SOME TESTS FAILED"
fi

echo ""
echo "Test report generated: test_report.html"
echo "============================================================"
