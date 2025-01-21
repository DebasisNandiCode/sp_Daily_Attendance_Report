# Daily Attendance Report Stored Procedure

This repository contains a SQL Server Stored Procedure designed to generate and email a daily attendance report in HTML format. The report includes attendance data for different locations, providing a consolidated view of the attendance records from the previous day.

---

## Features

- Fetches attendance data for multiple locations.
- Generates a structured HTML table for each location's attendance.
- Sends the report via email using the SQL Server Database Mail feature.
- Fully customizable to adapt to different attendance tracking systems.

---

## Stored Procedure Details

### Purpose:
The stored procedure (`sp_Daily_Attendance_Report`) is designed to:
1. Query attendance data from multiple tables.
2. Format the data into separate HTML tables for each location.
3. Compile the tables into a single HTML email body.
4. Send the email to a predefined recipient list.

### Key Functionalities:
- **Dynamic HTML Generation:** Creates HTML tables dynamically for each location's attendance data.
- **Customizable Locations and Recipients:** Easily configure locations or email recipients to suit your organization's needs.
- **Automated Email Delivery:** Uses SQL Server's `sp_send_dbmail` to send the email report automatically.

---

## How It Works

1. **Input Data:**
   - The stored procedure queries attendance data from specific tables for the previous day.
   - It assumes the attendance tables contain fields like `Date`, `Location`, `ID`, `Name`, and `Status`.

2. **HTML Email Body Generation:**
   - HTML tables are dynamically built for each location's data.
   - The email body includes styled tables for better readability.

3. **Email Sending:**
   - The email is sent using SQL Server Database Mail.
   - You can customize the recipient email list, subject line, and email profile.

---

## How to Use

1. **Setup Database Mail:**
   - Ensure SQL Server Database Mail is configured and working correctly.
   - Replace `MSSQLServer Mailing` with your email profile name.

2. **Configure the Stored Procedure:**
   - Replace placeholder table and column names in the query to match your database schema.
   - Customize the recipient email list in the `@recipients` parameter.

3. **Deploy the Stored Procedure:**
   - Execute the `ALTER PROCEDURE` script in your SQL Server instance.

4. **Schedule the Procedure:**
   - Use SQL Server Agent to schedule the stored procedure to run daily.

---

## Code Example

```sql
-- Call the stored procedure
EXEC [dbo].[sp_Daily_Attendance_Report];
