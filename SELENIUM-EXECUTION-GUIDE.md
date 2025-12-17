# 🚀 SELENIUM TESTS - QUICK EXECUTION GUIDE

## Step-by-Step Instructions to Run Selenium Tests

---

## ✅ Prerequisites Check

### 1. Python Installation
Open PowerShell and check:
```powershell
python --version
```
**Expected**: Python 3.8 or higher

If not installed, download from: https://www.python.org/downloads/

### 2. Google Chrome Browser
- Chrome must be installed
- ChromeDriver will be installed automatically

### 3. Application Running
- Application must be accessible at: **http://135.171.156.197**
- Open browser and verify it loads

---

## 📦 Installation Steps

### Step 1: Navigate to Test Directory
```powershell
cd "E:\University stuff\Semester 7\DevOps\DevOps Final\Faculty managment system\selenium-tests"
```

### Step 2: Install Dependencies
```powershell
python -m pip install -r requirements.txt
```

**Wait for installation to complete** (takes 1-2 minutes)

You should see:
```
Successfully installed selenium-4.15.2 pytest-7.4.3 pytest-html-4.1.1 webdriver-manager-4.0.1
```

---

## 🧪 Running the Tests

### Method 1: Using Python Script (RECOMMENDED)

```powershell
python run_tests.py
```

### Method 2: Using PowerShell Script

```powershell
.\run_tests.ps1
```

### Method 3: Direct pytest Command

```powershell
python -m pytest test_faculty_system.py -v --html=test_report.html --self-contained-html -s
```

---

## 📊 Expected Output

You should see output like this:

```
============================================================
SELENIUM TEST SUITE - FACULTY MANAGEMENT SYSTEM
============================================================

Running Selenium tests...
------------------------------------------------------------

=== TEST 1: Homepage Loads ===
✓ Navigated to: http://135.171.156.197
✓ Page title verified: Faculty Management System
✓ Username field is present
✓ Password field is present
✓ Login button is present
✅ TEST 1 PASSED: Homepage loaded successfully

=== TEST 2: User Registration and Login ===
✓ Clicked Register link
✓ Entered username: testuser_abc123
✓ Entered email: test_abc123@example.com
✓ Entered password
✓ Clicked Register button
✓ Redirected to login page after registration
✓ Entered username for login: testuser_abc123
✓ Entered password for login
✓ Clicked Login button
✓ Successfully logged in, redirected to: /dashboard
✓ Dashboard page loaded successfully
✅ TEST 2 PASSED: Registration and login successful

=== TEST 3: Add Faculty Member ===
✓ Clicked Add Faculty link
✓ Navigated to Add Faculty page
✓ Entered faculty name: Dr. Test Faculty 1234
✓ Entered department: Computer Science
✓ Entered email: faculty1234@university.edu
✓ Entered phone: 555-1234
✓ Clicked Add Faculty button
✓ Form submitted successfully
✅ TEST 3 PASSED: Faculty member added successfully

=== TEST 4: Faculty List Updates ===
✓ Clicked Faculty List link
✓ Navigated to Faculty List page
✓ Faculty list elements found: 5 elements
✓ Added faculty 'Dr. Test Faculty 1234' appears in the list
✅ TEST 4 PASSED: Faculty list displays and updates correctly

=== TEST 5: Navigation Between Pages ===
✓ Navigation to Dashboard successful
✓ Navigation to Faculty List successful
✓ Navigation to Add Faculty successful
✓ Navigation back to Dashboard successful
✓ Logout successful, redirected to login page
✅ TEST 5 PASSED: Navigation between pages works correctly

------------------------------------------------------------
✅ ALL TESTS PASSED!

Test report generated: test_report.html
============================================================
```

---

## 📄 Viewing the HTML Report

### Step 1: Locate the Report
After tests complete, you'll find: `test_report.html` in the `selenium-tests` folder

### Step 2: Open the Report
**Option A**: Double-click `test_report.html` in File Explorer

**Option B**: From PowerShell:
```powershell
start test_report.html
```

### Step 3: Review the Report
The HTML report shows:
- ✅ Test summary (5 passed, 0 failed)
- ⏱️ Execution time for each test
- 📝 Detailed test results
- ❌ Error messages (if any tests failed)

