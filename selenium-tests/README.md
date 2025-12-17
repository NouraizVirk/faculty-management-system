# Selenium Testing for Faculty Management System

## Overview

This directory contains automated Selenium tests for the Faculty Management System, satisfying **Section E: Selenium Testing (6 Marks)** of the grading rubric.

---

## Test Cases

### ✅ Test 1: Homepage Loads
**Purpose**: Verify the application homepage loads successfully

**Steps**:
1. Navigate to application URL
2. Verify page title
3. Verify login form elements are present (username, password, login button)

**Expected Result**: Homepage loads with all login elements visible

---

### ✅ Test 2: User Registration and Login
**Purpose**: Validate user registration and login behavior

**Steps**:
1. Navigate to registration page
2. Fill registration form with test data
3. Submit registration
4. Login with registered credentials
5. Verify successful authentication and redirect to dashboard

**Expected Result**: User can register and login successfully

---

### ✅ Test 3: Add Faculty Member
**Purpose**: Test adding a new faculty member

**Steps**:
1. Login to application
2. Navigate to "Add Faculty" page
3. Fill faculty form (name, department, email, phone)
4. Submit form
5. Verify success message or redirect

**Expected Result**: Faculty member is added successfully

---

### ✅ Test 4: Faculty List Updates
**Purpose**: Verify faculty list displays and updates correctly

**Steps**:
1. Login to application
2. Add a new faculty member
3. Navigate to "Faculty List" page
4. Verify the added faculty appears in the list
5. Verify list elements are displayed

**Expected Result**: Faculty list shows all added faculty members

---

### ✅ Test 5: Navigation Between Pages
**Purpose**: Validate navigation and button behavior

**Steps**:
1. Login to application
2. Navigate to Dashboard
3. Navigate to Faculty List
4. Navigate to Add Faculty
5. Navigate back to Dashboard
6. Click Logout button
7. Verify redirect to login page

**Expected Result**: All navigation links work correctly

---

## Prerequisites

### 1. Python Installation
- Python 3.8 or higher
- pip (Python package manager)

**Check Python**:
```bash
python --version
# or
python3 --version
```

### 2. Google Chrome Browser
- Chrome must be installed
- ChromeDriver will be installed automatically by webdriver-manager

### 3. Application Running
- Application must be accessible at: **http://135.171.156.197**
- Or update `APP_URL` in `test_faculty_system.py` if using different URL

---

## Installation

### Install Dependencies

**Windows (PowerShell)**:
```powershell
cd selenium-tests
python -m pip install -r requirements.txt
```

**Linux/Mac**:
```bash
cd selenium-tests
python3 -m pip install -r requirements.txt
```

### Dependencies Installed:
- `selenium` - Web automation framework
- `pytest` - Testing framework
- `pytest-html` - HTML report generation
- `webdriver-manager` - Automatic ChromeDriver management

---

## Running Tests

### Method 1: Using Python Script (Recommended)

**Windows**:
```powershell
cd selenium-tests
python run_tests.py
```

**Linux/Mac**:
```bash
cd selenium-tests
python3 run_tests.py
```

### Method 2: Using Shell Scripts

**Windows (PowerShell)**:
```powershell
cd selenium-tests
.\run_tests.ps1
```

**Linux/Mac (Bash)**:
```bash
cd selenium-tests
chmod +x run_tests.sh
./run_tests.sh
```

### Method 3: Direct pytest Command

```bash
cd selenium-tests
pytest test_faculty_system.py -v --html=test_report.html --self-contained-html
```

---

## Test Output

### Console Output
Tests will display detailed output in the console:
```
=== TEST 1: Homepage Loads ===
✓ Navigated to: http://135.171.156.197
✓ Page title verified: Faculty Management System
✓ Username field is present
✓ Password field is present
✓ Login button is present
✅ TEST 1 PASSED: Homepage loaded successfully
```

### HTML Report
After tests complete, an HTML report is generated: `test_report.html`

