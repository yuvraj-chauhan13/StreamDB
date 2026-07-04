SET search_path TO streamdb;

-- =========================================================
-- 1) INFRASTRUCTURE & PLANS
-- =========================================================
INSERT INTO Subscription_Plan (plan_id, currency, amount, price, country, is_trial, trial_duration) VALUES
(1,'INR',129,129,'India',FALSE,NULL),
(12,'INR',1189,1189,'India',FALSE,NULL),
(1,'INR',0,0,'India',TRUE,3),
(1,'USD',10.99,10.99,'USA',FALSE,NULL),
(1,'USD',5.99,5.99,'USA',TRUE,5),
(1,'GBP',9.99,9.99,'UK',FALSE,NULL)
ON CONFLICT DO NOTHING;

INSERT INTO Label (label_id, label_name, country, address, start_year) VALUES
(1, 'T-Series', 'India', 'Mumbai', 1983),
(2, 'Sony Music', 'USA', 'New York', 1929),
(3, 'Universal Music', 'USA', 'California', 1934),
(4, 'HMV India', 'India', 'Delhi', 1998),
(5, 'Def Jam', 'USA', 'New York', 1984)
ON CONFLICT (label_id) DO NOTHING;

INSERT INTO Genre (genre_id, name, parent_genre_id) VALUES
(1, 'Pop', NULL), (2, 'Rock', NULL), (3, 'Hip Hop', NULL),
(4, 'Classical', NULL), (5, 'Bollywood', NULL), (6, 'EDM', 1),
(7, 'Romantic', NULL), (8, 'Acoustic', NULL), (9, 'Indie', NULL),
(10, 'Dance', 1), (11, 'Soul', NULL), (12, 'Punjabi', 3),
(13, 'Electronic', 6), (14, 'Retro', 2)
ON CONFLICT (genre_id) DO NOTHING;

-- =========================================================
-- 2) USERS & ARTISTS
-- =========================================================
-- Fixed ID Users
INSERT INTO "User" (user_id, user_name, password_hash, email, country, user_type, registration_date) VALUES
(21, 'Aditi Rao', '$2b$10$u1AditiRaoHashExample0000000000000000000000000000000', 'aditi.rao@gmail.com', 'India', 'premium', '2025-01-05 09:00:00'),
(22, 'Kabir Mehta', '$2b$10$u2KabirMehtaHashExample00000000000000000000000000000', 'kabir.mehta@gmail.com', 'India', 'free', '2024-12-01 10:00:00'),
(23, 'Mehul Jain', '$2b$10$u3MehulJainHashExample000000000000000000000000000000', 'mehul.jain@gmail.com', 'India', 'free', '2025-02-15 11:30:00'),
(24, 'Zara Khan', '$2b$10$u4ZaraKhanHashExample0000000000000000000000000000000', 'zara.khan@gmail.com', 'UK', 'free', '2024-11-20 08:45:00'),
(25, 'Ryan Cooper', '$2b$10$u5RyanCooperHashExample00000000000000000000000000000', 'ryan.cooper@gmail.com', 'USA', 'premium', '2024-09-01 14:20:00'),
(26, 'Maya Iyer', '$2b$10$u6MayaIyerHashExample0000000000000000000000000000000', 'maya.iyer@gmail.com', 'India', 'premium', '2025-03-12 08:15:00'),
(27, 'Esha Nair', '$2b$10$u7EshaNairHashExample0000000000000000000000000000000', 'esha.nair@gmail.com', 'India', 'free', '2025-04-10 12:00:00'),
(28, 'Victor Hugo', '$2b$10$u8VictorHugoHashExample00000000000000000000000000000', 'victor.hugo@gmail.com', 'France', 'premium', '2025-05-14 14:20:00'),
(29, 'Nina Patel', '$2b$10$u9NinaPatelHashExample000000000000000000000000000000', 'nina.patel@gmail.com', 'India', 'free', '2025-06-08 16:00:00'),
(30, 'Leo Martin', '$2b$10$u10LeoMartinHashExample0000000000000000000000000000', 'leo.martin@gmail.com', 'Canada', 'premium', '2025-07-20 18:45:00'),
(31,'Amit Joshi','$2b$10$hash','amit@gmail.com','India','premium','2024-01-10'),
(32,'Nidhi Sharma','$2b$10$hash','nidhi@gmail.com','India','premium','2024-02-05'),
(33,'Vivek Patel','$2b$10$hash','vivek@gmail.com','India','premium','2024-03-12'),
(34,'Simran Kaur','$2b$10$hash','simran@gmail.com','India','premium','2024-04-18'),
(35,'Harsh Mehta','$2b$10$hash','harsh@gmail.com','India','premium','2024-05-22'),
(36,'Rohan Das','$2b$10$hash','rohan@gmail.com','India','free','2024-01-15'),
(37,'Ishita Jain','$2b$10$hash','ishita@gmail.com','India','free','2024-02-20'),
(38,'Manav Singh','$2b$10$hash','manav@gmail.com','India','free','2024-03-25'),
(39,'Tanvi Shah','$2b$10$hash','tanvi@gmail.com','India','free','2024-04-30'),
(40,'Kunal Yadav','$2b$10$hash','kunal@gmail.com','India','free','2024-05-05')
ON CONFLICT (user_id) DO NOTHING;

