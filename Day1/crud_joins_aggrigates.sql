-- Drop tables if they exist (in reverse dependency order)
DROP TABLE IF EXISTS MemberSkills, MemberProfile, "Member", ProjectTheme, ProjectSkill, ProjectApplication, Projects, CityMaster, CountryMaster;

-- Country master table
CREATE TABLE CountryMaster (
    CountryID SERIAL PRIMARY KEY,
    Name VARCHAR(100)
);

-- City master table
CREATE TABLE CityMaster (
    CityID SERIAL PRIMARY KEY,
    CountryID INT REFERENCES CountryMaster(CountryID),
    Name VARCHAR(100)
);

-- Project skills
CREATE TABLE ProjectSkill (
    SkillID SERIAL PRIMARY KEY,
    SkillLabel VARCHAR(100),
    IsActive VARCHAR(50)
);

-- Project themes
CREATE TABLE ProjectTheme (
    ThemeID SERIAL PRIMARY KEY,
    ThemeLabel VARCHAR(100),
    IsActive VARCHAR(50)
);

-- Projects table
CREATE TABLE Projects (
    ProjectID SERIAL PRIMARY KEY,
    Title VARCHAR(200),
    Description TEXT,
    OrgName VARCHAR(100),
    OrgInfo TEXT,
    CountryID INT REFERENCES CountryMaster(CountryID),
    CityID INT REFERENCES CityMaster(CityID),
    StartOn DATE,
    EndOn DATE,
    Type VARCHAR(50),
    MaxSeats INT,
    Deadline DATE,
    ThemeRef VARCHAR(100),
    SkillRef VARCHAR(100),
    Images TEXT,
    Docs TEXT,
    Availability VARCHAR(100),
    VideoURL TEXT
);

-- Member (user) table
CREATE TABLE "Member" (
    MemberID SERIAL PRIMARY KEY,
    FName VARCHAR(100),
    LName VARCHAR(100),
    Contact VARCHAR(20),
    Email VARCHAR(100),
    Role VARCHAR(50),
    Passcode VARCHAR(100)
);

-- Member profile details
CREATE TABLE MemberProfile (
    ProfileID SERIAL PRIMARY KEY,
    MemberID INT REFERENCES "Member"(MemberID),
    GivenName VARCHAR(100),
    FamilyName VARCHAR(100),
    EmpCode VARCHAR(50),
    Supervisor VARCHAR(100),
    Position VARCHAR(100),
    Dept VARCHAR(100),
    Bio TEXT,
    Motivation TEXT,
    CountryID INT REFERENCES CountryMaster(CountryID),
    CityID INT REFERENCES CityMaster(CityID),
    AvailableOn VARCHAR(100),
    LinkedIn TEXT,
    Skills TEXT,
    Avatar TEXT,
    IsActive BOOLEAN
);

-- Project applications
CREATE TABLE ProjectApplication (
    AppID SERIAL PRIMARY KEY,
    ProjectID INT REFERENCES Projects(ProjectID),
    MemberID INT REFERENCES "Member"(MemberID),
    AppliedOn TIMESTAMP,
    IsApproved BOOLEAN,
    SeatNo INT
);

-- Member skills
CREATE TABLE MemberSkills (
    SkillID SERIAL PRIMARY KEY,
    SkillName VARCHAR(100),
    MemberID INT REFERENCES "Member"(MemberID)
);

-- Insert sample countries and cities
INSERT INTO CountryMaster (Name) VALUES ('India'), ('USA');
INSERT INTO CityMaster (CountryID, Name) VALUES (1, 'Mumbai'), (1, 'Delhi'), (2, 'New York');

-- Insert a member
INSERT INTO "Member" (FName, LName, Contact, Email, Role, Passcode)
VALUES ('Arsh', 'Shaikh', '1234567890', 'arsh@example.com', 'Volunteer', 'pass123');

-- Insert member profile
INSERT INTO MemberProfile (MemberID, GivenName, FamilyName, EmpCode, Supervisor, Position, Dept, Bio, Motivation, CountryID, CityID, AvailableOn, LinkedIn, Skills, Avatar, IsActive)
VALUES (1, 'Arsh', 'Shaikh', 'E001', 'Mr. Manager', 'Developer', 'IT', 'My profile text', 'I love volunteering', 1, 1, 'Weekends', 'linkedin.com/arsh', 'Coding', 'arsh.jpg', TRUE);

-- Insert skills and themes
INSERT INTO ProjectSkill (SkillLabel, IsActive) VALUES ('Coding', 'Active');
INSERT INTO ProjectTheme (ThemeLabel, IsActive) VALUES ('Environment', 'Active');

-- Insert a project
INSERT INTO Projects (Title, Description, OrgName, OrgInfo, CountryID, CityID, StartOn, EndOn, Type, MaxSeats, Deadline, ThemeRef, SkillRef, Images, Docs, Availability, VideoURL)
VALUES ('Tree Plantation', 'Planting trees in city parks', 'GreenOrg', 'We care about nature', 1, 1, '2025-06-01', '2025-06-10', 'Short Term', 10, '2025-05-30', '1', '1', 'trees.jpg', 'doc.pdf', 'Weekdays', 'video.com/tree');

-- Insert a project application
INSERT INTO ProjectApplication (ProjectID, MemberID, AppliedOn, IsApproved, SeatNo)
VALUES (1, 1, CURRENT_TIMESTAMP, TRUE, 1);

-- Insert member skill
INSERT INTO MemberSkills (SkillName, MemberID) VALUES ('Coding', 1);

-- Update member contact
UPDATE "Member"
SET Contact = '9876543210'
WHERE MemberID = 1;

-- Delete a project application
DELETE FROM ProjectApplication
WHERE AppID = 1;

-- Select all members
SELECT * FROM "Member";

-- Join: Member, Profile, City, Country
SELECT m.FName, m.LName, c.Name AS City, co.Name AS Country
FROM "Member" m
JOIN MemberProfile mp ON m.MemberID = mp.MemberID
JOIN CityMaster c ON mp.CityID = c.CityID
JOIN CountryMaster co ON mp.CountryID = co.CountryID;

-- Aggregate: Users per city
SELECT c.Name AS City, COUNT(*) AS UserCount
FROM MemberProfile mp
JOIN CityMaster c ON mp.CityID = c.CityID
GROUP BY c.Name;

-- Aggregate: Projects per country
SELECT co.Name AS Country, COUNT(*) AS ProjectCount
FROM Projects p
JOIN CountryMaster co ON p.CountryID = co.CountryID
GROUP BY co.Name;

-- Aggregate: Applications per project
SELECT p.Title, COUNT(pa.AppID) AS Applications
FROM Projects p
LEFT JOIN ProjectApplication pa ON p.ProjectID = pa.ProjectID
GROUP BY p.Title;