USE AdventureSportsDB

GO
--SUPERTYPE--

CREATE TABLE Adventure.[USER] (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Fname NVARCHAR(50) NOT NULL,
    Lname NVARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Phone NVARCHAR(20)
);

-------------------

--USER SUBTYPES--

CREATE TABLE Adventure.CUSTOMER (
    UserID INT PRIMARY KEY,
    CONSTRAINT FK_Customer_User
        FOREIGN KEY (UserID)
        REFERENCES Adventure.[USER](UserID)
);

---------------------

CREATE TABLE Adventure.INSTRUCTOR (
    UserID INT PRIMARY KEY,
    Specialty NVARCHAR(100),

    CONSTRAINT FK_Instructor_User
        FOREIGN KEY (UserID)
        REFERENCES Adventure.[USER](UserID)
);


------------------------
--SUPERTYPE--

CREATE TABLE Adventure.ACTIVITY (
    ActivityID INT IDENTITY(1,1) PRIMARY KEY,
    ActivityName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    MinAge INT NOT NULL,
    Experience NVARCHAR(100),
    DifficultyLevel NVARCHAR(50)
);

----------------------------

--ACTIVITY SUBTYPES--

CREATE TABLE Adventure.WATER_SPORT (
    ActivityID INT PRIMARY KEY,
    WaterType NVARCHAR(50),
    DepthRequirement NVARCHAR(50),

    CONSTRAINT FK_WaterSport_Activity
        FOREIGN KEY (ActivityID)
        REFERENCES Adventure.ACTIVITY(ActivityID)
);

------------------------

CREATE TABLE Adventure.LAND_SPORT (
    ActivityID INT PRIMARY KEY,
    TerrainType NVARCHAR(50),

    CONSTRAINT FK_LandSport_Activity
        FOREIGN KEY (ActivityID)
        REFERENCES Adventure.ACTIVITY(ActivityID)
);

-----------------------------

CREATE TABLE Adventure.AIR_SPORT (
    ActivityID INT PRIMARY KEY,
    Weather NVARCHAR(50),
    MinAltitude INT,

    CONSTRAINT FK_AirSport_Activity
        FOREIGN KEY (ActivityID)
        REFERENCES Adventure.ACTIVITY(ActivityID)
);
----------------------------

--SUPERTYPE--

CREATE TABLE Adventure.LOCATION (
    LocationID INT IDENTITY(1,1) PRIMARY KEY,
    LocationName NVARCHAR(100),
    Address NVARCHAR(255),
    Country NVARCHAR(50),
    City NVARCHAR(50)
);


--LOCATION SUBTYPES--

CREATE TABLE Adventure.INDOOR (
    LocationID INT PRIMARY KEY,
    FacilityType NVARCHAR(50),

    CONSTRAINT FK_Indoor_Location
        FOREIGN KEY (LocationID)
        REFERENCES Adventure.LOCATION(LocationID)
);
----------------------------------

CREATE TABLE Adventure.OUTDOOR (
    LocationID INT PRIMARY KEY,
    NaturalFacility NVARCHAR(50),
    WeatherCondition NVARCHAR(50),

    CONSTRAINT FK_Outdoor_Location
        FOREIGN KEY (LocationID)
        REFERENCES Adventure.LOCATION(LocationID)
);
---------------------------

CREATE TABLE Adventure.CERTIFICATION (
    CertificationID INT IDENTITY(1,1) PRIMARY KEY,
    CertificationName NVARCHAR(100),
    ValidFrom DATE,
    ValidTo DATE
);
----------------------------

CREATE TABLE Adventure.OFFERING (
    OfferingID INT IDENTITY(1,1) PRIMARY KEY,
    Price DECIMAL(10,2) NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    MaxParticipitate INT NOT NULL,
    OfferingDay DATE NOT NULL,
    LocationID INT NOT NULL,
    ActivityID INT NOT NULL,

    CONSTRAINT FK_Offering_Location
        FOREIGN KEY (LocationID)
        REFERENCES Adventure.LOCATION(LocationID),

    CONSTRAINT FK_Offering_Activity
        FOREIGN KEY (ActivityID)
        REFERENCES Adventure.ACTIVITY(ActivityID)
);

-------------------------

CREATE TABLE Adventure.BOOKING (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    BookingDate DATE NOT NULL,
    NoOfParticipate INT NOT NULL,
    Status NVARCHAR(50),
    InstructorID INT NOT NULL,
    CustomerID INT NOT NULL,
    OfferingID INT NOT NULL,

    CONSTRAINT FK_Booking_Instructor
        FOREIGN KEY (InstructorID)
        REFERENCES Adventure.INSTRUCTOR(UserID),

    CONSTRAINT FK_Booking_Customer
        FOREIGN KEY (CustomerID)
        REFERENCES Adventure.CUSTOMER(UserID),

    CONSTRAINT FK_Booking_Offering
        FOREIGN KEY (OfferingID)
        REFERENCES Adventure.OFFERING(OfferingID)
);

------------------------


--JUNCTION TABLES--


--HOLD, INSTRUCTOR-CERTIFICATION--
CREATE TABLE Adventure.HOLD (
    UserID INT,
    CertificationID INT,

    PRIMARY KEY (UserID, CertificationID),

    CONSTRAINT FK_Hold_Instructor
        FOREIGN KEY (UserID)
        REFERENCES Adventure.INSTRUCTOR(UserID),

    CONSTRAINT FK_Hold_Certification
        FOREIGN KEY (CertificationID)
        REFERENCES Adventure.CERTIFICATION(CertificationID)
);

--REQUIRE, ACTIVITY-CERTIFICATION--
CREATE TABLE Adventure.REQUIRE (
    ActivityID INT,
    CertificationID INT,

    PRIMARY KEY (ActivityID, CertificationID),

    CONSTRAINT FK_Require_Activity
        FOREIGN KEY (ActivityID)
        REFERENCES Adventure.ACTIVITY(ActivityID),

    CONSTRAINT FK_Require_Certification
        FOREIGN KEY (CertificationID)
        REFERENCES Adventure.CERTIFICATION(CertificationID)
);