-- Auto-Increment Users
INSERT INTO "User" (user_name, password_hash, email, country, user_type) VALUES
('Aarav Patel','$2b$10$Xk9sJ1y8nQ2lYc9zFvT2Oe9Jx8QkWm7R5u2eGvYz9Kq1HcT7mL8uG','aarav@gmail.com','India','premium'),
('Riya Sharma','$2b$10$Qm9dK7L2pZc1Xv8BfH3sRe4Tg6YpJ9nWk2sFh8Lm3R7uVx5Pq1ZcW','riya@gmail.com','India','free'),
('John Smith','$2b$10$Lp8vD3fGh2Yz9XcK1q7MnW5tR8sVb6Pj4eT2Zx9Qk7Fh1Wc3LmN','john@gmail.com','USA','premium'),
('Emma Watson','$2b$10$Zx9Wc3LmN8vD3fGh2Yz9XcK1q7MnW5tR8sVb6Pj4eT2Qk7Fh1','emma@gmail.com','UK','admin'),
('Liam Brown','$2b$10$Aq1Ws2Ed3Rf4Tg5Yh6Uj7Ik8Ol9Pz0XcVbNm1Qw2Er3Ty4Ui5','liam@gmail.com','USA','free'),
('Noah Wilson','$2b$10$Mnb7Vcx5Zx2As1Df3Gh4Jk6L9Qw0ErTyUi8Op7Pl6Kj5Hg4Fd3','noah@gmail.com','Canada','premium'),
('Ananya Verma','$2b$10$Pq9Ws8Ed7Rf6Tg5Yh4Uj3Ik2Ol1Pz0XcVbNm1Qw2Er3Ty4Ui5','ananya@gmail.com','India','free'),
('Sophia Johnson','$2b$10$Hj7Kk8Lm9Nn0BbVvCcXxZzAaSsDdFfGgHhJjKkLlMmNnOoPpQq','sophia@gmail.com','USA','premium'),
('Oliver Davis','$2b$10$Wq1Er2Ty3Ui4Op5As6Df7Gh8Jk9Lz0XcVbNm1Qw2Er3Ty4Ui5','oliver@gmail.com','UK','free'),
('Isabella Martinez','$2b$10$ZxCvBnMqWeRtYuIoPaSdFgHjKlQwErTyUiOpAsDfGhJkLzXcVb','isabella@gmail.com','Spain','premium'),
('Karan Shah','$2b$10$PlOkMnIjUhYgTfRdEsWaQzXcVbNm1Qw2Er3Ty4Ui5Op6As7Df8','karan@gmail.com','India','premium'),
('Sneha Iyer','$2b$10$GhJkLmNoPqRsTuVwXyZaBcDeFgHiJkLmNoPqRsTuVwXyZaBcDe','sneha@gmail.com','India','free'),
('David Miller','$2b$10$QwErTyUiOpAsDfGhJkLzXcVbNm1Qw2Er3Ty4Ui5Op6As7Df8Gh','david@gmail.com','USA','premium'),
('Emily Clark','$2b$10$YhTfRdEsWaQzXcVbNm1Qw2Er3Ty4Ui5Op6As7Df8GhJkLmNoPq','emily@gmail.com','UK','free'),
('Lucas Moore','$2b$10$ZxCvBnMqWeRtYuIoPaSdFgHjKlQwErTyUiOpAsDfGhJkLzXcVb','lucas@gmail.com','USA','premium'),
('Olivia Taylor','$2b$10$PlOkMnIjUhYgTfRdEsWaQzXcVbNm1Qw2Er3Ty4Ui5Op6As7Df8','olivia@gmail.com','Canada','free'),
('Rohit Sharma','$2b$10$GhJkLmNoPqRsTuVwXyZaBcDeFgHiJkLmNoPqRsTuVwXyZaBcDe','rohit@gmail.com','India','premium'),
('Pooja Singh','$2b$10$QwErTyUiOpAsDfGhJkLzXcVbNm1Qw2Er3Ty4Ui5Op6As7Df8Gh','pooja@gmail.com','India','free'),
('Chris Evans','$2b$10$YhTfRdEsWaQzXcVbNm1Qw2Er3Ty4Ui5Op6As7Df8GhJkLmNoPq','chris@gmail.com','USA','premium'),
('Natalie Portman','$2b$10$ZxCvBnMqWeRtYuIoPaSdFgHjKlQwErTyUiOpAsDfGhJkLzXcVb','natalie@gmail.com','USA','admin')
ON CONFLICT DO NOTHING;