---

## 📸 Taking Screenshots for Submission

### Screenshot 1: Installation
**Command**:
```powershell
python -m pip install -r requirements.txt
```
**Capture**: Terminal showing successful installation

### Screenshot 2: Test Execution
**Command**:
```powershell
python run_tests.py
```
**Capture**: Terminal showing all 5 tests running with ✓ marks

### Screenshot 3: Test Results
**Capture**: Terminal showing "✅ ALL TESTS PASSED!"

### Screenshot 4: HTML Report - Summary
**Capture**: Browser showing test_report.html with test summary

### Screenshot 5: HTML Report - Details
**Capture**: Browser showing individual test details in report

### Screenshot 6: Test Files
**Capture**: File Explorer showing selenium-tests folder contents

---

## 🔧 Troubleshooting

### Issue 1: "python is not recognized"

**Solution**: Add Python to PATH or use full path:
```powershell
C:\Users\YourUsername\AppData\Local\Programs\Python\Python311\python.exe run_tests.py
```

### Issue 2: "No module named 'selenium'"

**Solution**: Install dependencies again:
```powershell
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

### Issue 3: "ChromeDriver not found"

**Solution**: webdriver-manager will download it automatically on first run. Just wait.

### Issue 4: "Connection refused" or "Unable to connect"

**Solution**: Verify application is running:
```powershell
# Check if application is accessible
curl http://135.171.156.197

# Or open in browser
start http://135.171.156.197
```

If not accessible, check AKS pods:
```powershell
kubectl get pods -n faculty-management
kubectl get service faculty-frontend -n faculty-management
```

### Issue 5: Tests fail with "Element not found"

**Solution**: Application might be slow. Increase wait time:

Edit `test_faculty_system.py` line 44:
```python
self.driver.implicitly_wait(20)  # Increase from 10 to 20 seconds
```

Then run tests again.

### Issue 6: "Permission denied" on run_tests.ps1

**Solution**: Run PowerShell as Administrator or use:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\run_tests.ps1
```

---

## ⏱️ Test Duration

**Expected Time**: 60-90 seconds for all 5 tests

Each test includes:
- Browser startup
- Page navigation
- Element interactions
- Verification checks
- Browser cleanup

---

## ✅ Success Criteria

Tests are successful when you see:

1. ✅ All 5 tests show "PASSED"
2. ✅ Console shows "✅ ALL TESTS PASSED!"
3. ✅ HTML report shows "5 passed, 0 failed"
4. ✅ No error messages in output
5. ✅ test_report.html file is created

---

## 📋 Quick Command Reference

```powershell
# Navigate to test directory
cd selenium-tests

# Install dependencies
python -m pip install -r requirements.txt

# Run tests (choose one)
python run_tests.py                    # Recommended
.\run_tests.ps1                        # PowerShell script
pytest test_faculty_system.py -v      # Direct pytest

# View report
start test_report.html

# Check Python version
python --version

# Check installed packages
python -m pip list

# Reinstall dependencies
python -m pip install -r requirements.txt --force-reinstall
```

---

## 🎯 For Grading Submission

### Required Screenshots:
1. ✅ Terminal showing test execution
2. ✅ Terminal showing all tests passed
3. ✅ HTML report summary page
4. ✅ HTML report details page
5. ✅ Test files in File Explorer

### Required Files:
1. ✅ test_faculty_system.py (test code)
2. ✅ test_report.html (generated report)
3. ✅ requirements.txt (dependencies)
4. ✅ README.md (documentation)

### Verification Checklist:
- [ ] Python 3.8+ installed
- [ ] Chrome browser installed
- [ ] Application accessible at http://135.171.156.197
- [ ] Dependencies installed successfully
- [ ] All 5 tests pass
- [ ] HTML report generated
- [ ] Screenshots taken
- [ ] Files ready for submission

---

## 🎉 You're Ready!

Follow these steps and you'll have:
- ✅ All tests passing
- ✅ HTML report generated
- ✅ Screenshots for submission
- ✅ Section E complete!

**Good luck with your submission!** 🚀

