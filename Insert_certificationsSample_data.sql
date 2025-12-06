INSERT INTO Adventure.CERTIFICATION
(CertificationName, ValidFrom, ValidTo)
VALUES
('Basic Safety Certificate', '2024-01-01', '2026-01-01'),
('Water Sports License',     '2024-01-01', '2027-01-01'),
('Climbing Instructor Cert', '2023-06-01', '2026-06-01'),
('Air Sports Permit',        '2024-03-01', '2025-03-01');

SELECT * FROM Adventure.CERTIFICATION;

------------------------------------------

-- Rock Climbing requires Climbing Instructor Cert
INSERT INTO Adventure.REQUIRE (ActivityID, CertificationID)
SELECT a.ActivityID, c.CertificationID
FROM Adventure.ACTIVITY a
JOIN Adventure.CERTIFICATION c
  ON a.ActivityName = 'Rock Climbing'
 AND c.CertificationName = 'Climbing Instructor Cert';

-- Kayaking requires Water Sports License
INSERT INTO Adventure.REQUIRE (ActivityID, CertificationID)
SELECT a.ActivityID, c.CertificationID
FROM Adventure.ACTIVITY a
JOIN Adventure.CERTIFICATION c
  ON a.ActivityName = 'Kayaking'
 AND c.CertificationName = 'Water Sports License';

-- Scuba Diving requires Water Sports License
INSERT INTO Adventure.REQUIRE (ActivityID, CertificationID)
SELECT a.ActivityID, c.CertificationID
FROM Adventure.ACTIVITY a
JOIN Adventure.CERTIFICATION c
  ON a.ActivityName = 'Scuba Diving'
 AND c.CertificationName = 'Water Sports License';

-- Paragliding requires Air Sports Permit
INSERT INTO Adventure.REQUIRE (ActivityID, CertificationID)
SELECT a.ActivityID, c.CertificationID
FROM Adventure.ACTIVITY a
JOIN Adventure.CERTIFICATION c
  ON a.ActivityName = 'Paragliding'
 AND c.CertificationName = 'Air Sports Permit';

 SELECT * FROM Adventure.REQUIRE;

-----------------------------------

-- Give all instructors the Basic Safety Certificate
INSERT INTO Adventure.HOLD (UserID, CertificationID)
SELECT i.UserID, c.CertificationID
FROM Adventure.INSTRUCTOR i
JOIN Adventure.CERTIFICATION c
  ON c.CertificationName = 'Basic Safety Certificate';

-- Give some instructors specialized certificates
INSERT INTO Adventure.HOLD (UserID, CertificationID)
SELECT TOP (5) i.UserID, c.CertificationID
FROM Adventure.INSTRUCTOR i
JOIN Adventure.CERTIFICATION c
  ON c.CertificationName = 'Climbing Instructor Cert'
ORDER BY i.UserID;

INSERT INTO Adventure.HOLD (UserID, CertificationID)
SELECT UserID, c.CertificationID
FROM Adventure.INSTRUCTOR i
JOIN Adventure.CERTIFICATION c
  ON c.CertificationName = 'Water Sports License'
WHERE i.UserID % 2 = 0;

SELECT * FROM Adventure.HOLD;

-----------------------------------------

