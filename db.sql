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

INSERT IGNORE INTO student(name, roll_no, dept) VALUES 
('Pari Manhas', 'CO25301', 'CSE'),
('Palak', 'CO25302', 'CSE'),
('Priya', 'CO25303', 'CIVIL');
