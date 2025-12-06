INSERT INTO Adventure.[USER] (Fname, Lname, DOB, Email, Phone)
VALUES
-- 30 customers
('User1','Customer','1998-01-01','user1@mail.com','050000001'),
('User2','Customer','1997-02-01','user2@mail.com','050000002'),
('User3','Customer','1996-03-01','user3@mail.com','050000003'),
('User4','Customer','1995-04-01','user4@mail.com','050000004'),
('User5','Customer','1999-05-01','user5@mail.com','050000005'),
('User6','Customer','1998-06-01','user6@mail.com','050000006'),
('User7','Customer','1997-07-01','user7@mail.com','050000007'),
('User8','Customer','1996-08-01','user8@mail.com','050000008'),
('User9','Customer','1995-09-01','user9@mail.com','050000009'),
('User10','Customer','1994-10-01','user10@mail.com','050000010'),
('User11','Customer','1998-01-02','user11@mail.com','050000011'),
('User12','Customer','1997-02-02','user12@mail.com','050000012'),
('User13','Customer','1996-03-02','user13@mail.com','050000013'),
('User14','Customer','1995-04-02','user14@mail.com','050000014'),
('User15','Customer','1999-05-02','user15@mail.com','050000015'),
('User16','Customer','1998-06-02','user16@mail.com','050000016'),
('User17','Customer','1997-07-02','user17@mail.com','050000017'),
('User18','Customer','1996-08-02','user18@mail.com','050000018'),
('User19','Customer','1995-09-02','user19@mail.com','050000019'),
('User20','Customer','1994-10-02','user20@mail.com','050000020'),
('User21','Customer','1998-01-03','user21@mail.com','050000021'),
('User22','Customer','1997-02-03','user22@mail.com','050000022'),
('User23','Customer','1996-03-03','user23@mail.com','050000023'),
('User24','Customer','1995-04-03','user24@mail.com','050000024'),
('User25','Customer','1999-05-03','user25@mail.com','050000025'),
('User26','Customer','1998-06-03','user26@mail.com','050000026'),
('User27','Customer','1997-07-03','user27@mail.com','050000027'),
('User28','Customer','1996-08-03','user28@mail.com','050000028'),
('User29','Customer','1995-09-03','user29@mail.com','050000029'),
('User30','Customer','1994-10-03','user30@mail.com','050000030'),

-- 20 instructors
('Inst1','Trainer','1985-01-01','inst1@mail.com','051000001'),
('Inst2','Trainer','1986-02-01','inst2@mail.com','051000002'),
('Inst3','Trainer','1984-03-01','inst3@mail.com','051000003'),
('Inst4','Trainer','1987-04-01','inst4@mail.com','051000004'),
('Inst5','Trainer','1983-05-01','inst5@mail.com','051000005'),
('Inst6','Trainer','1982-06-01','inst6@mail.com','051000006'),
('Inst7','Trainer','1981-07-01','inst7@mail.com','051000007'),
('Inst8','Trainer','1980-08-01','inst8@mail.com','051000008'),
('Inst9','Trainer','1979-09-01','inst9@mail.com','051000009'),
('Inst10','Trainer','1988-10-01','inst10@mail.com','051000010'),
('Inst11','Trainer','1985-11-01','inst11@mail.com','051000011'),
('Inst12','Trainer','1986-12-01','inst12@mail.com','051000012'),
('Inst13','Trainer','1987-01-02','inst13@mail.com','051000013'),
('Inst14','Trainer','1988-02-02','inst14@mail.com','051000014'),
('Inst15','Trainer','1989-03-02','inst15@mail.com','051000015'),
('Inst16','Trainer','1984-04-02','inst16@mail.com','051000016'),
('Inst17','Trainer','1983-05-02','inst17@mail.com','051000017'),
('Inst18','Trainer','1982-06-02','inst18@mail.com','051000018'),
('Inst19','Trainer','1981-07-02','inst19@mail.com','051000019'),
('Inst20','Trainer','1980-08-02','inst20@mail.com','051000020');

INSERT INTO Adventure.CUSTOMER (UserID)
SELECT TOP (30) UserID
FROM Adventure.[USER]
ORDER BY UserID;

INSERT INTO Adventure.INSTRUCTOR (UserID, Specialty)
SELECT UserID, 'General Adventure Training'
FROM Adventure.[USER]
WHERE UserID NOT IN (
    SELECT UserID FROM Adventure.CUSTOMER
);

-- Customers
SELECT u.UserID, u.Fname, u.Lname
FROM Adventure.CUSTOMER c
JOIN Adventure.[USER] u ON c.UserID = u.UserID;

-- Instructors
SELECT u.UserID, u.Fname, u.Lname, i.Specialty
FROM Adventure.INSTRUCTOR i
JOIN Adventure.[USER] u ON i.UserID = u.UserID;



