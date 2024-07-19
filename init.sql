-- Create database if not exists
CREATE DATABASE IF NOT EXISTS `testweb_db`;

-- Use the database
USE `testweb_db`;

-- Create Django application user
DROP USER IF EXISTS 'django'@'%';
CREATE USER 'django'@'%' IDENTIFIED BY 'password';

-- Grant permissions to Django user
GRANT ALL PRIVILEGES ON `testweb_db`.* TO 'django'@'%';

-- Make changes effective
FLUSH PRIVILEGES;