INSERT INTO Artist (artist_id, name, country, debut_year) VALUES
(1, 'Arijit Singh','India',2005), (2, 'Taylor Swift','USA',2006), (3, 'Ed Sheeran','UK',2010),
(4, 'Shreya Ghoshal','India',2002), (5, 'Drake','Canada',2008), (6, 'Adele','UK',2008),
(7, 'Atif Aslam','Pakistan',2004), (8, 'Billie Eilish','USA',2016), (9, 'Justin Bieber','Canada',2009),
(10, 'Neha Kakkar','India',2008), (11, 'Badshah','India',2012), (12, 'Dua Lipa','UK',2015),
(13, 'The Weeknd','Canada',2011), (14, 'Sidhu Moosewala','India',2016), (15, 'Post Malone','USA',2015),
(16, 'Bruno Mars','USA',2010), (17, 'Coldplay','UK',1996), (18, 'Sia','Australia',1997),
(19, 'A. R. Rahman', 'India', 1992), (20, 'Armaan Malik', 'India', 2014), (21, 'Shawn Mendes', 'Canada', 2013),
(22, 'Harrdy Sandhu', 'India', 2011), (23, 'Ritviz', 'India', 2017), (24, 'The Chainsmokers', 'USA', 2012),
(25, 'Amaal Mallik', 'India', 2014), (26, 'Nikhil D Souza', 'India', 2010), (27, 'Jubin Nautiyal', 'India', 2014),
(28, 'Shawn Mendes Duplicate', 'Canada', 2013), (29, 'Ritviz Duplicate', 'India', 2017), (30, 'Chainsmokers Duplicate', 'USA', 2012),
(50,'Independent Artist','India',2022)
ON CONFLICT (artist_id) DO NOTHING;

