-- phpMyAdmin SQL Dump
-- version 5.1.1deb5ubuntu1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 01-04-2025 a las 16:57:20
-- Versión del servidor: 8.0.41-0ubuntu0.22.04.1
-- Versión de PHP: 8.1.2-1ubuntu2.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tenfe`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `DailyQuest`
--

CREATE TABLE `DailyQuest` (
  `id` int NOT NULL,
  `quest` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Friend`
--

CREATE TABLE `Friend` (
  `user_id` int NOT NULL,
  `friend_id` int NOT NULL,
  `created_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `League`
--

CREATE TABLE `League` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `maxScore` int DEFAULT NULL,
  `minScore` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Quest`
--

CREATE TABLE `Quest` (
  `id` int NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `score` int DEFAULT NULL,
  `completed` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Station`
--

CREATE TABLE `Station` (
  `id` int NOT NULL,
  `station_id` int DEFAULT NULL,
  `line_id` int DEFAULT NULL,
  `lat` float DEFAULT NULL,
  `lon` float DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Travel`
--

CREATE TABLE `Travel` (
  `id` int NOT NULL,
  `origin` int DEFAULT NULL,
  `destination` int DEFAULT NULL,
  `quest` int DEFAULT NULL,
  `completed` tinyint(1) DEFAULT NULL,
  `datetime_arrive` datetime DEFAULT NULL,
  `datetime_salida` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User`
--

CREATE TABLE `User` (
  `id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `hashed_password` varchar(255) DEFAULT NULL,
  `profilePic_path` varchar(255) DEFAULT NULL,
  `quests` int DEFAULT NULL,
  `travels` int DEFAULT NULL,
  `score` int DEFAULT NULL,
  `league` int DEFAULT NULL,
  `created_at` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User_Quest`
--

CREATE TABLE `User_Quest` (
  `id` int NOT NULL,
  `quest` int DEFAULT NULL,
  `user` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User_Travel`
--

CREATE TABLE `User_Travel` (
  `id` int NOT NULL,
  `travel` int DEFAULT NULL,
  `user` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `DailyQuest`
--
ALTER TABLE `DailyQuest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quest` (`quest`);

--
-- Indices de la tabla `Friend`
--
ALTER TABLE `Friend`
  ADD PRIMARY KEY (`user_id`,`friend_id`),
  ADD KEY `friend_id` (`friend_id`);

--
-- Indices de la tabla `League`
--
ALTER TABLE `League`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `Quest`
--
ALTER TABLE `Quest`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `Station`
--
ALTER TABLE `Station`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `Travel`
--
ALTER TABLE `Travel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quest` (`quest`),
  ADD KEY `origin` (`origin`),
  ADD KEY `destination` (`destination`);

--
-- Indices de la tabla `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id`),
  ADD KEY `league` (`league`);

--
-- Indices de la tabla `User_Quest`
--
ALTER TABLE `User_Quest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quest` (`quest`),
  ADD KEY `user` (`user`);

--
-- Indices de la tabla `User_Travel`
--
ALTER TABLE `User_Travel`
  ADD PRIMARY KEY (`id`),
  ADD KEY `travel` (`travel`),
  ADD KEY `user` (`user`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `DailyQuest`
--
ALTER TABLE `DailyQuest`
  ADD CONSTRAINT `DailyQuest_ibfk_1` FOREIGN KEY (`quest`) REFERENCES `Quest` (`id`);

--
-- Filtros para la tabla `Friend`
--
ALTER TABLE `Friend`
  ADD CONSTRAINT `Friend_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`),
  ADD CONSTRAINT `Friend_ibfk_2` FOREIGN KEY (`friend_id`) REFERENCES `User` (`id`);

--
-- Filtros para la tabla `Travel`
--
ALTER TABLE `Travel`
  ADD CONSTRAINT `Travel_ibfk_1` FOREIGN KEY (`quest`) REFERENCES `Quest` (`id`),
  ADD CONSTRAINT `Travel_ibfk_2` FOREIGN KEY (`origin`) REFERENCES `Station` (`id`),
  ADD CONSTRAINT `Travel_ibfk_3` FOREIGN KEY (`destination`) REFERENCES `Station` (`id`);

--
-- Filtros para la tabla `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `User_ibfk_1` FOREIGN KEY (`league`) REFERENCES `League` (`id`);

--
-- Filtros para la tabla `User_Quest`
--
ALTER TABLE `User_Quest`
  ADD CONSTRAINT `User_Quest_ibfk_1` FOREIGN KEY (`quest`) REFERENCES `Quest` (`id`),
  ADD CONSTRAINT `User_Quest_ibfk_2` FOREIGN KEY (`user`) REFERENCES `User` (`id`);

--
-- Filtros para la tabla `User_Travel`
--
ALTER TABLE `User_Travel`
  ADD CONSTRAINT `User_Travel_ibfk_1` FOREIGN KEY (`travel`) REFERENCES `Travel` (`id`),
  ADD CONSTRAINT `User_Travel_ibfk_2` FOREIGN KEY (`user`) REFERENCES `User` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
