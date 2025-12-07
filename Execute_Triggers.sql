USE AdventureSportsDB
GO

--Use a customer who is under the MinAge of the activity linked to Offering 1.

EXEC Adventure.CreateBooking
    @BookingDate     = '2024-12-20',
    @NoOfParticipate = 1,
    @Status          = 'Confirmed',
    @InstructorID    = 33,
    @CustomerID      = 5,   -- underage customer
    @OfferingID      = 1;


        --Use a number that exceeds Offering.MaxParticipitate.

    EXEC Adventure.CreateBooking
    @BookingDate     = '2024-12-21',
    @NoOfParticipate = 999,   -- exceeds capacity
    @Status          = 'Confirmed',
    @InstructorID    = 33,
    @CustomerID      = 6,
    @OfferingID      = 1;

--Use an instructor who does NOT hold the required certification.
DELETE FROM Adventure.HOLD
WHERE UserID = 34;

    EXEC Adventure.CreateBooking
    @BookingDate     = '2024-12-22',
    @NoOfParticipate = 1,
    @Status          = 'Confirmed',
    @InstructorID    = 34,   -- instructor without required cert
    @CustomerID      = 6,
    @OfferingID      = 1;


--Use valid data that meets all rules.

    EXEC Adventure.CreateBooking
    @BookingDate     = '2024-12-23',
    @NoOfParticipate = 2,
    @Status          = 'Confirmed',
    @InstructorID    = 33,
    @CustomerID      = 6,
    @OfferingID      = 1;

