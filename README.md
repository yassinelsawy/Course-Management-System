# Course Management System

A desktop Course Management System backed by SQL Server for managing courses, users, enrollments, exams, and academic reporting.

## Features

- **User onboarding**
  - Register students and instructors
  - Store instructor expertise areas
- **Course management (Instructor)**
  - Create, update, view, and delete courses
  - Set course visibility
- **Student workflow**
  - Browse available courses
  - Register in courses for the current semester
  - View registered courses
- **Exam management**
  - Add and delete course exams
- **Profile management**
  - Update instructor profile details
- **Reporting**
  - Top students by grade query/report support
  - Additional analytics and sample operations in SQL query scripts
- **Database design**
  - Normalized schema with keys and foreign-key relationships for:
    - Users, Students, Instructors
    - Courses, Categories, Semesters
    - Registers, Exams, Takes
    - Chat and Message entities

## Repository Contents

- `/Course Management System/DDL.txt` — SQL Server DDL script for schema creation (and cleanup).
- `/Course Management System/QUERIES.sql` — sample operational and reporting SQL queries.
- `/Course Management System/Software Application Code.zip` — Windows Forms application source code.
- `/Course Management System/Database_Phase2_Documentation.pdf` — project documentation.

## Tech Stack

- **Database:** Microsoft SQL Server
- **Application:** C# Windows Forms (.NET Framework 4.7.2)

## Getting Started

1. Create a SQL Server database (for example: `CMS`).
2. Run `/Course Management System/DDL.txt` to create tables, indexes, and constraints.
3. (Optional) run queries from `/Course Management System/QUERIES.sql` for common operations and reports.
4. Extract `/Course Management System/Software Application Code.zip`.
5. Open `CMS_gui/CMS_gui.sln` in Visual Studio.
6. Update SQL connection strings in the app (for example in `App.config`) to match your SQL Server instance.
7. Build and run the Windows Forms app.

## Notes

- The project currently stores application source inside a zip archive; extract it before development.
- Connection strings in source point to a local SQL Server instance and should be adjusted per environment.
