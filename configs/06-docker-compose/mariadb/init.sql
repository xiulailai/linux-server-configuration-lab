-- Reconstructed from the lab report screenshots (Figure 6.10.2).
CREATE TABLE IF NOT EXISTS visitors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    visited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    note VARCHAR(255)
);

INSERT INTO visitors (note) VALUES
    ('Stack initialised'),
    ('Adminer login test record');
