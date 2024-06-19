CREATE TABLE IF NOT EXISTS `users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` varchar(20) NOT NULL,
    `password` varchar(64) NOT NULL -- hex sha256 hash of password
) PRIMARY KEY (`id`);

CREATE TABLE IF NOT EXISTS `groups` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `name` varchar(20) NOT NULL
) PRIMARY KEY (`id`);

CREATE TABLE IF NOT EXISTS `user_group` (
    `user_id` INT NOT NULL,
    `group_id` INT NOT NULL,
    `last_time` datetime NOT NULL, -- last time user was online
) PRIMARY KEY (`user_id`, `group_id`);