CREATE TABLE IF NOT EXISTS `users` (
    `id` varchar(36) NOT NULL,  -- UUID4 string for each user
    `username` varchar(20) NOT NULL,
    `password` varchar(30) NOT NULL
) PRIMARY KEY (`id`);