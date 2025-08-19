CREATE DATABASE IF NOT EXISTS 336AirlineProject;

USE 336AirlineProject;

DROP TABLE IF EXISTS Answer;
DROP TABLE IF EXISTS Question;
DROP TABLE IF EXISTS Waitlist;
DROP TABLE IF EXISTS Ticket;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Flight_Avalibility;
DROP TABLE IF EXISTS Flight_Operating_Days;
DROP TABLE IF EXISTS Flight_Schedule;
DROP TABLE IF EXISTS Airline_Company_Aircraft;
DROP TABLE IF EXISTS Airline_Company_Airport;
DROP TABLE IF EXISTS Bookings;
DROP TABLE IF EXISTS Aircraft;
DROP TABLE IF EXISTS Airport;
DROP TABLE IF EXISTS Airline_Company;
DROP TABLE IF EXISTS Account;

CREATE TABLE Account (
   Account_Number INT PRIMARY KEY AUTO_INCREMENT,
   First_Name VARCHAR(50) NOT NULL,
   Last_Name VARCHAR(50) NOT NULL,
   Username VARCHAR(50) NOT NULL,
   Password VARCHAR(50) NOT NULL,
   SSN VARCHAR(11) NOT NULL,
   Role ENUM('Customer', 'Representative', 'Administrator') NOT NULL
);

INSERT INTO Account (First_Name, Last_Name, Username, Password, SSN, Role) VALUES 
('c', 'c', 'c', 'c', 'c', 'Customer'),
('r', 'r', 'r', 'r', 'r', 'Representative'),
('a', 'a', 'a', 'a', 'a', 'Administrator');



CREATE TABLE Airline_Company (
Airline_ID VARCHAR(2) PRIMARY KEY,
Airline_Name VARCHAR (20)
);

INSERT INTO Airline_Company (Airline_ID, Airline_Name) VALUES
('DA', 'Delta Air Lines'),
('AA', 'American Airlines'),
('UA', 'United Airlines'),
('SW', 'Southwest Airline');


CREATE TABLE Airport (
   Airport_ID VARCHAR(3) PRIMARY KEY,
   City VARCHAR (30),
   State VARCHAR (10)
);

INSERT INTO Airport (Airport_ID, City, State) VALUES
('ATL', 'Atlanta', 'GA'),
('LAX', 'Los Angeles', 'CA'),
('DFW', 'Dallas', 'TX'),
('DEN', 'Denver', 'CO'),
('ORD', 'Chicago', 'IL'),
('JFK', 'New York City', 'NY'),
('MCO', 'Orlando', 'FL'),
('LAS', 'Las Vegas', 'NV'),
('CLT', 'Charlotte', 'NC'),
('MIA', 'Miami', 'FL'),
('SEA', 'Seattle and Tacoma', 'WA'),
('EWR', 'Newark', 'NJ'),
('SFO', 'San Francisco', 'CA'),
('PHX', 'Phoenix', 'AZ'),
('IAH', 'Houston', 'TX'),
('BOS', 'Boston', 'MA'),
('FLL', 'Fort Lauderdale', 'FL'),
('MSP', 'Minneapolis', 'MN'),
('LGA', 'New York City', 'NY'),
('DTW', 'Detroit', 'MI'),
('PHL', 'Philadelphia', 'PA'),
('SLC', 'Salt Lake City', 'UT'),
('BWI', 'Baltimore/Washington, D.C.', 'MD'),
('DCA', 'Washington, D.C.', 'VA'),
('SAN', 'San Diego', 'CA'),
('IAD', 'Washington, D.C.', 'VA'),
('TPA', 'Tampa', 'FL'),
('BNA', 'Nashville', 'TN'),
('AUS', 'Austin', 'TX'),
('MDW', 'Chicago', 'IL');


CREATE TABLE Aircraft(
   Aircraft_ID VARCHAR(10) PRIMARY KEY,
   Seats INT
);

INSERT INTO Aircraft (Aircraft_ID, Seats) VALUES
('0000', 50),
('0001', 45),
('0002', 40),
('0003', 35),
('0004', 30),
('0005', 25),
('0006', 20);


CREATE TABLE Flight_Schedule(
Flight_Number VARCHAR(20) PRIMARY KEY,
Airline_ID VARCHAR(2),
Departure_Airport_ID VARCHAR(3),
Departure_Time TIME,
Arrival_Airport_ID VARCHAR(3),
Arrival_Time TIME,
FOREIGN KEY (Airline_ID) REFERENCES Airline_Company(Airline_ID),
FOREIGN KEY (Departure_Airport_ID) REFERENCES Airport(Airport_ID) ON DELETE CASCADE,
FOREIGN KEY (Arrival_Airport_ID) REFERENCES Airport(Airport_ID) ON DELETE CASCADE
);

