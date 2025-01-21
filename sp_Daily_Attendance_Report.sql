USE [Database_name] -- Put actual database name here
GO

--CREATE PROCEDURE [dbo].[sp_Daily_Attendance_Report]
ALTER PROCEDURE [dbo].[sp_Daily_Attendance_Report]
AS
BEGIN
    -- Declare variables
    DECLARE @EmailBody NVARCHAR(MAX);
    DECLARE @TableA NVARCHAR(MAX);
    DECLARE @TableB NVARCHAR(MAX);
    DECLARE @TableC NVARCHAR(MAX);
    DECLARE @TableD NVARCHAR(MAX);

    -- Initialize the email body
    SET @EmailBody = '<html><body><h2>Daily Attendance Report</h2>';

    -- Query 1: A Attendance
    SET @TableA = 
        (SELECT 
            '<tr><th>Date</th><th>Location</th><th>ID</th><th>Name</th><th>Status</th></tr>' +
            (
                SELECT 
                    CONCAT('<tr><td>', CAST([DateColumn] AS NVARCHAR), '</td><td>',
                           [ActualLocationColumn], '</td><td>',
                           [ActualIDColumn], '</td><td>',
                           [ActualNameColumn], '</td><td>',
                           [ActualStatusColumn], '</td></tr>')
                FROM raw_attendance_gs_a		-- Put table name here
                WHERE [DateColumn] = CONVERT(DATE, GETDATE() - 1)
                FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)')
        );
    SET @EmailBody = @EmailBody + '<h3>A Attendance</h3><table border="1" style="border-collapse: collapse;">' + @TableA + '</table>';

    -- Query 2: B Attendance
    SET @TableB = 
        (SELECT 
            '<tr><th>Date</th><th>Location</th><th>ID</th><th>Name</th><th>Status</th></tr>' +
            (
                SELECT 
                    CONCAT('<tr><td>', CAST([DateColumn] AS NVARCHAR), '</td><td>',
                           [ActualLocationColumn], '</td><td>',
                           [ActualIDColumn], '</td><td>',
                           [ActualNameColumn], '</td><td>',
                           [ActualStatusColumn], '</td></tr>')
                FROM raw_attendance_gs_b		-- Put table name here
                WHERE [DateColumn] = CONVERT(DATE, GETDATE() - 1)
                FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)')
        );
    SET @EmailBody = @EmailBody + '<h3>B Attendance</h3><table border="1" style="border-collapse: collapse;">' + @TableB + '</table>';

    -- Query 3: C Attendance
    SET @TableC = 
        (SELECT 
            '<tr><th>Date</th><th>Location</th><th>ID</th><th>Name</th><th>Status</th></tr>' +
            (
                SELECT 
                    CONCAT('<tr><td>', CAST([DateColumn] AS NVARCHAR), '</td><td>',
                           [ActualLocationColumn], '</td><td>',
                           [ActualIDColumn], '</td><td>',
                           [ActualNameColumn], '</td><td>',
                           [ActualStatusColumn], '</td></tr>')
                FROM raw_attendance_gs_c		-- Put table name here
                WHERE [DateColumn] = CONVERT(DATE, GETDATE() - 1)
                FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)')
        );
    SET @EmailBody = @EmailBody + '<h3>C Attendance</h3><table border="1" style="border-collapse: collapse;">' + @TableC + '</table>';

    -- Query 4: D Attendance
    SET @TableD = 
        (SELECT 
            '<tr><th>Date</th><th>Location</th><th>ID</th><th>Name</th><th>Status</th></tr>' +
            (
                SELECT 
                    CONCAT('<tr><td>', CAST([DateColumn] AS NVARCHAR), '</td><td>',
                           [ActualLocationColumn], '</td><td>',
                           [ActualIDColumn], '</td><td>',
                           [ActualNameColumn], '</td><td>',
                           [ActualStatusColumn], '</td></tr>')
                FROM raw_attendance_gs_d		-- Put your table name here
                WHERE [DateColumn] = CONVERT(DATE, GETDATE() - 1)
                FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)')
        );
    SET @EmailBody = @EmailBody + '<h3>D Attendance</h3><table border="1" style="border-collapse: collapse;">' + @TableD + '</table>';

    -- Close the email body
    SET @EmailBody = @EmailBody + '</body></html>';

    -- Send the email
    EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'MSSQLServer Mailing',
        @recipients = 'xxxxxxxxxx.xxxxxxxxxx@xxxxxxxxx.com', -- Put receiver email ID here
        @subject = 'Daily Attendance Report',
        @body = @EmailBody,
        @body_format = 'HTML';
END;
