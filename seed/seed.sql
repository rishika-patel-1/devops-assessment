INSERT INTO users (name, email)
VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com');

INSERT INTO orders (user_id, amount, status)
VALUES
(1, 250.00, 'Completed'),
(2, 150.50, 'Pending');