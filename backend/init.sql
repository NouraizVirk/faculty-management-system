-- Faculty Management System - Database Initialization Script
-- Run this manually or mount as Docker init script

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS faculty (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample data
INSERT INTO faculty (name, department, email, phone) VALUES
    ('Dr. Sarah Connor', 'Computer Science', 'sarah.connor@university.edu', '+1-555-0192'),
    ('Prof. Alan Turing', 'Mathematics', 'alan.turing@university.edu', '+1-555-0193'),
    ('Dr. Grace Hopper', 'Software Engineering', 'grace.hopper@university.edu', '+1-555-0194')
ON CONFLICT (email) DO NOTHING;
