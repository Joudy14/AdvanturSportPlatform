USE AdventureSportsDB;
GO


EXEC Adventure.CreateBooking
    @BookingDate     = '2024-12-05',
    @NoOfParticipate = 1,
    @Status          = 'Pending',
    @InstructorID    = 32,
    @CustomerID      = 6,
    @OfferingID      = 2;

EXEC Adventure.CreateBooking
    @BookingDate     = '2024-12-10',
    @NoOfParticipate = 3,
    @Status          = 'Confirmed',
    @InstructorID    = 33,
    @CustomerID      = 7,
    @OfferingID      = 3;

EXEC Adventure.GetAllOfferings;
EXEC Adventure.GetInstructorValidCertifications;

SELECT * FROM Adventure.BOOKING;
