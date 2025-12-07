--Pro 1: get all offerings with details
GO
CREATE PROCEDURE Adventure.GetAllOfferings
AS
BEGIN
    SELECT
        o.OfferingID,
        a.ActivityName,
        o.OfferingDay,
        o.StartTime,
        o.EndTime,
        l.LocationName,
        o.Price
    FROM Adventure.OFFERING o
    JOIN Adventure.ACTIVITY a
        ON o.ActivityID = a.ActivityID
    JOIN Adventure.LOCATION l
        ON o.LocationID = l.LocationID;
END;
GO
--Pro 2: get booking by customer

CREATE PROCEDURE Adventure.GetBookingsByCustomer
    @CustomerID INT
AS
BEGIN
    SELECT
        b.BookingID,
        b.BookingDate,
        a.ActivityName,
        o.OfferingDay,
        b.Status
    FROM Adventure.BOOKING b
    JOIN Adventure.OFFERING o
        ON b.OfferingID = o.OfferingID
    JOIN Adventure.ACTIVITY a
        ON o.ActivityID = a.ActivityID
    WHERE b.CustomerID = @CustomerID;
END;
GO

--Pro 3: calculate total price for a booking

GO
CREATE PROCEDURE Adventure.GetBookingTotalPrice
    @BookingID INT
AS
BEGIN
    SELECT
        b.BookingID,
        b.NoOfParticipate * o.Price AS TotalPrice
    FROM Adventure.BOOKING b
    JOIN Adventure.OFFERING o
        ON b.OfferingID = o.OfferingID
    WHERE b.BookingID = @BookingID;
END;
GO

--Pro 4: check age eligibility
GO
CREATE PROCEDURE Adventure.CheckCustomerAgeEligibility
    @BookingID INT
AS
BEGIN
    SELECT
        u.Fname + ' ' + u.Lname AS CustomerName,
        a.ActivityName,
        DATEDIFF(YEAR, u.DOB, GETDATE()) AS CustomerAge,
        a.MinAge,
        CASE
            WHEN DATEDIFF(YEAR, u.DOB, GETDATE()) >= a.MinAge
                THEN 'Eligible'
            ELSE 'Not Eligible'
        END AS EligibilityStatus
    FROM Adventure.BOOKING b
    JOIN Adventure.CUSTOMER c
        ON b.CustomerID = c.UserID
    JOIN Adventure.[USER] u
        ON c.UserID = u.UserID
    JOIN Adventure.OFFERING o
        ON b.OfferingID = o.OfferingID
    JOIN Adventure.ACTIVITY a
        ON o.ActivityID = a.ActivityID
    WHERE b.BookingID = @BookingID;
END;
GO

--Pro 5: creat a booking
GO
CREATE PROCEDURE Adventure.CreateBooking
    @BookingDate DATE,
    @NoOfParticipate INT,
    @Status NVARCHAR(50),
    @InstructorID INT,
    @CustomerID INT,
    @OfferingID INT
AS
BEGIN
    INSERT INTO Adventure.BOOKING (
        BookingDate,
        NoOfParticipate,
        Status,
        InstructorID,
        CustomerID,
        OfferingID
    )
    VALUES (
        @BookingDate,
        @NoOfParticipate,
        @Status,
        @InstructorID,
        @CustomerID,
        @OfferingID
    );
END;
GO

--Pro 6: list instructors and their certifications

GO
CREATE PROCEDURE Adventure.GetInstructorValidCertifications
AS
BEGIN
    SELECT
        u.Fname + ' ' + u.Lname AS InstructorName,
        c.CertificationName,
        c.ValidFrom,
        c.ValidTo
    FROM Adventure.HOLD h
    JOIN Adventure.INSTRUCTOR i
        ON h.UserID = i.UserID
    JOIN Adventure.[USER] u
        ON i.UserID = u.UserID
    JOIN Adventure.CERTIFICATION c
        ON h.CertificationID = c.CertificationID
    WHERE GETDATE() BETWEEN c.ValidFrom AND c.ValidTo;
END;
GO