-- =========================================================
-- 3) MUSIC CONTENT
-- =========================================================
INSERT INTO Song (song_id, title, duration) VALUES
(1, 'Tum Hi Ho', 262),
(2, 'Shape of You', 233),
(3, 'Blinding Lights', 200),
(4, 'Perfect', 263),
(5, 'Raabta', 243),
(6, 'Levitating', 203),
(7, 'Despacito', 228),
(8, 'Believer', 204),
(9, 'Faded', 212),
(10, 'Closer', 244),
(11, 'Havana', 217),
(12, 'Senorita', 220),
(13, 'Starboy', 230),
(14, 'Cheap Thrills', 211),
(15, 'Yellow', 269),
(16, 'Fix You', 295),
(17, 'Brown Munde', 241),
(18, '295', 270),
(19, 'Kesariya', 268),
(20, 'Chaiyya Chaiyya', 400),
(21, 'Mast Magan', 240),
(22, 'Happier', 235),
(23, 'Aashiyan', 250),
(24, 'Sunflower', 180),
(25, 'Tu Aake Dekhle', 230),
(26, 'Dance Monkey', 210),
(27, 'Unstoppable', 221),
(28, 'Haseen', 245),
(29, 'Kya Baat Ay', 200),
(30, 'Nadaan Parindey', 260),
(31, 'Raatan Lambiyan', 270),
(32, 'Pehla Nasha', 250),
(33, 'Señorita Remix', 220),
(34, 'Memories', 190),
(35, 'Arcade', 200),
(36, 'Iktara', 260),
(37, 'The Nights', 205),
(38, 'Levels', 212),
(39, 'Love Story Remix', 240),
(40, 'Imagine', 240),
(41, 'Meri Subah', 215),
(42, 'Baarish', 200),
(43, 'Midnight Love', 230),
(44, 'Kya Hua', 240),
(45, 'Sunset Drive', 210),
(101, 'Love Forever', 260),
(102, 'Endless Love', 300),
(103, 'Crazy Love Night', 250),
(104, 'Love in Rain', 270),
(105, 'Broken Love Story', 255),
(106, 'True Love Anthem', 280),
(201, 'Viral Beat 1', 210),
(202, 'Viral Beat 2', 220),
(203, 'Viral Beat 3', 230),
(204, 'Viral Beat 4', 240),
(205, 'Viral Beat 5', 250),
(601, 'Hidden Gem 1', 210),
(602, 'Hidden Gem 2', 220),
(603, 'Hidden Gem 3', 230),
(604, 'Hidden Gem 4', 240),
(605, 'Hidden Gem 5', 250),
(610, 'Rare Track 1', 200),
(611, 'Rare Track 2', 210),
(50, 'Old Classic 1', 260),
(51, 'Old Classic 2', 270)
ON CONFLICT (song_id) DO NOTHING;

INSERT INTO Album (album_id, name, release_year, edition, artist_id, label_id) VALUES
(1,'Aashiqui 2',2013,'Original',1,1),
(2,'Divide',2017,'Deluxe',3,2),
(3,'After Hours',2020,'Standard',5,3),
(4,'Starboy Album',2016,'Standard',13,2),
(5, 'Echoes of 2024', 2024, 'Deluxe', 19, 1),
(6, 'Midnight Drive', 2026, 'Standard', 20, 2),
(7, 'Global Waves', 2026, 'Original', 21, 3),
(8, 'Indie Nights', 2021, 'Standard', 23, 5),
(14,'Morning Lights', 2026, 'Standard', 26, 1),
(15,'Love Waves', 2026, 'Deluxe', 27, 2)
ON CONFLICT (album_id) DO NOTHING;

-- =========================================================
-- 4) MAPPINGS (SUNG_BY, CONTAINS, CLASSIFICATION)
-- =========================================================
INSERT INTO Sung_By (song_id, artist_id) VALUES
(1,1),(2,3),(3,5),(4,3),(5,1),(11,11),(12,12),
(21, 19), (21, 20), (21, 25), (22, 21), (23, 19), (24, 21), (25, 22), (26, 24),
(27, 24), (27, 25), (28, 20), (29, 23), (30, 19), (31, 20), (32, 19),
(33, 20), (33, 21), (33, 24), (34, 24), (35, 23), (36, 19), (37, 24), (38, 24),
(39, 20), (40, 25), (41,26), (41,27), (43,27), (43,28), (45,28),
(22,19),(23,19),(24,19),(25,19)
ON CONFLICT DO NOTHING;

INSERT INTO Contains (album_id, song_id) VALUES
(1,1),(1,5),(2,2),(2,4),(3,3),(3,6),(4,11),(4,12),
(5, 21), (5, 23), (5, 30), (5, 32),
(6, 25), (6, 26), (6, 33), (6, 39),
(7, 22), (7, 24), (7, 31), (7, 37), (7, 38),
(8, 27), (8, 34), (8, 36), (8, 40),
(14,41),(14,42),(15,43),(15,44)
ON CONFLICT DO NOTHING;

