# Loan Data Validation & Monitoring System

A Linux-based Loan Data Validation and Monitoring System built using Bash, MySQL, Python Flask, SFTP, and Cron.

This project automates loan data validation, identifies data quality issues, generates validation logs and reports, transfers reports through SFTP, and exposes monitoring information through REST APIs.

## Project Overview

The system validates loan records stored in a MySQL database and detects common data quality issues.

### Key Features

- Automated loan data validation using Bash scripting.
- MySQL database integration.
- Duplicate Loan ID detection.
- Missing Customer Name detection.
- Invalid Loan Amount detection.
- Error logging and report generation.
- Automated report transfer using SFTP.
- Scheduled execution using Cron.
- Flask-based monitoring REST API.
- API testing using Postman.
- Bug tracking using Jira.

## Technology Stack

| Technology | Purpose |
|---|---|
| Linux (Ubuntu) | Operating System |
| Bash Shell Scripting | Automation |
| MySQL | Database Management |
| Python | Backend Programming |
| Flask | REST API |
| SFTP | Secure Report Transfer |
| Cron | Job Scheduling |
| Postman | API Testing |
| Jira | Issue Tracking |
| Git & GitHub | Version Control |

## System Architecture

## System Architecture

```mermaid
flowchart TD
    A[Cron Scheduler] --> B[validate.sh]
    B --> C[MySQL Database]
    C --> D[Data Validation]
    D --> E[Validation Report]
    D --> F[Application Logs]
    E --> G[send_report.sh]
    G --> H[SFTP Server]
    F --> I[Flask Monitoring API]
    I --> J[/health Endpoint]
    I --> K[/status Endpoint]
    K --> L[Postman Testing]

## Project Structure

```text
loan-project/
│
├── setup.sql
├── validate.sh
├── send_report.sh
├── app.py
├── .gitignore
└── README.md
```

## Data Validation Rules

The system performs three validation checks:

1. Duplicate Loan ID
   - Identifies duplicate loan records.

2. Missing Customer Name
   - Detects NULL or empty customer names.

3. Invalid Loan Amount
   - Identifies loan amounts less than or equal to zero.

## Installation & Setup

### 1. Clone Repository

```bash
git clone https://github.com/rujyaa2102/loan-data-validation-monitoring.git
cd loan-data-validation-monitoring
```

### 2. Install Dependencies

```bash
sudo apt update
sudo apt install mysql-server python3-flask openssh-server -y
```

### 3. Configure MySQL

Start MySQL:

```bash
sudo service mysql start
```

Import database:

```bash
mysql -u root -p < setup.sql
```

Create a MySQL user locally and configure database credentials securely in `~/.my.cnf`.

Example:

```ini
[client]
user=loanuser
password=YOUR_DATABASE_PASSWORD
```

Secure the credentials file:

```bash
chmod 600 ~/.my.cnf
```

### 4. Prepare Project Files

```bash
touch app.log
chmod +x validate.sh send_report.sh
```

Note: The shell scripts currently use `/home/rujal/loan-project` through the home-directory path. Update the paths if you install the project elsewhere.

### 5. Run Data Validation

```bash
./validate.sh
```

Check generated report:

```bash
cat report_$(date +%F).txt
```

Check logs:

```bash
cat app.log
```

### 6. Configure SFTP

Configure an SSH/SFTP server and authentication before running the report transfer script.

The project uses a local SFTP destination for testing.

Run:

```bash
./send_report.sh
```

### 7. Configure Cron Job

Open crontab:

```bash
crontab -e
```

Example schedule for 9:00 AM IST on a system using UTC:

```bash
30 3 * * * cd /home/rujal/loan-project && ./validate.sh && ./send_report.sh >> cron.out 2>&1
```

Check scheduled jobs:

```bash
crontab -l
```

### 8. Start Flask Monitoring API

```bash
python3 app.py
```

The Flask application runs on port 5000.

## API Endpoints

### Health Check

**GET** `/health`

```text
http://localhost:5000/health
```

Example response:

```json
{
  "status": "UP"
}
```

### Monitoring Status

**GET** `/status`

```text
http://localhost:5000/status
```

Example response:

```json
{
  "error_count": 3,
  "last_log_line": "ERROR Invalid amount"
}
```

Note: The actual error count and last log line depend on the contents of `app.log`.

## API Testing

The REST API was tested using Postman.

Tests performed:

- HTTP status code validation.
- Verification of `error_count`.
- Verification of `last_log_line`.

## Issue Tracking

Jira was used for practical bug tracking.

Example issue:

- Issue Key: KAN-3
- Type: Bug
- Summary: Loan Data Validation Failed - MySQL Connection Error
- Status: To Do

The issue documented the MySQL connection failure, reproduction steps, expected result, actual result, and resolution.

## Learning Outcomes

Through this project, I gained practical experience in:

- Linux commands and shell scripting.
- MySQL database operations.
- Data validation and error handling.
- Log monitoring and report generation.
- SFTP file transfer.
- Cron job scheduling.
- Flask REST API development.
- API testing with Postman.
- Jira issue tracking.
- Git and GitHub version control.

## Author

**Rujal Kamble**

GitHub: https://github.com/rujyaa2102
