CREATE TABLE `User` (
  `id` integer PRIMARY KEY,
  `name` varchar(255),
  `email` varchar(255),
  `hashed_password` varchar(255),
  `profilePic_path` varchar(255),
  `quests` integer,
  `travels` integer,
  `score` integer,
  `league` integer,
  `created_at` date
);

CREATE TABLE `League` (
  `id` integer PRIMARY KEY,
  `name` varchar(255),
  `maxScore` integer,
  `minScore` integer
);

CREATE TABLE `Friend` (
  `user_id` integer,
  `friend_id` integer,
  `created_at` date,
  PRIMARY KEY (`user_id`, `friend_id`)
);

CREATE TABLE `Travel` (
  `id` integer PRIMARY KEY,
  `origin` integer,
  `destination` integer,
  `quest` integer,
  `completed` boolean,
  `datetime_arrive` datetime,
  `datetime_salida` datetime
);

CREATE TABLE `Station` (
  `id` integer PRIMARY KEY,
  `station_id` integer,
  `line_id` integer,
  `lat` float,
  `lon` float,
  `name` varchar(255)
);

CREATE TABLE `User_Travel` (
  `id` integer PRIMARY KEY,
  `travel` integer,
  `user` integer
);

CREATE TABLE `User_Quest` (
  `id` integer PRIMARY KEY,
  `quest` integer,
  `user` integer
);

CREATE TABLE `Quest` (
  `id` integer PRIMARY KEY,
  `description` varchar(255),
  `score` integer,
  `completed` boolean
);

CREATE TABLE `DailyQuest` (
  `id` integer PRIMARY KEY,
  `quest` integer
);

ALTER TABLE `User` ADD FOREIGN KEY (`league`) REFERENCES `League` (`id`);

ALTER TABLE `User` ADD FOREIGN KEY (`id`) REFERENCES `Friend` (`user_id`);

ALTER TABLE `Friend` ADD FOREIGN KEY (`friend_id`) REFERENCES `User` (`id`);

ALTER TABLE `Quest` ADD FOREIGN KEY (`id`) REFERENCES `Travel` (`quest`);

CREATE TABLE `Travel_Station` (
  `Travel_origin` integer,
  `Station_id` integer,
  PRIMARY KEY (`Travel_origin`, `Station_id`)
);

ALTER TABLE `Travel_Station` ADD FOREIGN KEY (`Travel_origin`) REFERENCES `Travel` (`origin`);

ALTER TABLE `Travel_Station` ADD FOREIGN KEY (`Station_id`) REFERENCES `Station` (`id`);


CREATE TABLE `Travel_Station(1)` (
  `Travel_destination` integer,
  `Station_id` integer,
  PRIMARY KEY (`Travel_destination`, `Station_id`)
);

ALTER TABLE `Travel_Station(1)` ADD FOREIGN KEY (`Travel_destination`) REFERENCES `Travel` (`destination`);

ALTER TABLE `Travel_Station(1)` ADD FOREIGN KEY (`Station_id`) REFERENCES `Station` (`id`);


CREATE TABLE `User_Travel_Travel` (
  `User_Travel_travel` integer,
  `Travel_id` integer,
  PRIMARY KEY (`User_Travel_travel`, `Travel_id`)
);

ALTER TABLE `User_Travel_Travel` ADD FOREIGN KEY (`User_Travel_travel`) REFERENCES `User_Travel` (`travel`);

ALTER TABLE `User_Travel_Travel` ADD FOREIGN KEY (`Travel_id`) REFERENCES `Travel` (`id`);


CREATE TABLE `User_Travel_User` (
  `User_Travel_user` integer,
  `User_id` integer,
  PRIMARY KEY (`User_Travel_user`, `User_id`)
);

ALTER TABLE `User_Travel_User` ADD FOREIGN KEY (`User_Travel_user`) REFERENCES `User_Travel` (`user`);

ALTER TABLE `User_Travel_User` ADD FOREIGN KEY (`User_id`) REFERENCES `User` (`id`);


CREATE TABLE `User_Quest_Quest` (
  `User_Quest_quest` integer,
  `Quest_id` integer,
  PRIMARY KEY (`User_Quest_quest`, `Quest_id`)
);

ALTER TABLE `User_Quest_Quest` ADD FOREIGN KEY (`User_Quest_quest`) REFERENCES `User_Quest` (`quest`);

ALTER TABLE `User_Quest_Quest` ADD FOREIGN KEY (`Quest_id`) REFERENCES `Quest` (`id`);


CREATE TABLE `User_Quest_User` (
  `User_Quest_user` integer,
  `User_id` integer,
  PRIMARY KEY (`User_Quest_user`, `User_id`)
);

ALTER TABLE `User_Quest_User` ADD FOREIGN KEY (`User_Quest_user`) REFERENCES `User_Quest` (`user`);

ALTER TABLE `User_Quest_User` ADD FOREIGN KEY (`User_id`) REFERENCES `User` (`id`);


ALTER TABLE `DailyQuest` ADD FOREIGN KEY (`quest`) REFERENCES `Quest` (`id`);
