# Citizen Safety Connect

A Java Servlet + JSP web application focused on citizen-facing criminal information and complaint workflows.

This repository follows classic MVC:
- Servlets handle routing and request processing.
- DAO classes handle MySQL operations.
- JSP pages render UI.

## Implemented Modules (User Side)

- Authentication and registration (`/Login`, `/SignUp`)
- Criminal records browser (`/Criminals`)
- Case types browser (`/CaseType`)
- Laws browser (`/Laws`)
- Officers browser (`/Officers`)
- Reports browser (`/Reports`)
- Complaint workflow:
  - User dashboard (`/UserDashboard`)
  - File complaint (`/FileComplaint`)
  - Track complaint (`/TrackComplaint`)
- Logout (`/LogOut`)

## Tech Stack

- Java Servlets (Jakarta Servlet API 6)
- JSP + HTML + CSS
- MySQL
- Apache Ant (`build.xml`)
- Apache Tomcat 10.1.x
- Windows helper scripts (`compile.bat`, `deploy.bat`)

## Repository Layout

```text
Criminal_Management/
|-- compile.bat
|-- deploy.bat
|-- database.sql
|-- schema_additions.sql
|-- README.md
`-- Criminal Mangement/
    |-- build.xml
    |-- src/main/java/com/
    |   |-- login/
    |   |-- SignUp/
    |   |-- LogOut/
    |   |-- Criminals/
    |   |-- CaseType/
    |   |-- Laws/
    |   |-- Officer/
    |   |-- Reports/
    |   `-- Complaint/
    `-- src/main/webapp/
        |-- Login.jsp
        |-- SignUp.jsp
        |-- UserDashboard.jsp
        |-- FileComplaint.jsp
        |-- TrackComplaint.jsp
        |-- Criminals.jsp
        |-- CaseTypes.jsp
        |-- Laws.jsp
        |-- Officers.jsp
        |-- Reports.jsp
        `-- WEB-INF/
            |-- web.xml
            `-- lib/
```

## Runtime URL

- Tomcat deployment port in this repo is configured as `8081`.
- Default app URL:

```text
http://localhost:8081/criminal/Login.jsp
```

## Prerequisites

- JDK 17+
- Apache Tomcat 10.1.x
- MySQL 8.x
- Optional: Apache Ant

## Database Setup

### 1) Create/select database

```sql
CREATE DATABASE IF NOT EXISTS management;
USE management;
```

### 2) Import baseline data

```bash
mysql -u root -p management < database.sql
```

### 3) Align schema with current code expectations

Run this once after importing `database.sql`:

```sql
USE management;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    age INT NULL,
    email VARCHAR(100) NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO users (username, password, age, email, phone)
SELECT u.username, u.password, 18, CONCAT(u.username, '@local.test'), '0000000000'
FROM `user` u
LEFT JOIN users us ON us.username = u.username
WHERE us.username IS NULL;

CREATE TABLE IF NOT EXISTS complaints (
    complaint_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    crime_type VARCHAR(45) NOT NULL,
    description TEXT,
    incident_date DATE,
    incident_location VARCHAR(255),
    status VARCHAR(20) DEFAULT 'Pending',
    filed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_complaint_user
        FOREIGN KEY (username) REFERENCES users(username)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS complaint_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT,
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_complaint_log
        FOREIGN KEY (complaint_id) REFERENCES complaints(complaint_id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS logout_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    logout_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(64) NULL,
    user_agent TEXT NULL
);
```

## Build

```powershell
cd "Criminal Mangement"
ant war
```

## Quick Deploy

```powershell
set CATALINA_HOME=C:\apache-tomcat-10.1.52
cd "Criminal Mangement"
ant quick-deploy
```

## Demo Login (No DB)

- Username: `demo`
- Password: `demo`

These demo credentials are provided by an in-memory fallback so beginners can explore the app without installing MySQL.

## Servlet Route Map

| Route | Main Purpose |
|---|---|
| `/Login` | User login validation and session create |
| `/SignUp` | User registration with validation |
| `/LogOut` | Session invalidation and redirect to login |
| `/Criminals` | Load/filter criminal records for `Criminals.jsp` |
| `/CaseType` | Load/search case types for `CaseTypes.jsp` |
| `/Laws` | Load/search/filter laws for `Laws.jsp` |
| `/Officers` | Load/search/filter officers for `Officers.jsp` |
| `/Reports` | Load/search/filter reports for `Reports.jsp` |
| `/UserDashboard` | User complaint dashboard data |
| `/FileComplaint` | Create complaint (POST), complaint page redirect (GET) |
| `/TrackComplaint` | Fetch complaint by ID for logged user |

## Known Limitations

- Passwords are currently stored as plaintext.
- Environment-specific paths are hardcoded in batch scripts.
- Current setup is development-focused and not production hardened.

## License

Educational/demo usage.