INSERT INTO Classification (song_id, genre_id) VALUES
(1,5),(2,1),(3,1),(4,1),(5,5),(11,1),(12,1),
(21, 7), (21, 5), (21, 11), (21, 1), (22, 1), (22, 8), (23, 7), (23, 4),
(24, 1), (24, 9), (24, 10), (25, 3), (25, 7), (25, 10), (25, 11), (26, 1),
(26, 10), (26, 13), (26, 11), (27, 1), (27, 10), (27, 13), (28, 7), (28, 9), (28, 8),
(29, 12), (29, 10), (29, 3), (30, 4), (30, 5), (30, 11), (31, 7), (31, 5),
(32, 7), (32, 14), (32, 1), (33, 1), (33, 10), (33, 6), (34, 1), (34, 8),
(35, 8), (35, 9), (36, 7), (36, 11), (36, 9), (37, 6), (37, 10), (37, 1),
(38, 6), (38, 10), (38, 1), (39, 1), (39, 7), (39, 10), (40, 1), (40, 11),
(41,7),(41,5),(41,11),(41,1), (42,7),(42,8), (43,7),(43,1),(43,10), (44,7),(44,4),
(45,1),(45,10),(45,13),
(601,2),(602,3),(603,4),(604,6),(605,9)
ON CONFLICT DO NOTHING;

-- =========================================================
-- 5) PLAYLISTS, FOLLOWING, COMMERCE
-- =========================================================
INSERT INTO Playlist (playlist_id, playlist_name, created_date, user_id) VALUES
(1,'Morning Energy', CURRENT_TIMESTAMP, 1),
(2,'Chill Vibes', CURRENT_TIMESTAMP, 2),
(3,'Party Mix', CURRENT_TIMESTAMP, 3),
(4,'Road Trip', CURRENT_TIMESTAMP, 5),
(5, 'Gym Motivation', CURRENT_TIMESTAMP, 26),
(6, 'Romantic Vibes', CURRENT_TIMESTAMP, 27),
(7, 'Mixed Genre Vault', CURRENT_TIMESTAMP, 21),
(8, 'Empty Playlist', CURRENT_TIMESTAMP, 25),
(9, 'Old and New Mix', CURRENT_TIMESTAMP, 22),
(10, 'Free User Mix', CURRENT_TIMESTAMP, 24),
(11, 'Viral Hits', CURRENT_TIMESTAMP, 23),
(12,'Gym Motivation Extra', CURRENT_TIMESTAMP, 31),
(13,'Romantic Vibes Extra', CURRENT_TIMESTAMP, 32),
(14,'Mixed Genre Extra', CURRENT_TIMESTAMP, 33)
ON CONFLICT (playlist_id) DO NOTHING;

INSERT INTO Playlist_Songs (playlist_id, song_id) VALUES
(1,2),(1,3),(2,1),(2,5),(3,11),(4,12),
(5, 26), (5, 27), (5, 37), (5, 38), (5, 6), (5, 21),
(6, 21), (6, 23), (6, 31), (6, 32), (6, 36), (6, 39),
(7, 21), (7, 24), (7, 25), (7, 26), (7, 29), (7, 33), (7, 34), (7, 35),
(9, 1), (9, 2), (9, 15), (9, 21), (9, 31), (9, 40),
(10, 21), (10, 25), (10, 26), (10, 30), (10, 35), (10, 39),
(11, 21), (11, 26), (11, 27), (11, 33), (11, 37), (11, 38), (11, 24),
(12,41),(12,43),(13,41),(13,44),(14,45),
(6,24),(6,25),(6,26),
(5,601),(6,601),(7,601),(9,601),(10,601),
(5,602),(6,602),(7,602),(6,603),(7,603),(7,604),(9,604),(10,605),
(5,610),(6,611),
(7,50),(7,51),(10,50)
ON CONFLICT DO NOTHING;