INSERT INTO Flight_Schedule (Flight_Number, Airline_ID, Departure_Airport_ID, Departure_Time, Arrival_Airport_ID, Arrival_Time) VALUES
('SW101', 'SW', 'LAX', '07:30:00', 'LAS', '08:45:00'),
('SW102', 'SW', 'LAS', '10:00:00', 'LAX', '11:15:00'),
('SW103', 'SW', 'DEN', '09:00:00', 'PHX', '10:20:00');

INSERT INTO Flight_Schedule (Flight_Number, Airline_ID, Departure_Airport_ID, Departure_Time, Arrival_Airport_ID, Arrival_Time) VALUES
('DA100', 'DA', 'JFK', '08:00:00', 'SFO', '11:15:00'),
('DA200', 'DA', 'JFK', '12:00:00', 'SFO', '15:15:00'),
('DA300', 'DA', 'ATL', '06:45:00', 'MIA', '08:45:00'),
('DA400', 'DA', 'MIA', '14:30:00', 'ATL', '16:30:00');

INSERT INTO Flight_Schedule (Flight_Number, Airline_ID, Departure_Airport_ID, Departure_Time, Arrival_Airport_ID, Arrival_Time) VALUES
('AA200', 'AA', 'EWR', '09:45:00', 'MIA', '12:30:00'),
('AA300', 'AA', 'DFW', '10:15:00', 'LAX', '12:45:00'),
('AA301', 'AA', 'LAX', '13:45:00', 'DFW', '18:10:00');

INSERT INTO Flight_Schedule (Flight_Number, Airline_ID, Departure_Airport_ID, Departure_Time, Arrival_Airport_ID, Arrival_Time) VALUES
('UA300', 'UA', 'SFO', '13:15:00', 'JFK', '16:45:00'),
('UA400', 'UA', 'SEA', '09:10:00', 'ORD', '13:45:00'),
('UA401', 'UA', 'ORD', '15:00:00', 'SEA', '17:40:00'),
('UA402', 'UA', 'IAH', '08:25:00', 'DEN', '10:00:00');

