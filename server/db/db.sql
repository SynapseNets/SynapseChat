CREATE TABLE IF NOT EXISTS `users` (
    `id` varchar(36) NOT NULL,  -- UUID4 string for each user
    `username` varchar(20) NOT NULL,
    `password` varchar(30) NOT NULL
) PRIMARY KEY (`id`);

CREATE TABLE IF NOT EXISTS `groups` (
    `id` varchar(36) NOT NULL,  -- UUID4 string for each group
    `name` varchar(20) NOT NULL
) PRIMARY KEY (`id`);

CREATE TABLE IF NOT EXISTS `user_group` (
    `user_id` varchar(36) NOT NULL,
    `group_id` varchar(36) NOT NULL,
    `last_time` datetime NOT NULL,
) PRIMARY KEY (`user_id`, `group_id`);