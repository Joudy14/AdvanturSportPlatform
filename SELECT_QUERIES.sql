--Show drived attribute Name--

SELECT 
    UserID,
    Fname + ' ' + Lname AS FullName,
    Email,
    Phone
FROM Adventure.[USER];

--List all instructors with specilaty--

SELECT 
    u.UserID,
    u.Fname + ' ' + u.Lname AS InstructorName,
    i.Specialty
FROM Adventure.INSTRUCTOR i
JOIN Adventure.[USER] u
    ON i.UserID = u.UserID;

--Show all activities and their types--

SELECT 
    a.ActivityID,
    a.ActivityName,
    a.DifficultyLevel
FROM Adventure.ACTIVITY a;

--Show offerings with date,time,location,activity--

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


--List bookings with costomer and instructon names--

SELECT
    b.BookingID,
    b.BookingDate,
    cu.Fname + ' ' + cu.Lname AS CustomerName,
    ins.Fname + ' ' + ins.Lname AS InstructorName,
    b.Status
FROM Adventure.BOOKING b
JOIN Adventure.CUSTOMER c
    ON b.CustomerID = c.UserID
JOIN Adventure.[USER] cu
    ON c.UserID = cu.UserID
JOIN Adventure.INSTRUCTOR i
    ON b.InstructorID = i.UserID
JOIN Adventure.[USER] ins
    ON i.UserID = ins.UserID;


--Drived session duration--

SELECT
    o.OfferingID,
    a.ActivityName,
    DATEDIFF(HOUR, o.StartTime, o.EndTime) AS DurationHours
FROM Adventure.OFFERING o
JOIN Adventure.ACTIVITY a
    ON o.ActivityID = a.ActivityID;

--Drived Calculate total price per booking--

SELECT
    b.BookingID,
    (b.NoOfParticipate * o.Price) AS TotalPrice
FROM Adventure.BOOKING b
JOIN Adventure.OFFERING o
    ON b.OfferingID = o.OfferingID;


--List certifications held by each instructor--

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
    ON h.CertificationID = c.CertificationID;

--Activity and required certifications--

SELECT
    a.ActivityName,
    c.CertificationName
FROM Adventure.REQUIRE r
JOIN Adventure.ACTIVITY a
    ON r.ActivityID = a.ActivityID
JOIN Adventure.CERTIFICATION c
    ON r.CertificationID = c.CertificationID;


--Count booking per activity--

SELECT
    a.ActivityName,
    COUNT(b.BookingID) AS NumberOfBookings
FROM Adventure.BOOKING b
JOIN Adventure.OFFERING o
    ON b.OfferingID = o.OfferingID
JOIN Adventure.ACTIVITY a
    ON o.ActivityID = a.ActivityID
GROUP BY a.ActivityName;


--Costomers older then min age for the activity--

SELECT
    u.Fname + ' ' + u.Lname AS CustomerName,
    a.ActivityName
FROM Adventure.BOOKING b
JOIN Adventure.CUSTOMER c
    ON b.CustomerID = c.UserID
JOIN Adventure.[USER] u
    ON c.UserID = u.UserID
JOIN Adventure.OFFERING o
    ON b.OfferingID = o.OfferingID
JOIN Adventure.ACTIVITY a
    ON o.ActivityID = a.ActivityID
WHERE DATEDIFF(YEAR, u.DOB, GETDATE()) >= a.MinAge;
