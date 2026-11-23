-- Reconstructed from the lab report screenshots (Figures 8.4.2 to 8.4.5, 8.6.2).
-- The report used the password SNA1234 for both the MariaDB root user and tapauuser.
-- It is replaced here with CHANGE_ME. Do not reuse that password anywhere.

CREATE USER 'tapauuser'@'localhost' IDENTIFIED BY 'CHANGE_ME';
CREATE USER 'tapauuser'@'%' IDENTIFIED BY 'CHANGE_ME';
FLUSH PRIVILEGES;

CREATE DATABASE tapaudb;
GRANT ALL PRIVILEGES ON tapaudb.* TO 'tapauuser'@'localhost';
GRANT ALL PRIVILEGES ON tapaudb.* TO 'tapauuser'@'%';
FLUSH PRIVILEGES;
USE tapaudb;

CREATE TABLE menu (
  id INT AUTO_INCREMENT PRIMARY KEY,
  item_name VARCHAR(100) NOT NULL,
  category VARCHAR(50),
  price DECIMAL(5,2) NOT NULL
);

INSERT INTO menu (item_name, category, price) VALUES
  ('Nasi Lemak', 'Rice', 5.50),
  ('Roti Canai', 'Bread', 2.00),
  ('Teh Tarik', 'Drink', 2.50),
  ('Mee Goreng', 'Noodle', 6.00),
  ('Ayam Goreng', 'Chicken', 7.50);

-- Force TLS for both accounts (Figure 8.6.2)
ALTER USER 'tapauuser'@'localhost' REQUIRE SSL;
ALTER USER 'tapauuser'@'%' REQUIRE SSL;
FLUSH PRIVILEGES;
