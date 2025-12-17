"""
Selenium Test Suite for Faculty Management System
Section E: Selenium Testing (6 Marks)

Test Cases:
1. Homepage loads successfully
2. User registration and login
3. Add faculty member
4. Faculty list updates and displays correctly
5. Navigation between pages
"""

import time
import pytest
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
import random
import string

# Application URL - Update this with your AKS public IP
APP_URL = "http://135.171.156.197"

class TestFacultyManagementSystem:
    """Test suite for Faculty Management System"""
    
    @pytest.fixture(autouse=True)
    def setup_and_teardown(self):
        """Setup and teardown for each test"""
        # Setup Chrome options
        chrome_options = Options()
        chrome_options.add_argument('--headless')  # Run in headless mode
        chrome_options.add_argument('--no-sandbox')
        chrome_options.add_argument('--disable-dev-shm-usage')
        chrome_options.add_argument('--disable-gpu')
        chrome_options.add_argument('--window-size=1920,1080')
        
        # Initialize WebDriver
        self.driver = webdriver.Chrome(
            service=Service(ChromeDriverManager().install()),
            options=chrome_options
        )
        self.driver.implicitly_wait(10)
        self.wait = WebDriverWait(self.driver, 15)
        
        # Generate unique test data
        random_suffix = ''.join(random.choices(string.ascii_lowercase + string.digits, k=6))
        self.test_username = f"testuser_{random_suffix}"
        self.test_email = f"test_{random_suffix}@example.com"
        self.test_password = "TestPass123!"
        
        yield
        
        # Teardown
        self.driver.quit()
    
    def test_01_homepage_loads(self):
        """
        TEST CASE 1: Verify homepage loads successfully
        - Navigate to application URL
        - Verify page title
        - Verify login form is present
        """
        print("\n=== TEST 1: Homepage Loads ===")
        
        # Navigate to homepage
        self.driver.get(APP_URL)
        print(f"✓ Navigated to: {APP_URL}")
        
        # Wait for page to load
        time.sleep(2)
        
        # Verify page title contains expected text
        assert "Faculty Management" in self.driver.title or "React App" in self.driver.title
        print(f"✓ Page title verified: {self.driver.title}")
        
        # Verify login form elements are present
        username_field = self.wait.until(
            EC.presence_of_element_located((By.NAME, "username"))
        )
        assert username_field.is_displayed()
        print("✓ Username field is present")
        
        password_field = self.driver.find_element(By.NAME, "password")
        assert password_field.is_displayed()
        print("✓ Password field is present")
        
        login_button = self.driver.find_element(By.XPATH, "//button[contains(text(), 'Login')]")
        assert login_button.is_displayed()
        print("✓ Login button is present")
        
        print("✅ TEST 1 PASSED: Homepage loaded successfully\n")
    
    def test_02_user_registration_and_login(self):
        """
        TEST CASE 2: Validate user registration and login behavior
        - Register a new user
        - Login with registered credentials
        - Verify successful authentication
        """
        print("\n=== TEST 2: User Registration and Login ===")
        
        # Navigate to homepage
        self.driver.get(APP_URL)
        time.sleep(2)
        
        # Click on Register link
        register_link = self.wait.until(
            EC.element_to_be_clickable((By.LINK_TEXT, "Register"))
        )
        register_link.click()
        print("✓ Clicked Register link")
        time.sleep(1)
        
        # Fill registration form
        username_field = self.wait.until(
            EC.presence_of_element_located((By.NAME, "username"))
        )
        username_field.send_keys(self.test_username)
        print(f"✓ Entered username: {self.test_username}")
        
        email_field = self.driver.find_element(By.NAME, "email")
        email_field.send_keys(self.test_email)
        print(f"✓ Entered email: {self.test_email}")
        
        password_field = self.driver.find_element(By.NAME, "password")
        password_field.send_keys(self.test_password)
        print("✓ Entered password")
        
        # Submit registration
        register_button = self.driver.find_element(By.XPATH, "//button[contains(text(), 'Register')]")
        register_button.click()
        print("✓ Clicked Register button")
        time.sleep(2)
        
        # Should redirect to login page
        current_url = self.driver.current_url
        assert "/login" in current_url or current_url == APP_URL + "/"
        print("✓ Redirected to login page after registration")
        
        # Login with registered credentials
        username_field = self.wait.until(
            EC.presence_of_element_located((By.NAME, "username"))
        )
        username_field.clear()
        username_field.send_keys(self.test_username)
        print(f"✓ Entered username for login: {self.test_username}")
        
        password_field = self.driver.find_element(By.NAME, "password")
        password_field.clear()
        password_field.send_keys(self.test_password)
        print("✓ Entered password for login")
        
        login_button = self.driver.find_element(By.XPATH, "//button[contains(text(), 'Login')]")
        login_button.click()
        print("✓ Clicked Login button")
        time.sleep(3)
        
        # Verify successful login - should redirect to dashboard
        current_url = self.driver.current_url
        assert "/dashboard" in current_url
        print(f"✓ Successfully logged in, redirected to: {current_url}")
        
        # Verify dashboard elements
        dashboard_heading = self.wait.until(
            EC.presence_of_element_located((By.XPATH, "//*[contains(text(), 'Dashboard') or contains(text(), 'Welcome')]"))
        )
        assert dashboard_heading.is_displayed()
        print("✓ Dashboard page loaded successfully")
        
        print("✅ TEST 2 PASSED: Registration and login successful\n")
    
    def test_03_add_faculty_member(self):
        """
        TEST CASE 3: Add faculty member and verify
        - Login to application
        - Navigate to Add Faculty page
        - Fill and submit faculty form
        - Verify success message
        """
        print("\n=== TEST 3: Add Faculty Member ===")
        
        # First, register and login
        self._register_and_login()
        
        # Navigate to Add Faculty page
        add_faculty_link = self.wait.until(
            EC.element_to_be_clickable((By.LINK_TEXT, "Add Faculty"))
        )
        add_faculty_link.click()
        print("✓ Clicked Add Faculty link")
        time.sleep(2)
        
        # Verify we're on Add Faculty page
        assert "/add-faculty" in self.driver.current_url
        print("✓ Navigated to Add Faculty page")
        
        # Generate unique faculty data
        random_id = ''.join(random.choices(string.digits, k=4))
        faculty_name = f"Dr. Test Faculty {random_id}"
        faculty_dept = "Computer Science"
        faculty_email = f"faculty{random_id}@university.edu"
        faculty_phone = f"555-{random_id}"
        
        # Fill faculty form
        name_field = self.wait.until(
            EC.presence_of_element_located((By.NAME, "name"))
        )
        name_field.send_keys(faculty_name)
        print(f"✓ Entered faculty name: {faculty_name}")
        
        dept_field = self.driver.find_element(By.NAME, "department")
        dept_field.send_keys(faculty_dept)
        print(f"✓ Entered department: {faculty_dept}")
        
        email_field = self.driver.find_element(By.NAME, "email")
        email_field.send_keys(faculty_email)
        print(f"✓ Entered email: {faculty_email}")
        
        phone_field = self.driver.find_element(By.NAME, "phone")
        phone_field.send_keys(faculty_phone)
        print(f"✓ Entered phone: {faculty_phone}")
        
        # Submit form
        submit_button = self.driver.find_element(By.XPATH, "//button[contains(text(), 'Add Faculty')]")
        submit_button.click()
        print("✓ Clicked Add Faculty button")
        time.sleep(3)
        
        # Verify success - should redirect to faculty list or show success message
        current_url = self.driver.current_url
        assert "/faculty" in current_url or "/dashboard" in current_url
        print(f"✓ Form submitted successfully, current URL: {current_url}")
        
        print("✅ TEST 3 PASSED: Faculty member added successfully\n")
    
    def test_04_faculty_list_displays_and_updates(self):
        """
        TEST CASE 4: Verify faculty list displays and updates correctly
        - Login to application
        - Add a faculty member
        - Navigate to Faculty List
        - Verify faculty appears in list
        - Verify list functionality
        """
        print("\n=== TEST 4: Faculty List Updates ===")
        
        # Register and login
        self._register_and_login()
        
        # Add a faculty member first
        faculty_name = self._add_test_faculty()
        
        # Navigate to Faculty List
        faculty_list_link = self.wait.until(
            EC.element_to_be_clickable((By.LINK_TEXT, "Faculty List"))
        )
        faculty_list_link.click()
        print("✓ Clicked Faculty List link")
        time.sleep(2)
        
        # Verify we're on Faculty List page
        assert "/faculty" in self.driver.current_url
        print("✓ Navigated to Faculty List page")
        
        # Wait for faculty list to load
        time.sleep(2)
        
        # Verify faculty list table/cards are present
        try:
            # Try to find table or card elements
            faculty_elements = self.driver.find_elements(By.XPATH, 
                "//*[contains(@class, 'faculty') or contains(@class, 'card') or contains(@class, 'table')]"
            )
            assert len(faculty_elements) > 0
            print(f"✓ Faculty list elements found: {len(faculty_elements)} elements")
        except:
            # Alternative: check for any faculty-related content
            page_source = self.driver.page_source
            assert "faculty" in page_source.lower() or "department" in page_source.lower()
            print("✓ Faculty list content is present")
        
        # Verify the added faculty appears in the list
        page_source = self.driver.page_source
        assert faculty_name in page_source
        print(f"✓ Added faculty '{faculty_name}' appears in the list")
        
        print("✅ TEST 4 PASSED: Faculty list displays and updates correctly\n")
    
    def test_05_navigation_between_pages(self):
        """
        TEST CASE 5: Validate navigation and button behavior
        - Login to application
        - Navigate through all pages
        - Verify navigation links work
        - Verify page transitions
        """
        print("\n=== TEST 5: Navigation Between Pages ===")
        
        # Register and login
        self._register_and_login()
        
        # Test navigation to Dashboard
        dashboard_link = self.wait.until(
            EC.element_to_be_clickable((By.LINK_TEXT, "Dashboard"))
        )
        dashboard_link.click()
        time.sleep(1)
        assert "/dashboard" in self.driver.current_url
        print("✓ Navigation to Dashboard successful")
        
        # Test navigation to Faculty List
        faculty_list_link = self.wait.until(
            EC.element_to_be_clickable((By.LINK_TEXT, "Faculty List"))
        )
        faculty_list_link.click()
        time.sleep(1)
        assert "/faculty" in self.driver.current_url
        print("✓ Navigation to Faculty List successful")
        
        # Test navigation to Add Faculty
        add_faculty_link = self.wait.until(
            EC.element_to_be_clickable((By.LINK_TEXT, "Add Faculty"))
        )
        add_faculty_link.click()
        time.sleep(1)
        assert "/add-faculty" in self.driver.current_url
        print("✓ Navigation to Add Faculty successful")
        
        # Test back to Dashboard
        dashboard_link = self.wait.until(
            EC.element_to_be_clickable((By.LINK_TEXT, "Dashboard"))
        )
        dashboard_link.click()
        time.sleep(1)
        assert "/dashboard" in self.driver.current_url
        print("✓ Navigation back to Dashboard successful")
        
        # Test Logout button
        logout_button = self.wait.until(
            EC.element_to_be_clickable((By.XPATH, "//button[contains(text(), 'Logout')]"))
        )
        logout_button.click()
        time.sleep(2)
        
        # Should redirect to login page
        current_url = self.driver.current_url
        assert current_url == APP_URL + "/" or "/login" in current_url
        print("✓ Logout successful, redirected to login page")
        
        print("✅ TEST 5 PASSED: Navigation between pages works correctly\n")
    
    # Helper methods
    def _register_and_login(self):
        """Helper method to register and login a user"""
        # Navigate to homepage
        self.driver.get(APP_URL)
        time.sleep(2)
        
        # Register
        register_link = self.wait.until(
            EC.element_to_be_clickable((By.LINK_TEXT, "Register"))
        )
        register_link.click()
        time.sleep(1)
        
        username_field = self.wait.until(
            EC.presence_of_element_located((By.NAME, "username"))
        )
        username_field.send_keys(self.test_username)
        
        email_field = self.driver.find_element(By.NAME, "email")
        email_field.send_keys(self.test_email)
        
        password_field = self.driver.find_element(By.NAME, "password")
        password_field.send_keys(self.test_password)
        
        register_button = self.driver.find_element(By.XPATH, "//button[contains(text(), 'Register')]")
        register_button.click()
        time.sleep(2)
        
        # Login
        username_field = self.wait.until(
            EC.presence_of_element_located((By.NAME, "username"))
        )
        username_field.clear()
        username_field.send_keys(self.test_username)
        
        password_field = self.driver.find_element(By.NAME, "password")
        password_field.clear()
        password_field.send_keys(self.test_password)
        
        login_button = self.driver.find_element(By.XPATH, "//button[contains(text(), 'Login')]")
        login_button.click()
        time.sleep(3)
    
    def _add_test_faculty(self):
        """Helper method to add a test faculty member"""
        # Navigate to Add Faculty
        add_faculty_link = self.wait.until(
            EC.element_to_be_clickable((By.LINK_TEXT, "Add Faculty"))
        )
        add_faculty_link.click()
        time.sleep(2)
        
        # Generate unique faculty data
        random_id = ''.join(random.choices(string.digits, k=4))
        faculty_name = f"Dr. Test Faculty {random_id}"
        
        # Fill form
        name_field = self.wait.until(
            EC.presence_of_element_located((By.NAME, "name"))
        )
        name_field.send_keys(faculty_name)
        
        dept_field = self.driver.find_element(By.NAME, "department")
        dept_field.send_keys("Computer Science")
        
        email_field = self.driver.find_element(By.NAME, "email")
        email_field.send_keys(f"faculty{random_id}@university.edu")
        
        phone_field = self.driver.find_element(By.NAME, "phone")
        phone_field.send_keys(f"555-{random_id}")
        
        # Submit
        submit_button = self.driver.find_element(By.XPATH, "//button[contains(text(), 'Add Faculty')]")
        submit_button.click()
        time.sleep(3)
        
        return faculty_name


if __name__ == "__main__":
    # Run tests with pytest
    pytest.main([__file__, "-v", "--html=test_report.html", "--self-contained-html"])
