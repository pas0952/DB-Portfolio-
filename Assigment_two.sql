CREATE DATABASE GuestHousesIoginName
GO

DROP TABLE IF EXISTS  GuestHousesIoginName;
GO

USE GuestHousesIoginName;

--USE master	
DROP TABLE IF EXISTS  Calendar;
GO

DROP TABLE IF EXISTS  Rate;
GO

DROP TABLE IF EXISTS  RoomType;
GO

DROP TABLE IF EXISTS  Room;
GO

DROP TABLE IF EXISTS  Guest;
GO

DROP TABLE IF EXISTS  Booking;
GO

DROP TABLE IF EXISTS Extra;
GO


CREATE TABLE Calendar(  
ID DATE NOT NULL PRIMARY KEY,
);

CREATE TABLE RoomTypes(
ID NVARCHAR(10) NOT NULL PRIMARY KEY,
Descriptions  NVARCHAR(100)
);

CREATE TABLE Rate(
RoomType NVARCHAR(10) NOT NULL,
OccupancyID INT NOT NULL,   
Amount DECIMAL (7, 2) NOT NULL,
PRIMARY KEY(RoomType, OccupancyID),
FOREIGN KEY (RoomType) REFERENCES RoomTypes (ID)
);

CREATE TABLE Room(
ID INT NOT NULL PRIMARY KEY,
RoomType  NVARCHAR(10) NOT NULL,
MaxOccupancy TINYINT,
FOREIGN KEY (RoomType) REFERENCES RoomTypes (ID)
);

CREATE  TABLE Guest(
ID INT IDENTITY(1001, 1) NOT NULL PRIMARY KEY,
FirstName NVARCHAR(25) NOT NULL,
LastName NVARCHAR(25) NOT NULL,
Address NVARCHAR(50)
);

CREATE TABLE Booking(
BookingID INT IDENTITY(5001, 1) NOT NULL PRIMARY KEY,
BookingDate DATE,
RoomNo INT NOT NULL,
GuestID INT NOT NULL,
Occupants INT NOT NULL,
RoomTypeRequested NVARCHAR(10) NOT NULL,
Nights TINYINT,
ArrivalTime TIME(0),            ---time HH:MM:SS 
FOREIGN KEY (RoomNo) REFERENCES Room (ID),
FOREIGN KEY (GuestID) REFERENCES Guest (ID),
FOREIGN KEY (RoomTypeRequested) REFERENCES RoomTypes (ID),
FOREIGN KEY (RoomTypeRequested, Occupants) REFERENCES Rate (RoomType, OccupancyID)
); 


CREATE TABLE Extra(
ExtraID INT NOT NULL PRIMARY KEY,
BookingID INT NOT NULL,
Description NVARCHAR(100),
Amount DECIMAL (7, 2)
FOREIGN KEY (BookingID) REFERENCES Booking (BookingID),
);



BULK
INSERT Calendar
FROM 'C:\Users\alden\Desktop\Portfolio DB\Calendar.csv'
WITH
(
FORMAT = 'CSV',
CODEPAGE ='65001',
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
--FIRSTROW = 2
--ERRORFILE = 'C:\Users\alden\Desktop\Portfolio DB\myRubbishData.log' 
);
GO


BULK
INSERT RoomTypes
FROM 'C:\Users\alden\Desktop\Portfolio DB\room_type.csv'
WITH
(
FORMAT= 'CSV',
CODEPAGE ='65001',
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
--FIRSTROW = 2
--ERRORFILE = 'C:\Users\alden\Desktop\Portfolio DB\myRubbishData.log' 
);
GO


BULK
INSERT Rate
FROM 'C:\Users\alden\Desktop\Portfolio DB\rate.csv'
WITH
(
FORMAT= 'CSV',
CODEPAGE ='65001',
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
--FIRSTROW = 2
--ERRORFILE = 'C:\Users\alden\Desktop\Portfolio DB\myRubbishData.log' 
);
GO


BULK
INSERT Room
FROM 'C:\Users\alden\Desktop\Portfolio DB\room.csv'
WITH
(
FORMAT= 'CSV',
CODEPAGE ='65001',
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
--FIRSTROW = 2
--ERRORFILE = 'C:\Users\alden\Desktop\Portfolio DB\myRubbishData.log' 
);
GO


BULK
INSERT Guest
FROM 'C:\Users\alden\Desktop\Portfolio DB\guest.csv'
WITH
(
FORMAT= 'CSV',
CODEPAGE ='65001',
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
--FIRSTROW = 2
--ERRORFILE = 'C:\Users\alden\Desktop\Portfolio DB\myRubbishData.log' 
);
GO


BULK
INSERT booking
FROM 'C:\Users\alden\Desktop\Portfolio DB\booking.csv'
WITH
(
FORMAT= 'CSV',
CODEPAGE ='65001',
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
--FIRSTROW = 2
--ERRORFILE = 'C:\Users\alden\Desktop\Portfolio DB\myRubbishData.log' 
);
GO


BULK
INSERT extra
FROM 'C:\Users\alden\Desktop\Portfolio DB\extra.csv'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
CODEPAGE ='65001',
FORMAT= 'CSV'
--DATAFILETYPE = 'widechar' 
--FIRSTROW = 2
--ERRORFILE = 'C:\Users\alden\Desktop\Portfolio DB\myRubbishData.log' 
);
GO


SELECT * FROM Calendar;
SELECT * FROM RoomTypes;
SELECT * FROM rate;
SELECT * FROM room;
SELECT * FROM guest;
SELECT * FROM Booking;
SELECT * FROM Extra;


SELECT COUNT(BookingID) AS 'Total number of bookings' FROM Booking;

SELECT COUNT(ID) AS 'Total number of guest booked' FROM	Guest;

SELECT RoomTypeRequested AS 'Room Type', count(RoomTypeRequested) AS 'Total number of guest booked' FROM Booking
GROUP BY RoomTypeRequested;





