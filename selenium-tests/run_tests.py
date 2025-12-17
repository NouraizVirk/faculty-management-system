"""
Simple test runner for Selenium tests
Runs tests and generates HTML report
"""

import subprocess
import sys
import os

def main():
    """Run Selenium tests with pytest"""
    print("=" * 60)
    print("SELENIUM TEST SUITE - FACULTY MANAGEMENT SYSTEM")
    print("=" * 60)
    print()
    
    # Check if requirements are installed
    print("Checking dependencies...")
    try:
        import selenium
        import pytest
        from webdriver_manager.chrome import ChromeDriverManager
        print("✓ All dependencies installed")
    except ImportError as e:
        print(f"✗ Missing dependency: {e}")
        print("\nInstalling dependencies...")
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])
        print("✓ Dependencies installed")
    
    print()
    print("Running Selenium tests...")
    print("-" * 60)
    print()
    
    # Run pytest with HTML report
    result = subprocess.run([
        sys.executable, "-m", "pytest",
        "test_faculty_system.py",
        "-v",
        "--html=test_report.html",
        "--self-contained-html",
        "-s"  # Show print statements
    ])
    
    print()
    print("-" * 60)
    
    if result.returncode == 0:
        print("✅ ALL TESTS PASSED!")
    else:
        print("❌ SOME TESTS FAILED")
    
    print()
    print("Test report generated: test_report.html")
    print("=" * 60)
    
    return result.returncode

if __name__ == "__main__":
    sys.exit(main())