INSERT INTO Following (user_id, artist_id) VALUES
(1,1),(2,3),(3,2),(10,11),(11,12),
(21, 19), (21, 20), (21, 21), (21, 22), (21, 23), (21, 24),
(22, 19), (22, 24), (22, 25),
(23, 19), (23, 24),
(1, 19), (2, 19), (3, 19), (4, 19), (5, 19), (6, 19), (7, 19), (8, 19), (9, 19), (10, 19),
(1, 20), (2, 21), (3, 24), (4, 22), (5, 23), (6, 25),
(31,26),(31,27),(31,28),(31,29),(31,30),(31,1),
(32,26),(32,27),(32,28),(32,29),(32,30),(32,2)
ON CONFLICT DO NOTHING;

INSERT INTO Payment (payment_id, payment_mode, amount, payment_date, user_id, plan_id) VALUES
(1,'upi',129, CURRENT_TIMESTAMP, 1, 1),
(2,'credit_card',1189, CURRENT_TIMESTAMP, 3, 2),
(3,'debit_card',10.99, CURRENT_TIMESTAMP, 4, 4),
(4,'wallet',5.99, CURRENT_TIMESTAMP, 6, 5),
(5,'net_banking',129, CURRENT_TIMESTAMP, 2, 1),
(6, 'upi', 129.00, CURRENT_TIMESTAMP, 21, 1),
(7, 'credit_card', 1189.00, CURRENT_TIMESTAMP, 25, 2),
(8, 'net_banking', 129.00, CURRENT_TIMESTAMP, 26, 1),
(9, 'debit_card', 10.99, CURRENT_TIMESTAMP, 28, 4),
(10, 'wallet', 5.99, CURRENT_TIMESTAMP, 30, 5),
(11,'upi',129, CURRENT_TIMESTAMP, 31, 1),
(12,'card',1189, CURRENT_TIMESTAMP, 32, 2)
ON CONFLICT (payment_id) DO NOTHING;

INSERT INTO Subscription (user_id, plan_id, payment_id, start_date) VALUES
(1,1,1,'2026-01-10'), (3,2,2,'2026-01-15'), (4,4,3,'2026-02-01'),
(6,5,4,'2026-02-10'), (2,1,5,'2026-03-01'), (21, 1, 6, '2026-04-10'),
(25, 2, 7, '2026-03-25'), (26, 1, 8, '2026-04-01'), (28, 4, 9, '2026-03-30'),
(30, 5, 10, '2026-04-12'), (31,1,11,'2026-03-10'), (32,2,12,'2026-03-12')
ON CONFLICT DO NOTHING;

INSERT INTO Review (user_id, song_id, comment, rating) VALUES
(1,1,'Amazing',5),(2,2,'Nice',4),(3,11,'Great',5),
(21, 21, 'Beautiful composition', 5), (22, 21, 'Loved the melody', 5),
(23, 24, 'Too weak', 1), (24, 24, 'Not impressive', 2),
(25, 26, 'Very catchy', 4), (26, 27, 'Dance floor hit', 5),
(27, 33, 'Great remix', 5), (28, 33, 'Loved the energy', 4),
(29, 29, 'Average track', 2), (30, 35, 'Not my style', 1),
(31,41,'Good',5), (32,43,'Nice',5), (36,42,'Bad',1),
(1,201,'ok',3),(2,201,'nice',4), (1,202,'ok',3),(2,202,'nice',4),
(1,203,'ok',3),(2,203,'nice',4), (1,204,'ok',3),(2,204,'nice',4),
(1,205,'ok',3),(2,205,'nice',4)
ON CONFLICT DO NOTHING;

