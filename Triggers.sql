--Trig 1: A customer cannot book an activity if their age < Activity.MinAge--
GO
CREATE TRIGGER Adventure.TRG_CheckCustomerAge
ON Adventure.BOOKING
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted b
        JOIN Adventure.[USER] u
            ON b.CustomerID = u.UserID
        JOIN Adventure.OFFERING o
            ON b.OfferingID = o.OfferingID
        JOIN Adventure.ACTIVITY a
            ON o.ActivityID = a.ActivityID
        WHERE DATEDIFF(YEAR, u.DOB, GETDATE()) < a.MinAge
    )
    BEGIN
        RAISERROR ('Customer does not meet the minimum age requirement.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


--Trig 2: Booking participants must not exceed offering capacity.

GO
CREATE TRIGGER Adventure.TRG_CheckMaxParticipants
ON Adventure.BOOKING
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted b
        JOIN Adventure.OFFERING o
            ON b.OfferingID = o.OfferingID
        WHERE b.NoOfParticipate > o.MaxParticipitate
    )
    BEGIN
        RAISERROR ('Number of participants exceeds the maximum allowed.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


--Trig 3:Instructor must hold ALL certifications required by the activity.
GO
CREATE TRIGGER Adventure.TRG_CheckInstructorCertification
ON Adventure.BOOKING
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted b
        JOIN Adventure.OFFERING o
            ON b.OfferingID = o.OfferingID
        JOIN Adventure.REQUIRE r
            ON o.ActivityID = r.ActivityID
        WHERE NOT EXISTS (
            SELECT 1
            FROM Adventure.HOLD h
            WHERE h.UserID = b.InstructorID
              AND h.CertificationID = r.CertificationID
        )
    )
    BEGIN
        RAISERROR ('Instructor does not hold the required certification for the activity.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO

