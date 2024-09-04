CREATE DATABASE IF NOT EXISTS mydatabase;

-- 데이터베이스 사용
USE mydatabase;

-- 사용자 정보를 저장할 테이블을 생성합니다.
CREATE TABLE IF NOT EXISTS user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