-- =========================================================
-- 6) USAGE DATA (PLAYBACK, SESSIONS, ADS)
-- =========================================================
INSERT INTO Playback (playback_id, timestamp, user_id, song_id) VALUES
(1,'2026-04-01 08:30:00',1,1), (2,'2026-04-01 08:35:00',1,3),
(3,'2026-04-02 09:00:00',2,5), (4,'2026-04-02 10:15:00',3,2),
(5,'2026-04-02 11:20:00',4,4), (6,'2026-04-03 12:00:00',5,6),
(7,'2026-04-03 13:00:00',6,7), (8,'2026-04-03 14:00:00',7,8),
(1001,NOW(),36,41), (1002,NOW(),36,43), (1003,NOW(),37,41), (1004,NOW(),38,45), (1005,NOW(),39,43),
(7401,NOW(),23,21), (7402,NOW(),23,24), (7403,NOW(),23,25), (7404,NOW(),23,26), (7405,NOW(),23,27), (7406,NOW(),23,28), (7407,NOW(),23,29),
(8001,NOW(),23,601), (8002,NOW(),23,602), (8003,NOW(),23,603),
(9001,'2026-04-18 06:30:00',21,21), (9002,'2026-04-18 08:00:00',22,22), (9003,'2026-04-18 10:30:00',23,23), (9004,'2026-04-18 13:00:00',24,24),
(9005,'2026-04-18 15:30:00',25,25), (9006,'2026-04-18 18:00:00',26,26), (9007,'2026-04-18 20:30:00',27,27), (9008,'2026-04-18 22:30:00',28,28),
(9009,'2026-04-18 23:45:00',29,29), (9010,'2026-04-18 01:30:00',30,30),
(9101,NOW(),23,21), (9102,NOW(),23,22), (9103,NOW(),23,23), (9104,NOW(),23,24), (9105,NOW(),23,25), (9106,NOW(),23,26),
(9201,'2026-04-18 23:30:00',29,21), (9202,'2026-04-18 00:30:00',29,22), (9203,'2026-04-18 01:30:00',29,23), (9204,'2026-04-18 02:30:00',29,24), (9205,'2026-04-18 03:30:00',29,25)
ON CONFLICT (playback_id) DO NOTHING;

-- Pattern-based Playback (Generate Series blocks)
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 9 + n - 1, TIMESTAMP '2025-01-15 12:00:00' + ((n - 1) * INTERVAL '1 month'), 23, 30 FROM generate_series(1, 12) AS n ON CONFLICT DO NOTHING;
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 7000 + n, TIMESTAMP '2025-01-10' + ((n - 1) * INTERVAL '1 month'), 23, 31 FROM generate_series(1, 12) AS n ON CONFLICT DO NOTHING;
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 7100 + n, TIMESTAMP '2025-01-15' + ((n - 1) * INTERVAL '1 month'), 23, 32 FROM generate_series(1, 12) AS n ON CONFLICT DO NOTHING;
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 7200 + n, TIMESTAMP '2025-01-20' + ((n - 1) * INTERVAL '1 month'), 23, 33 FROM generate_series(1, 12) AS n ON CONFLICT DO NOTHING;
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 7300 + n, TIMESTAMP '2025-01-25' + ((n - 1) * INTERVAL '1 month'), 23, 34 FROM generate_series(1, 12) AS n ON CONFLICT DO NOTHING;

-- High-Frequency Viral Data
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 21 + n - 1, NOW() - INTERVAL '6 days' + ((n - 1) * INTERVAL '10 minutes'), 23, 26 FROM generate_series(1, 61) AS n ON CONFLICT DO NOTHING;
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 3000 + n, NOW(), 1, 201 FROM generate_series(1, 55) AS n ON CONFLICT DO NOTHING;
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 3100 + n, NOW(), 1, 202 FROM generate_series(1, 55) AS n ON CONFLICT DO NOTHING;
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 3200 + n, NOW(), 1, 203 FROM generate_series(1, 55) AS n ON CONFLICT DO NOTHING;
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 3300 + n, NOW(), 1, 204 FROM generate_series(1, 55) AS n ON CONFLICT DO NOTHING;
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 3400 + n, NOW(), 1, 205 FROM generate_series(1, 55) AS n ON CONFLICT DO NOTHING;

-- Recent Burst Activity
INSERT INTO Playback (playback_id, timestamp, user_id, song_id)
SELECT 82 + n - 1, NOW() - INTERVAL '20 days' + ((n - 1) * INTERVAL '30 minutes'), 23, 
CASE ((n - 1) % 7) WHEN 0 THEN 24 WHEN 1 THEN 25 WHEN 2 THEN 27 WHEN 3 THEN 33 WHEN 4 THEN 34 WHEN 5 THEN 37 ELSE 38 END
FROM generate_series(1, 40) AS n ON CONFLICT DO NOTHING;

