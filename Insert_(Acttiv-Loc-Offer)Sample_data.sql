INSERT INTO Adventure.ACTIVITY
(ActivityName, Description, MinAge, Experience, DifficultyLevel)
VALUES
('Rock Climbing', 'Indoor rock climbing session', 12, 'Beginner', 'Medium'),
('Kayaking', 'Outdoor river kayaking', 14, 'Intermediate', 'Hard'),
('Paragliding', 'Air adventure experience', 18, 'Advanced', 'Hard'),
('Hiking', 'Guided mountain hiking', 10, 'Beginner', 'Easy'),
('Scuba Diving', 'Underwater scuba activity', 18, 'Advanced', 'Hard'),
('Zip Lining', 'High-speed zip line ride', 12, 'Beginner', 'Medium');

INSERT INTO Adventure.WATER_SPORT (ActivityID, WaterType, DepthRequirement)
SELECT ActivityID, 'River', 'Medium'
FROM Adventure.ACTIVITY
WHERE ActivityName = 'Kayaking';

INSERT INTO Adventure.WATER_SPORT (ActivityID, WaterType, DepthRequirement)
SELECT ActivityID, 'Sea', 'Deep'
FROM Adventure.ACTIVITY
WHERE ActivityName = 'Scuba Diving';

INSERT INTO Adventure.LAND_SPORT (ActivityID, TerrainType)
SELECT ActivityID, 'Indoor Wall'
FROM Adventure.ACTIVITY
WHERE ActivityName = 'Rock Climbing';

INSERT INTO Adventure.LAND_SPORT (ActivityID, TerrainType)
SELECT ActivityID, 'Mountain Trail'
FROM Adventure.ACTIVITY
WHERE ActivityName = 'Hiking';

INSERT INTO Adventure.AIR_SPORT (ActivityID, Weather, MinAltitude)
SELECT ActivityID, 'Clear', 500
FROM Adventure.ACTIVITY
WHERE ActivityName = 'Paragliding';

INSERT INTO Adventure.AIR_SPORT (ActivityID, Weather, MinAltitude)
SELECT ActivityID, 'Clear', 100
FROM Adventure.ACTIVITY
WHERE ActivityName = 'Zip Lining';

SELECT * FROM Adventure.ACTIVITY;

-------------------------------------------------------------

INSERT INTO Adventure.LOCATION
(LocationName, Address, Country, City)
VALUES
('Adventure Dome', 'Central Street 10', 'Turkey', 'Istanbul'),
('River Camp', 'Valley Road', 'Turkey', 'Antalya'),
('Mountain Peak', 'Highlands Area', 'Turkey', 'Fethiye');

INSERT INTO Adventure.INDOOR (LocationID, FacilityType, Capacity)
SELECT LocationID, 'Climbing Facility', 40
FROM Adventure.LOCATION
WHERE LocationName = 'Adventure Dome';

INSERT INTO Adventure.OUTDOOR (LocationID, NaturalFacility, WeatherCondition)
SELECT LocationID, 'River', 'Variable'
FROM Adventure.LOCATION
WHERE LocationName = 'River Camp';

INSERT INTO Adventure.OUTDOOR (LocationID, NaturalFacility, WeatherCondition)
SELECT LocationID, 'Mountain', 'Cold'
FROM Adventure.LOCATION
WHERE LocationName = 'Mountain Peak';

SELECT * FROM Adventure.LOCATION;

----------------------------------------------------------

INSERT INTO Adventure.OFFERING
(Price, StartTime, EndTime, MaxParticipitate, OfferingDay, LocationID, ActivityID)
SELECT
    150.00, '10:00', '12:00', 15,
    '2025-01-10',
    l.LocationID,
    a.ActivityID
FROM Adventure.ACTIVITY a
JOIN Adventure.LOCATION l
    ON a.ActivityName = 'Rock Climbing'
   AND l.LocationName = 'Adventure Dome';

INSERT INTO Adventure.OFFERING
(Price, StartTime, EndTime, MaxParticipitate, OfferingDay, LocationID, ActivityID)
SELECT
    220.00, '09:00', '13:00', 10,
    '2025-01-12',
    l.LocationID,
    a.ActivityID
FROM Adventure.ACTIVITY a
JOIN Adventure.LOCATION l
    ON a.ActivityName = 'Kayaking'
   AND l.LocationName = 'River Camp';

INSERT INTO Adventure.OFFERING
(Price, StartTime, EndTime, MaxParticipitate, OfferingDay, LocationID, ActivityID)
SELECT
    350.00, '08:00', '11:00', 8,
    '2025-01-15',
    l.LocationID,
    a.ActivityID
FROM Adventure.ACTIVITY a
JOIN Adventure.LOCATION l
    ON a.ActivityName = 'Paragliding'
   AND l.LocationName = 'Mountain Peak';

SELECT * FROM Adventure.OFFERING;

