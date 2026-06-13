USE attendance_db;

CREATE TABLE IF NOT EXISTS users (
    S_NO INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    roll_no VARCHAR(20) UNIQUE NOT NULL,
    dept VARCHAR(20) NOT NULL
);
CREATE TABLE IF NOT EXISTS attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent') NOT NULL,
    FOREIGN KEY (student_id) REFERENCES student(student_id)
);

INSERT IGNORE INTO users(username, password) VALUES ('T1', 'T123');

INSERT IGNORE INTO student (name, roll_no, dept) VALUES
('Nitin Sharma', 'CO25301', 'CSE'),
('Rohin Sharma', 'CO25302', 'CSE'),
('Aaditya Gupta', 'CO25303', 'CSE'),
('Abhinav Atwal', 'CO25304', 'CSE'),
('Akshita', 'CO25305', 'CSE'),
('Alok Shukla', 'CO25306', 'CSE'),
('Amit Singh', 'CO25307', 'CSE'),
('Amitesh Singh', 'CO25308', 'CSE'),
('Anamika Negi', 'CO25309', 'CSE'),
('Anshu Kumar', 'CO25310', 'CSE'),
('Anvi Nagpal', 'CO25311', 'CSE'),
('Arshveer Singh Dhanoa', 'CO25312', 'CSE'),
('Aryan Bansal', 'CO25313', 'CSE'),
('Aryan Sachdeva', 'CO25314', 'CSE'),
('Ashish Gupta', 'CO25315', 'CSE'),
('Ayush', 'CO25316', 'CSE'),
('Divyaj Chandora', 'CO25317', 'CSE'),
('Drishya Singla', 'CO25318', 'CSE'),
('Gaurika Sharma', 'CO25319', 'CSE'),
('Gourav', 'CO25320', 'CSE')
;