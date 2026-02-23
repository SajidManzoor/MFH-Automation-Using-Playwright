# 🧬 MaleFromHome Admin - Automated Testing Suite

[![Playwright Tests](https://github.com/SajidManzoor/MFH-Automation-Using-Playwright/actions/workflows/playwright.yml/badge.svg)](https://github.com/SajidManzoor/MFH-Automation-Using-Playwright/actions)
[![Node.js Version](https://img.shields.io/badge/node-%3E%3D18.0.0-brightgreen)](https://nodejs.org/)
[![License](https://img.shields.io/badge/license-Proprietary-red)](LICENSE)

> End-to-end automated testing framework for MaleFromHome Admin platform using Playwright

---

## 📋 Table of Contents

- [About the Project](#about-the-project)
- [Tech Stack](#tech-stack)
- [Key Features](#key-features)
- [Prerequisites](#prerequisites)
- [Getting Started](#getting-started)
  - [Installation](#installation)
  - [Authentication Setup](#authentication-setup)
- [Running Tests](#running-tests)
- [Project Structure](#project-structure)
- [Test Coverage](#test-coverage)
- [CI/CD Pipeline](#cicd-pipeline)
- [Reporting](#reporting)
  - [HTML Reports](#html-reports)
  - [Allure Reports](#allure-reports)
- [Environment Configuration](#environment-configuration)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)
- [Contributing](#contributing)
- [Team](#team)
- [License](#license)

---

## 🎯 About the Project

This automation framework provides comprehensive test coverage for the **MaleFromHome Admin** platform, a healthcare/medical testing management system. The suite automates critical workflows including order management, kit tracking, test result recording, and administrative operations.

**Purpose:**
- Internal QA validation
- Client deliverable for quality assurance
- Regression testing automation
- CI/CD integration for continuous quality monitoring

**Application Under Test:**
- **Platform**: MaleFromHome Admin (Test Environment)
- **URL**: `https://new-test-admin.malefromhome.com`
- **Domain**: Healthcare/Medical Testing Management

---

## 🛠️ Tech Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| **Playwright** | ^1.58.2 | E2E testing framework |
| **Node.js** | ≥18.0.0 | Runtime environment |
| **JavaScript** | ES6+ | Programming language |
| **Dotenv** | ^17.2.3 | Environment variable management |
| **Allure** | ^3.4.5 | Advanced test reporting |
| **GitHub Actions** | - | CI/CD automation |

---

## ✨ Key Features

### 🎭 Test Architecture
- ✅ **Page Object Model (POM)** - Maintainable and scalable structure
- ✅ **Reusable Utilities** - Common functions for authentication, search, and validation
- ✅ **Modular Design** - Separated concerns for Orders, Kits, and Pages

### 🔐 Authentication & Security
- ✅ **Persistent Authentication** - Saves login state to avoid repeated MFA
- ✅ **AWS Cognito Integration** - Secure token-based authentication
- ✅ **Environment Variables** - Sensitive data protection

### 📊 Advanced Testing Capabilities
- ✅ **File Operations** - Document downloads, PDF validation
- ✅ **Media Testing** - Camera/video testing with fake streams
- ✅ **Dynamic Waits** - Smart waiting strategies for reliable tests
- ✅ **Cross-browser Support** - Chromium, Firefox, WebKit compatibility

### 📈 Reporting & CI/CD
- ✅ **Dual Reporting** - HTML and Allure reports
- ✅ **Screenshot/Video Capture** - On test failures
- ✅ **GitHub Actions** - Automated test execution on every push
- ✅ **Artifact Storage** - Test results preserved for 30 days

---

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js**: v18.0.0 or higher ([Download](https://nodejs.org/))
- **npm**: v9.0.0 or higher (comes with Node.js)
- **Git**: Latest version ([Download](https://git-scm.com/))
- **Access Credentials**: Valid admin credentials for the test environment

**Verify installations:**
```bash
node --version    # Should show v18.0.0 or higher
npm --version     # Should show v9.0.0 or higher
git --version     # Should show latest version
```

---

## 🚀 Getting Started

### Installation

#### 1. Clone the Repository
```bash
git clone https://github.com/SajidManzoor/MFH-Automation-Using-Playwright.git
cd MFH-Automation-Using-Playwright
```

#### 2. Install Dependencies
```bash
npm install
```

#### 3. Install Playwright Browsers
```bash
npx playwright install chromium
```

---

### Authentication Setup

The framework uses persistent authentication to avoid repeated MFA prompts.

#### Method 1: Automated Setup (Recommended)

**Step 1:** Create `.env` file in project root:
```env
EMAIL=your-admin-email@example.com
PASSWORD=your-secure-password
BASE_URL=https://new-test-admin.malefromhome.com
```

> ⚠️ **Security Note**: Never commit `.env` file to Git. It's already in `.gitignore`.

**Step 2:** Run authentication script:
```bash
node save-auth.js
```

This will:
1. Open a browser window
2. Allow you to log in manually (including MFA)
3. Prompt you to set LOT EXP date if not set
4. Save authentication state to `auth.json`

**Step 3:** Verify `auth.json` was created:
```bash
ls auth.json  # Should show the file exists
```

#### Method 2: Manual Setup

If automated setup fails, manually create `auth.json`:

1. Log in to the application manually
2. Open browser DevTools (F12)
3. Go to Application → Local Storage
4. Copy all authentication tokens
5. Create `auth.json` with the structure from `auth.json` template

---

## 🧪 Running Tests

### Basic Commands
```bash
# Run all tests (headless mode)
npx playwright test

# Run tests with visible browser (headed mode)
npx playwright test --headed

# Run specific test file
npx playwright test tests/Pomtest.spec.js

# Run tests with specific tag
npx playwright test --grep @smoke
```

### Advanced Options
```bash
# Debug mode (step through tests)
npx playwright test --debug

# UI mode (interactive test runner)
npx playwright test --ui

# Run specific browser
npx playwright test --project=chromium
npx playwright test --project=firefox

# Run with specific workers (parallel execution)
npx playwright test --workers=2

# Update snapshots
npx playwright test --update-snapshots
```

### Filtering Tests
```bash
# Run only tests with "Orders" in the name
npx playwright test -g "Orders"

# Run only smoke tests
npx playwright test --grep @smoke

# Skip specific tests
npx playwright test --grep-invert @slow
```

---

## 📁 Project Structure
```
MFH-Automation-Using-Playwright/
│
├── .github/
│   └── workflows/
│       └── playwright.yml          # CI/CD pipeline configuration
│
├── Kits/
│   └── outToPatient.js             # Kit workflows: test recording, status updates
│
├── Orders/
│   ├── AllOrdersTab.js             # All orders page operations
│   ├── newOrders.js                # New order processing & kit assignment
│   ├── readyToShipOrders.js        # Shipping preparation workflows
│   └── shippingLabelPurchased.js   # Label purchase & tracking
│
├── Pages/
│   ├── LoginPage.js                # Login page object
│   └── ShowOrdersTab.js            # Orders tab & column toggles
│
├── Utils/
│   ├── Credentials.js              # Secure credential management
│   └── ordersUtils.js              # Reusable order utilities
│
├── tests/
│   ├── auth.setup.js               # Authentication setup script
│   ├── Pomtest.spec.js             # Main test suite
│   └── SmokeTest.spec.js           # Critical path smoke tests
│
├── downloads/                       # Downloaded files (gitignored)
├── test-results/                    # Test execution artifacts
├── playwright-report/               # HTML reports
├── allure-results/                  # Allure test results
├── allure-report/                   # Generated Allure reports
│
├── .env                             # Environment variables (gitignored)
├── .gitignore                       # Git ignore rules
├── .gitattributes                   # Git LFS configuration
├── auth.json                        # Auth state (gitignored)
├── playwright.config.js             # Playwright configuration
├── save-auth.js                     # Authentication setup script
├── package.json                     # Project dependencies
├── package-lock.json                # Dependency lock file
└── README.md                        # Project documentation
```

---

## 🧩 Test Coverage

### 📦 Orders Module

| Feature | Test Cases | Status |
|---------|-----------|--------|
| **Order Search** | Search by order number, filtering | ✅ Automated |
| **Shopify Sync** | Refresh orders from Shopify | ✅ Automated |
| **Column Management** | Show/hide columns, toggle visibility | ✅ Automated |

### 🧬 Kits Module


### 🎨 UI/UX Tests

| Feature | Test Cases | Status |
|---------|-----------|--------|
| **Tab Navigation** | Verify all order tabs visible and clickable | ✅ Automated |
| **Search Functionality** | Order search with validation | ✅ Automated |
| **Column Toggles** | Show/hide table columns | ✅ Automated |


---

## 🔄 CI/CD Pipeline

### GitHub Actions Workflow

The project uses GitHub Actions for continuous integration. Tests run automatically on:

- ✅ Push to `main` or `master` branch
- ✅ Pull requests to `main` or `master`

### Workflow Steps
```yaml
1. Checkout code
2. Setup Node.js (LTS version)
3. Install dependencies (npm ci)
4. Install Playwright browsers
5. Create test fixtures (fake video for camera tests)
6. Run all tests
7. Upload test reports as artifacts (30-day retention)
```

### Viewing CI Results

1. Navigate to **Actions** tab in GitHub repository
2. Click on the latest workflow run
3. View test execution logs
4. Download artifacts (HTML reports, screenshots, videos)

### Setting Up GitHub Secrets

For CI/CD to work properly, add these secrets to your repository:

**Settings → Secrets and variables → Actions → New repository secret**

| Secret Name | Value | Purpose |
|-------------|-------|---------|
| `PLAYWRIGHT_AUTH_FILE` | Contents of `auth.json` | Persistent authentication for CI |

**To create the secret:**
```bash
# Copy contents of auth.json
cat auth.json

# Paste entire JSON content into GitHub secret value
```

---

## 📊 Reporting

### HTML Reports

**Generate and view:**
```bash
# Run tests
npx playwright test

# Open HTML report (auto-opens after test run)
npx playwright show-report
```

**Manual report opening:**
```bash
# Open existing report
open playwright-report/index.html  # macOS
start playwright-report/index.html  # Windows
xdg-open playwright-report/index.html  # Linux
```

**Report includes:**
- ✅ Test execution summary
- ✅ Pass/fail statistics
- ✅ Screenshots on failures
- ✅ Videos of failed tests
- ✅ Trace viewer for debugging

---

### Allure Reports

Allure provides advanced, interactive reporting with trends and analytics.

#### Setup Allure

**Install Allure CLI globally:**
```bash
npm install -g allure-commandline
```

**Verify installation:**
```bash
allure --version
```

#### Generate and View Allure Reports

**Step 1: Run tests to generate results**
```bash
npx playwright test
```

This creates files in `allure-results/` directory.

**Step 2: Generate HTML report**
```bash
allure generate allure-results --clean -o allure-report
```

**Step 3: Open report in browser**
```bash
allure open allure-report
```

The report opens at `http://localhost:45963` (port may vary).

#### Allure Features

- 📊 **Overview Dashboard** - Test execution summary with pie charts
- 📈 **Trends** - Historical pass/fail trends over time
- 🗂️ **Suites** - Organized test results by suite
- 📸 **Attachments** - Screenshots, videos, logs
- 🕒 **Timeline** - Test execution timeline
- 📋 **Categories** - Custom failure categorization

#### Deploy Allure Report to GitHub Pages

**Add to `.github/workflows/playwright.yml`:**
```yaml
- name: Generate Allure Report
  if: always()
  run: |
    npm install -g allure-commandline
    allure generate allure-results --clean -o allure-report

- name: Deploy to GitHub Pages
  if: always()
  uses: peaceiris/actions-gh-pages@v3
  with:
    github_token: ${{ secrets.GITHUB_TOKEN }}
    publish_dir: ./allure-report
```

Access report at: `https://SajidManzoor.github.io/MFH-Automation-Using-Playwright/`

---

## ⚙️ Environment Configuration

### Environment Variables

The `.env` file stores sensitive configuration:
```env
# Admin Credentials
EMAIL=admin@example.com
PASSWORD=SecurePassword123!

# Application URL
BASE_URL=https://new-test-admin.malefromhome.com

# Optional: Test Data
LOT_EXPIRATION=09/07/2028
```

### Playwright Configuration

**Key settings in `playwright.config.js`:**
```javascript
{
  testDir: './tests',              // Test directory
  timeout: 180000,                 // 3 minutes per test
  retries: process.env.CI ? 2 : 0, // Retry failed tests in CI
  workers: process.env.CI ? 1 : undefined, // Parallel execution
  
  use: {
    baseURL: 'https://new-test-admin.malefromhome.com',
    storageState: 'auth.json',     // Persistent auth
    screenshot: 'only-on-failure', // Capture on failure
    video: 'retain-on-failure',    // Record on failure
    trace: 'on-first-retry',       // Debug traces
  }
}
```

### Modifying Configuration

**Change test timeout:**
```javascript
// playwright.config.js
timeout: 300000  // 5 minutes
```

**Enable parallel execution:**
```javascript
workers: 4  // Run 4 tests in parallel
```

**Change screenshot behavior:**
```javascript
screenshot: 'on'  // Always capture screenshots
```

---

## 🐛 Troubleshooting

### Common Issues & Solutions

#### ❌ Issue: Tests fail with "Target page closed"

**Solution:**

Increase test timeout in `playwright.config.js`:
```javascript
timeout: 300000  // Increase to 5 minutes
```

---

#### ❌ Issue: Authentication fails / MFA required repeatedly

**Solution:**

Regenerate `auth.json`:
```bash
rm auth.json
node save-auth.js
```

Make sure to set LOT EXP date during setup.

---

#### ❌ Issue: Camera tests fail in CI

**Solution:**

CI automatically uses fake video streams. If failing, check that `playwright.config.js` includes:
```javascript
launchOptions: {
  args: [
    '--use-fake-ui-for-media-stream',
    '--use-fake-device-for-media-stream',
  ]
}
```

---

#### ❌ Issue: "Cannot find module" errors

**Solution:**

Reinstall dependencies:
```bash
rm -rf node_modules package-lock.json
npm install
npx playwright install chromium
```

---

#### ❌ Issue: Allure report not generating

**Solution:**

Install Allure CLI:
```bash
npm install -g allure-commandline
allure --version  # Verify installation
```

---

#### ❌ Issue: GitHub Actions failing with auth errors

**Solution:**

Add `PLAYWRIGHT_AUTH_FILE` secret to GitHub:

1. Copy contents of `auth.json`
2. Go to Settings → Secrets and variables → Actions
3. Create new secret: `PLAYWRIGHT_AUTH_FILE`
4. Paste entire JSON content

---

### Debug Mode

For detailed debugging:
```bash
# Run with debug mode
DEBUG=pw:api npx playwright test

# Open Playwright Inspector
npx playwright test --debug

# Generate trace for failed tests
npx playwright test --trace on
```

---

## 💡 Best Practices

### Writing Tests

1. **Follow POM Pattern**: All page interactions go in Page Object classes
2. **Use Descriptive Names**: Test names should clearly describe what's being tested
3. **Avoid Hard Waits**: Use Playwright's auto-waiting instead of `waitForTimeout()`
4. **Add Assertions**: Every test should have explicit assertions
5. **Keep Tests Independent**: Tests should not depend on each other

### Code Quality
```javascript
// ✅ Good - uses auto-waiting
await expect(element).toBeVisible();

// ❌ Bad - hard-coded wait
await page.waitForTimeout(5000);

// ✅ Good - descriptive test name
test('should successfully assign kit to order without PrePaid KitID', async () => {});

// ❌ Bad - vague test name
test('test1', async () => {});
```

### Git Workflow

1. **Create feature branch**: `git checkout -b feature/add-new-test`
2. **Commit frequently**: Small, atomic commits
3. **Write clear commit messages**: `fix: resolve authentication timeout issue`
4. **Run tests locally**: Before pushing
5. **Create pull request**: For code review

---

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

### Contribution Process

1. **Fork the repository**
2. **Create a feature branch**
```bash
   git checkout -b feature/amazing-feature
```
3. **Make your changes**
   - Follow existing code style
   - Add tests for new features
   - Update documentation if needed
4. **Run tests locally**
```bash
   npx playwright test
```
5. **Commit your changes**
```bash
   git commit -m "feat: add amazing feature"
```
6. **Push to your branch**
```bash
   git push origin feature/amazing-feature
```
7. **Open a Pull Request**

### Commit Message Convention

Follow [Conventional Commits](https://www.conventionalcommits.org/):
```
feat: add new test for order cancellation
fix: resolve timeout issue in kit assignment
docs: update README with new examples
test: add test for edge case in manual review
refactor: improve order search utility function
```

### Code Review Checklist

- [ ] All tests pass locally
- [ ] New tests added for new features
- [ ] Code follows POM pattern
- [ ] No hard-coded credentials or sensitive data
- [ ] Documentation updated (if applicable)
- [ ] No console.log statements (use proper logging)

---

## 👥 Team

### Automation Engineering Team

**Sajid Manzoor** - *Lead QA Automation Engineer*  
- GitHub: [@SajidManzoor](https://github.com/SajidManzoor)  
- Email: sajidmanzoor50@gmail.com  
- Role: Framework architecture, test development, CI/CD setup

---

## 📄 License

**Proprietary Software - Internal Use Only**

This project is proprietary and confidential. Unauthorized copying, distribution, or use is strictly prohibited.

© 2026 MaleFromHome. All Rights Reserved.

---

## 📞 Support & Resources

### Internal Support

For questions or issues:
1. Check [Troubleshooting](#troubleshooting) section
2. Review [Playwright Documentation](https://playwright.dev/docs/intro)
3. Contact automation team via Slack/Email
4. Open issue in GitHub repository (for bugs)

### Useful Links

- [Playwright Documentation](https://playwright.dev)
- [Playwright API Reference](https://playwright.dev/docs/api/class-playwright)
- [Allure Documentation](https://docs.qameta.io/allure/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

---

## 📅 Changelog

### Version 1.0.0 (February 2026)

#### ✨ Features
- Complete Orders module automation
- Kit management and test recording workflows
- Column toggle functionality
- File download validation
- Camera/media testing with fake streams

#### 🔧 Infrastructure
- GitHub Actions CI/CD pipeline
- Allure reporting integration
- Persistent authentication system
- Environment variable management

#### 📚 Documentation
- Comprehensive README
- Code examples and best practices
- Troubleshooting guide
- Contributing guidelines

---

## 🎯 Roadmap

### Planned Features

- [ ] **API Testing Integration** - Validate backend endpoints
- [ ] **Performance Testing** - Load and stress testing
- [ ] **Visual Regression Testing** - Screenshot comparison
- [ ] **Mobile Responsiveness Tests** - Mobile viewport testing
- [ ] **Database Validation** - Direct DB queries for verification
- [ ] **Email Notification Testing** - Validate email deliveries
- [ ] **Accessibility Testing** - WCAG compliance checks

### Future Improvements

- [ ] Parallel test execution optimization
- [ ] Custom reporting dashboard
- [ ] Test data management system
- [ ] Automated test data generation
- [ ] Integration with Jira/TestRail

---

**Happy Testing! 🚀**

---

*Last Updated: February 12, 2026*  
*Framework Version: 1.0.0*  
*Playwright Version: 1.58.2*