CREATE TABLE Flight_Operating_Days (
Flight_Number VARCHAR(20),
Day_Of_Week VARCHAR (50),
FOREIGN KEY (Flight_Number) REFERENCES Flight_Schedule(Flight_Number) ON DELETE CASCADE,
CHECK (Day_Of_Week IN ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'))
);

INSERT INTO Flight_Operating_Days (Flight_Number, Day_Of_Week) VALUES
('DA100', 'Monday'),
('DA100', 'Wednesday'),
('AA200', 'Tuesday'),
('AA200', 'Friday'),
('UA300', 'Thursday'),
('UA300', 'Saturday'),
('SW101', 'Tuesday'),
('SW101', 'Saturday'),
('SW101', 'Wednesday'),
('SW102', 'Tuesday'),
('SW102', 'Sunday'),
('SW102', 'Friday'),
('SW103', 'Tuesday'),
('SW103', 'Friday'),
('DA300', 'Saturday'),
('DA300', 'Tuesday'),
('DA300', 'Wednesday'),
('DA400', 'Saturday'),
('DA400', 'Thursday'),
('DA400', 'Tuesday'),
('DA400', 'Wednesday'),
('AA300', 'Saturday'),
('AA300', 'Thursday'),
('AA301', 'Saturday'),
('AA301', 'Sunday'),
('UA400', 'Friday'),
('UA400', 'Sunday'),
('UA400', 'Saturday'),
('UA401', 'Tuesday'),
('UA401', 'Wednesday'),
('UA401', 'Sunday'),
('UA402', 'Tuesday'),
('UA402', 'Friday');


CREATE TABLE Flight_Avalibility (
Instance_ID INT PRIMARY KEY AUTO_INCREMENT,
Flight_Number VARCHAR(20),
Flight_Date DATE,
Aircraft_ID VARCHAR(20), 
Base_Price DECIMAL (10,2),
Seats_Available INT,
FOREIGN KEY (Flight_Number) REFERENCES Flight_Schedule(Flight_Number) ON DELETE CASCADE,
FOREIGN KEY (Aircraft_ID) REFERENCES Aircraft(Aircraft_ID) ON DELETE CASCADE
);


INSERT INTO Flight_Avalibility (Flight_Number, Flight_Date, Aircraft_ID, Base_Price, Seats_Available) VALUES
('DA100', '2025-06-02', '0001', 100.00, 2),
('DA100', '2025-06-04', '0003', 100.00, 1),
('DA200', '2025-06-02', '0003', 100.00, 35),
('AA200', '2025-06-03', '0000', 100.00, 50),
('AA200', '2025-06-06', '0002', 100.00, 40),
('UA300', '2025-06-05', '0004', 100.00, 30),
('UA300', '2025-04-07', '0005', 100.00, 25);

INSERT INTO Flight_Avalibility (Flight_Number, Flight_Date, Aircraft_ID, Base_Price, Seats_Available) VALUES
('DA100', '2025-06-01', '0002', 105.69, 41),
('DA100', '2025-06-02', '0004', 173.41, 45),
('DA100', '2025-06-03', '0006', 178.65, 27),
('DA200', '2025-06-01', '0000', 159.68, 18),
('DA200', '2025-06-02', '0000', 99.76, 44),
('DA200', '2025-06-03', '0006', 106.27, 39),
('AA200', '2025-06-01', '0005', 155.26, 33),
('AA200', '2025-06-02', '0000', 160.38, 17),
('AA200', '2025-06-03', '0002', 165.59, 47),
('UA300', '2025-06-01', '0003', 123.13, 50),
('UA300', '2025-06-02', '0004', 165.83, 48),
('UA300', '2025-06-03', '0002', 124.23, 38),
('SW101', '2025-06-01', '0006', 108.91, 19),
('SW101', '2025-06-02', '0004', 177.34, 22),
('SW101', '2025-06-03', '0003', 173.45, 20),
('SW102', '2025-06-01', '0002', 163.38, 45),
('SW102', '2025-06-02', '0005', 91.37, 43),
('SW102', '2025-06-03', '0002', 110.93, 34),
('SW103', '2025-06-01', '0006', 178.11, 36),
('SW103', '2025-06-02', '0001', 122.65, 46),
('SW103', '2025-06-03', '0003', 136.54, 35),
('DA300', '2025-06-01', '0004', 178.28, 23),
('DA300', '2025-06-02', '0001', 136.96, 34),
('DA300', '2025-06-03', '0001', 133.41, 39),
('DA400', '2025-06-01', '0004', 135.89, 27),
('DA400', '2025-06-02', '0000', 145.97, 25),
('DA400', '2025-06-03', '0004', 100.70, 46),
('AA300', '2025-06-01', '0004', 103.41, 37),
('AA300', '2025-06-02', '0003', 172.53, 21),
('AA300', '2025-06-03', '0006', 155.04, 26),
('AA301', '2025-06-01', '0005', 145.61, 42),
('AA301', '2025-06-02', '0004', 90.41, 29),
('AA301', '2025-06-03', '0003', 120.32, 15),
('UA400', '2025-06-01', '0003', 169.66, 36),
('UA400', '2025-06-02', '0005', 167.74, 21),
('UA400', '2025-06-03', '0000', 104.20, 12),
('UA401', '2025-06-01', '0005', 154.33, 20),
('UA401', '2025-06-02', '0003', 169.42, 39),
('UA401', '2025-06-03', '0002', 163.84, 25),
('UA402', '2025-06-01', '0006', 104.76, 35),
('UA402', '2025-06-02', '0006', 128.93, 26),
('UA402', '2025-06-03', '0004', 123.67, 31);


CREATE TABLE Bookings(
Booking_ID INT AUTO_INCREMENT PRIMARY KEY,
Account_Number INT,
Class ENUM('Economy', 'Business', 'First') NOT NULL,
Price DECIMAL(10,2),
Booking_Fee DECIMAL(10,2),
Purchase_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
Change_Fee DECIMAL (10,2),
Total_Charge DECIMAL (10.2),
Flight_Type ENUM('One Way','Round Trip'),
Booking_Status ENUM('Active', 'Canceled') DEFAULT 'Active',
FOREIGN KEY (Account_Number) REFERENCES Account(Account_Number) ON DELETE CASCADE
);

Create Table Ticket(
Ticket_ID INT,
Instance_ID INT,
Seat_Number VARCHAR(5),
Ticket_Status ENUM ('Active', 'Canceled') DEFAULT 'Active',
PRIMARY KEY (Ticket_ID, Instance_ID),
FOREIGN KEY (Ticket_ID) REFERENCES Bookings(Booking_ID) ON DELETE CASCADE,
FOREIGN KEY (Instance_ID) REFERENCES Flight_Avalibility(Instance_ID) ON DELETE CASCADE
);

CREATE TABLE Waitlist(
Waitlist_ID INT AUTO_INCREMENT PRIMARY KEY,
Instance_ID INT,
Account_Number INT,
Request_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (Instance_ID) REFERENCES Flight_Avalibility(Instance_ID) ON DELETE CASCADE,
FOREIGN KEY (Account_Number) REFERENCES Account(Account_Number) ON DELETE CASCADE
);

CREATE TABLE Question (
Question_ID INT AUTO_INCREMENT PRIMARY KEY,
Account_Number INT,
Subject_Text TEXT NOT NULL,
Question_Text TEXT NOT NULL,
Post_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (Account_Number) REFERENCES Account(Account_Number) ON DELETE SET NULL
);

CREATE TABLE Answer (
    Answer_ID INT AUTO_INCREMENT PRIMARY KEY,
    Question_ID INT,
    Rep_Account INT,
    Answer_Text TEXT NOT NULL,
    Answer_Date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Question_ID) REFERENCES Question(Question_ID) ON DELETE CASCADE,
    FOREIGN KEY (Rep_Account) REFERENCES Account(Account_Number) ON DELETE SET NULL
);