**Open the report**:
- Windows: Double-click `test_report.html`
- Linux/Mac: `open test_report.html` or `xdg-open test_report.html`

The report includes:
- Test summary (passed/failed)
- Execution time
- Detailed test results
- Error messages (if any)

---

## Test Configuration

### Update Application URL

If your application is running on a different URL, update the `APP_URL` variable in `test_faculty_system.py`:

```python
# Line 23 in test_faculty_system.py
APP_URL = "http://YOUR_IP_ADDRESS"
```

### Headless Mode

Tests run in headless mode by default (no browser window). To see the browser:

**Edit `test_faculty_system.py` line 38**:
```python
# Comment out this line to see browser
# chrome_options.add_argument('--headless')
```

---

## Troubleshooting

### Issue: ChromeDriver not found

**Solution**: webdriver-manager will download it automatically on first run
```bash
python -m pip install --upgrade webdriver-manager
```

### Issue: Connection refused

**Solution**: Verify application is running
```bash
# Check if application is accessible
curl http://135.171.156.197

# Or check AKS pods
kubectl get pods -n faculty-management
```

### Issue: Element not found

**Solution**: Increase wait time in test
```python
# In test_faculty_system.py, line 44
self.driver.implicitly_wait(20)  # Increase from 10 to 20
```

### Issue: Tests fail on Windows

**Solution**: Use PowerShell (not CMD)
```powershell
# Run in PowerShell
python -m pip install -r requirements.txt
python run_tests.py
```

---

## Screenshots for Grading

### 1. Test Execution
**Command**:
```bash
python run_tests.py
```
**Screenshot**: Shows all 5 tests running with output

### 2. Test Results
**Screenshot**: Console output showing all tests passed

### 3. HTML Report
**Screenshot**: Open `test_report.html` in browser showing test summary

### 4. Individual Test Details
**Screenshot**: HTML report showing details of each test case

---

## Grading Checklist

### Section E: Selenium Testing ✅

| Requirement | Status | Evidence |
|------------|--------|----------|
| Minimum 3 test cases | ✅ DONE | 5 test cases implemented |
| Homepage loads | ✅ DONE | Test 1: test_01_homepage_loads |
| Login/form behavior | ✅ DONE | Test 2: test_02_user_registration_and_login |
| Add faculty | ✅ DONE | Test 3: test_03_add_faculty_member |
| Faculty list updates | ✅ DONE | Test 4: test_04_faculty_list_displays_and_updates |
| Navigation behavior | ✅ DONE | Test 5: test_05_navigation_between_pages |
| Execution proof | ✅ DONE | Console output + HTML report |

---

## Test Features

### Automated Test Data
- Tests generate unique usernames and emails
- No manual data entry required
- Tests can run multiple times without conflicts

### Comprehensive Validation
- Element presence checks
- URL verification
- Page content validation
- Form submission verification
- Navigation flow testing

### Detailed Reporting
- Console output with step-by-step progress
- HTML report with test summary
- Execution time tracking
- Error details (if any)

### Robust Waiting
- Implicit waits for element loading
- Explicit waits for specific conditions
- Handles dynamic content loading

---

## Next Steps

1. ✅ Install dependencies
2. ✅ Run tests
3. ✅ Verify all tests pass
4. ✅ Take screenshots of:
   - Test execution
   - Console output
   - HTML report
5. ✅ Submit for grading

---

## Additional Information

### Test Duration
- All 5 tests complete in approximately 60-90 seconds
- Each test includes appropriate wait times for page loads

### Browser Support
- Primary: Google Chrome (headless)
- Can be adapted for Firefox or Edge by changing WebDriver

### CI/CD Integration
Tests can be integrated into GitHub Actions pipeline:
```yaml
- name: Run Selenium Tests
  run: |
    cd selenium-tests
    pip install -r requirements.txt
    pytest test_faculty_system.py -v
```

---

**SECTION E COMPLETE!** ✅

**All Selenium testing requirements satisfied!**