-- Sessions
INSERT INTO Guest_Session (session_id, ip_address, country, start_time, end_time) VALUES
(1,'45.12.33.1','India',CURRENT_TIMESTAMP,NULL), (2, '203.0.113.10', 'India', '2025-10-01 20:00:00', NULL), (3, '198.51.100.42', 'USA', '2025-11-15 19:30:00', NULL),
(10,'101.1.1.1','India','2026-04-18 08:00:00','2026-04-18 08:05:00'), (11,'101.1.1.2','India','2026-04-18 09:00:00','2026-04-18 09:45:00'),
(12,'101.1.1.3','India','2026-04-18 10:00:00','2026-04-18 12:30:00'), (13,'102.2.2.2','USA','2026-04-18 13:00:00','2026-04-18 13:02:00'),
(14,'102.2.2.3','USA','2026-04-18 14:00:00','2026-04-18 15:30:00'), (15,'103.3.3.3','UK','2026-04-18 16:00:00','2026-04-18 19:30:00'),
(16,'103.3.3.4','UK','2026-04-18 20:00:00','2026-04-18 20:03:00'), (17,'104.4.4.4','Canada','2026-04-18 21:00:00','2026-04-18 22:00:00'),
(18,'105.5.5.5','India','2026-04-18 23:00:00','2026-04-19 01:30:00'), (19,'106.6.6.6','France','2026-04-18 07:00:00','2026-04-18 07:02:00'),
(101,'10.0.0.1','India','2026-04-18 10:00:00','2026-04-18 10:01:00'), (102,'10.0.0.2','India','2026-04-18 11:00:00','2026-04-18 11:01:30'),
(103,'10.0.0.3','USA','2026-04-18 12:00:00','2026-04-18 12:01:10'), (104,'10.0.0.4','UK','2026-04-18 13:00:00','2026-04-18 13:01:40'),
(105,'10.0.0.5','Canada','2026-04-18 14:00:00','2026-04-18 14:01:20'), (106,'10.0.0.6','France','2026-04-18 15:00:00','2026-04-18 15:01:50')
ON CONFLICT (session_id) DO NOTHING;

INSERT INTO Unlogged_User (session_id, song_id) VALUES (1,3), (2, 24), (2, 26), (3, 31), (3, 37) ON CONFLICT DO NOTHING;

-- Ads & Injections
INSERT INTO Advertisement (ad_id, company_name, duration) VALUES
(1,'Coca-Cola',15),(2,'Nike',30),(3,'Amazon',20), (4, 'Spotify Ads', 30), (5, 'Apple Music Ads', 25), (6, 'Netflix Ads', 45),
(7, 'Pepsi Ads', 20), (8, 'Flipkart Sale Ads', 15), (9, 'Samsung Galaxy Ads', 35), (10,'Spotify Ads Extra', 30), (11,'Amazon Ads Extra', 20)
ON CONFLICT (ad_id) DO NOTHING;

INSERT INTO Targeting (ad_id, genre_id) VALUES
(1,1),(2,6),(3,1), (4, 7), (5, 7), (6, 7), (7, 7), (8, 7), (9, 7), (4, 1), (5, 1), (6, 10), (7, 10), (10,1), (11,7)
ON CONFLICT DO NOTHING;

INSERT INTO Ad_Injection (playback_id, ad_id, trigger_time) VALUES
(1,1,'2026-04-01 08:32:00'), (3,2,'2026-04-02 09:02:00'), (1, 4, '2026-04-18 09:00:00'), (3, 5, '2026-04-18 10:00:00'), (4, 6, '2026-04-18 10:05:00'),
(21, 7, '2026-04-18 10:10:00'), (22, 8, '2026-04-18 10:15:00'), (23, 9, '2026-04-18 10:20:00'), (24, 4, '2026-04-18 10:25:00'),
(25, 5, '2026-04-18 18:00:00'), (26, 6, '2026-04-18 18:05:00'), (27, 7, '2026-04-18 18:10:00'), (1001,10,NOW()), (1002,11,NOW()),
(9003,4,'2026-04-18 10:30:00'), (9004,5,'2026-04-18 13:00:00'), (9005,6,'2026-04-18 15:30:00'), (9006,7,'2026-04-18 18:00:00'), (9007,8,'2026-04-18 20:30:00')
ON CONFLICT DO NOTHING;
