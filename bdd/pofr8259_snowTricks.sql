-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : mar. 14 mai 2024 à 14:50
-- Version du serveur : 10.6.17-MariaDB
-- Version de PHP : 8.1.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `pofr8259_snowTricks`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Aerials / Airs'),
(2, 'Grabs'),
(3, 'Grinds / Slides'),
(4, 'Flips'),
(5, 'Spins'),
(6, 'Lip Tricks');

-- --------------------------------------------------------

--
-- Structure de la table `commentaire`
--

CREATE TABLE `commentaire` (
  `id` int(11) NOT NULL,
  `figure_id` int(11) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `author_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `commentaire`
--

INSERT INTO `commentaire` (`id`, `figure_id`, `content`, `created_at`, `author_id`, `user_id`) VALUES
(30, 111, 'Super merci !', '2023-11-07 15:26:02', 6, 0),
(31, 114, 'Super merci beaucoup !!!', '2023-11-16 08:49:11', 11, 0),
(36, 114, '<3', '2023-11-28 09:12:45', 6, 0),
(38, 109, 'Super !!!', '2023-11-28 09:42:39', 6, 0),
(39, 109, 'Bravo pour la figure :)', '2023-11-28 09:42:44', 6, 0);

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230912074236', '2023-09-12 07:42:53', 159),
('DoctrineMigrations\\Version20230913114457', '2023-09-13 11:45:08', 173),
('DoctrineMigrations\\Version20230917080753', '2023-09-17 08:08:03', 68),
('DoctrineMigrations\\Version20230919084941', '2023-09-19 08:50:00', 29),
('DoctrineMigrations\\Version20230919085220', '2023-09-19 08:52:26', 38),
('DoctrineMigrations\\Version20230919091121', '2023-09-19 09:11:26', 219),
('DoctrineMigrations\\Version20230919100227', '2023-09-19 10:02:33', 83),
('DoctrineMigrations\\Version20231003100528', '2023-10-03 10:05:58', 78),
('DoctrineMigrations\\Version20231003100716', '2023-10-03 10:07:20', 55),
('DoctrineMigrations\\Version20231003120136', '2023-10-03 12:01:40', 47),
('DoctrineMigrations\\Version20231003120220', '2023-10-03 12:02:26', 59),
('DoctrineMigrations\\Version20231003123323', '2023-10-03 12:33:28', 486),
('DoctrineMigrations\\Version20231003143437', '2023-10-03 14:34:42', 113),
('DoctrineMigrations\\Version20231009074748', '2023-10-09 07:48:05', 233),
('DoctrineMigrations\\Version20231009081831', '2023-10-09 08:18:40', 60),
('DoctrineMigrations\\Version20231009120159', '2023-10-09 12:02:04', 338),
('DoctrineMigrations\\Version20231024095358', '2023-10-24 09:54:08', 195),
('DoctrineMigrations\\Version20231025125638', '2023-11-07 13:30:48', 152),
('DoctrineMigrations\\Version20231115191624', '2023-11-15 19:16:32', 307),
('DoctrineMigrations\\Version20231125173049', '2023-11-25 17:38:38', 95);

-- --------------------------------------------------------

--
-- Structure de la table `figure`
--

CREATE TABLE `figure` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  `categories_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `slug` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `figure`
--

INSERT INTO `figure` (`id`, `name`, `description`, `created_at`, `updated_at`, `categories_id`, `user_id`, `slug`) VALUES
(109, 'Ollie', 'Le \"Ollie\" est une figure fondamentale en skateboard qui a été inventée par Alan \"Ollie\" Gelfand dans les années 1970. C\'est une manœuvre qui permet au skateur et à sa planche de décoller du sol sans que les mains ne touchent la planche . Voici comment cela se déroule :\r\n\r\nLe skateur commence en position debout sur sa planche, les pieds positionnés de manière spécifique : le pied arrière sur la queue (arrière) de la planche et le pied avant vers le milieu.\r\n\r\nPour initier l\'Ollie, le skateur cale le pied arrière sur le bord de la file d\'attente et pousse vers le bas avec force, ce qui crée une impulsion qui fait basculer la planche vers le haut.\r\n\r\nAlors que la file d\'attente frappe le sol, le skateur saute vers le haut, permettant à ses pieds de rester en contact avec la planche grâce à l\'adhérence de ses chaussures.\r\n\r\nPendant qu\'il est en l\'air, le skateur utilise son pied avant pour niveler la planche sous ses pieds. Cette action est souvent réalisée en glissant le pied avant vers l\'avant de la planche pour l\'élever à une hauteur uniforme.\r\n\r\nLa planche est alors en position horizontale sous le skateur alors qu\'il est en l\'air.\r\n\r\nFinalement, le skateur atterrit généralement d\'abord sur les roues avant, suivi rapidement par les roues arrière, et plie les genoux pour absorber l\'impact.\r\n\r\nLe Ollie est la base de nombreuses autres figures de skateboard car il est souvent le premier pas pour apprendre à faire décoller la planche du sol et à réaliser des manœuvres en l\'air.', '2023-11-07 13:44:43', '2023-12-04 19:09:19', 1, 7, 'ollie'),
(110, 'Air to Fakie', 'L\'Air to Fakie est une figure de skateboard et de snowboard assez avancée qui combine des éléments d\'aériens et de transition. Voici une description de la figure dans le contexte du snowboard :\r\n\r\nApproche: Le snowboarder commence par prendre de la vitesse en direction d\'un half-pipe ou d\'une rampe.\r\n\r\nDécollage: En arrivant au sommet de la rampe, le snowboarder utilise l\'élan pour décoller en l\'air, sans rotation initiale. Le terme \"air\" fait référence à cette phase où le snowboarder et la planche sont en l\'air.\r\n\r\nManœuvre: Une fois en l\'air, le snowboarder doit gérer son équilibre et sa position. Contrairement à d\'autres figures aériennes, l\'Air to Fakie se caractérise par l\'absence de rotation complète. Le snowboarder doit rester orienté dans la même direction qu\'il avait lors du décollage.\r\n\r\nAtterrissage: L\'atterrissage se fait en arrière ou \"fakie\", ce qui signifie que le snowboarder atterrit dans la direction opposée à celle de l\'approche, sans avoir changé l\'orientation de son corps ou de la planche pendant le saut.\r\n\r\nSortie: Après l\'atterrissage, le snowboarder continue de glisser en arrière jusqu\'à la prochaine manœuvre ou jusqu\'à ce qu\'il reprenne sa position normale.\r\n\r\nLe terme \"fakie\" fait référence à la position et à la direction de la glisse du snowboarder après l\'atterrissage, où l\'avant et l\'arrière de la planche sont inversés par rapport à la direction habituelle de descente. C\'est une figure qui demande une bonne maîtrise de l\'équilibre et du contrôle de la planche en l\'air, ainsi que la capacité à atterrir et à continuer à glisser dans une posture qui n\'est pas naturelle.', '2023-11-07 14:02:56', '2023-12-04 13:22:29', 1, 7, 'air-to-fakie'),
(111, 'McTwis', 'Le \"McTwist\" est une figure avancée de skateboard et de snowboard qui implique un flip arrière (backflip) et une rotation de 540 degrés. Voici une description de la manœuvre dans le contexte du snowboard :\r\n\r\nApproche: Le snowboarder commence par gagner de la vitesse en direction d\'un half-pipe ou d\'une grande rampe.\r\n\r\nDécollage: En arrivant au sommet de la rampe, le snowboarder décolle en l\'air avec un angle qui favorise la rotation.\r\n\r\nManœuvre en l\'air: Une fois en l\'air, le snowboarder lance un backflip (salto arrière) tout en commençant une rotation horizontale. Le mélange du flip et de la rotation crée la dynamique complexe du McTwist.\r\n\r\nRotation: La rotation totale est de 540 degrés, ce qui signifie que le snowboarder effectue une rotation d\'une fois et demie autour de son axe vertical en plus du backflip.\r\n\r\nAtterrissage: L\'atterrissage doit être bien chronométré, le snowboarder devant repérer la rampe pour atterrir sur la transition en descente. Il doit atterrir avec sa planche parallèle à la pente pour maintenir son élan et sa stabilité.\r\n\r\nSortie: Après un atterrissage réussi, le snowboarder continue à glisser dans le half-pipe pour se préparer à la prochaine figure.\r\n\r\nLe McTwist est souvent considéré comme l\'une des figures les plus spectaculaires et difficiles en raison de la combinaison du flip et de la rotation. Elle a été popularisée dans le skateboard par Mike McGill et a ensuite été adaptée au snowboard où elle nécessite une grande maîtrise aérienne et une conscience spatiale aiguë.', '2023-11-07 14:05:20', '2023-12-04 13:27:30', 1, 7, 'mctwis'),
(114, 'Indy Grab', 'L\'Indy Grab est une figure classique en skateboard, snowboard, et dans les sports freestyle similaires. Voici une description de la figure pour le skateboard :\r\n\r\nPréparation : Le skateur prend de la vitesse en direction de la rampe ou du tremplin d\'où il va décoller.\r\n\r\nDécollage : En arrivant sur le bord de la rampe, le skateur effectue un Ollie pour s\'envoler en l\'air. La hauteur de l\'Ollie dépend de la vitesse et de la force avec laquelle le skateur a frappé la rampe.\r\n\r\nSaisie : Une fois en l\'air, le skateur tend la main vers le bas et saisit la planche du côté droit entre ses pieds avec sa main arrière (pour un skateur régulier, ce serait la main droite). Cette action est l\'élément clé de l\'Indy Grab.\r\n\r\nStabilisation : La saisie de la planche aide à stabiliser la planche en l\'air et permet au skateur de maintenir le contrôle pendant le vol.\r\n\r\nAtterrissage : Le skateur relâche la planche avant d\'atterrir, s\'assurant que les quatre roues touchent la surface simultanément. Les genoux doivent être fléchis pour absorber l\'impact.\r\n\r\nContinuation : Après un atterrissage réussi, le skateur continue à rouler, prêt pour la prochaine figure ou pour sortir de la rampe.\r\n\r\nC\'est une figure relativement simple par rapport à d\'autres manœuvres aériennes, mais elle requiert une bonne coordination et le sens du timing pour synchroniser le saut, la saisie, et l\'atterrissage. En compétition ou en démonstration, les juges peuvent noter la figure sur l\'amplitude, la durée de la saisie, et la propreté de l\'exécution.', '2023-11-10 12:44:30', '2023-11-28 10:25:33', 2, 6, 'indy-grab'),
(117, 'Boardslide', 'Un \"Boardslide\" est une figure de snowboard qui implique le glissement de la planche le long d\'un rail ou d\'un obstacle avec la base du snowboard (la partie inférieure) perpendiculaire à la surface de l\'obstacle. Voici une description détaillée de la figure :\r\n\r\nPosition de départ : Le rider commence par approcher l\'obstacle, généralement un rail métallique ou un rebord enneigé, avec suffisamment de vitesse pour maintenir l\'équilibre pendant la figure. Les pieds sont attachés à la planche à l\'aide de fixations, et le snowboarder se tient en position de conduite, avec les épaules perpendiculaires à l\'obstacle.\r\n\r\nEngagement : À l\'approche de l\'obstacle, le snowboarder saute et tourne son corps pour que la base du snowboard soit parallèle à la surface de l\'obstacle. Cela signifie que la planche sera perpendiculaire à la direction du mouvement.\r\n\r\nVerrouillage : Une fois en l\'air, le rider cherche à verrouiller la planche sur le rail ou le rebord. Cela implique de positionner le snowboard de manière à ce que les bords en métal de la planche (les carres) soient en contact avec la surface de l\'obstacle. Il faut également veiller à maintenir l\'équilibre sur toute la longueur de l\'obstacle.\r\n\r\nGlissement : Une fois verrouillée, la planche glisse le long de l\'obstacle avec fluidité. Le snowboarder doit ajuster son poids et son équilibre pour maintenir une ligne propre et stable tout au long du boardslide.\r\n\r\nSortie : Pour sortir du boardslide, le snowboarder peut effectuer une petite impulsion ou un mouvement de torsion avec les épaules pour libérer la planche de l\'obstacle. Une fois détaché, le rider peut atterrir en douceur sur la neige ou continuer avec d\'autres tricks ou figures.\r\n\r\nLe boardslide est une figure de base en snowboard, mais il peut être effectué avec style et créativité en fonction de la manière dont le rider choisit de l\'exécuter. Il nécessite une bonne maîtrise de l\'équilibre, de la technique et de la coordination, et il est souvent utilisé comme composant de figures plus complexes dans le snowboard freestyle.', '2023-12-05 17:32:08', NULL, 3, 6, 'boardslide'),
(118, 'Backflip', 'Un \"Backflip\" en snowboard est une figure acrobatique qui implique que le snowboarder effectue une rotation arrière complète en l\'air tout en restant attaché à sa planche. Voici une description détaillée de la figure :\r\n\r\nPosition de départ : Le snowboarder commence par prendre de la vitesse sur une pente ou un saut spécialement conçu pour les tricks aériens. Les pieds sont solidement fixés à la planche avec des fixations. Le snowboarder se tient en position de conduite, prêt à prendre de l\'élan.\r\n\r\nPréparation : À l\'approche du saut ou de la bosse, le snowboarder plie les genoux pour gagner de la souplesse et de la flexibilité, prêt à s\'engager dans la rotation.\r\n\r\nLancement : Au moment de lancer le backflip, le snowboarder utilise son impulsion pour sauter en l\'air. Il faut pousser avec les jambes et incliner le corps vers l\'arrière tout en gardant le regard vers l\'avant pour maintenir l\'équilibre.\r\n\r\nRotation : Pendant le vol, le snowboarder effectue une rotation arrière complète de 360 degrés autour de l\'axe longitudinal de la planche. Cela signifie que la planche tourne autour de sa longueur, de manière à revenir en position de départ une fois la rotation terminée.\r\n\r\nPosition groupée : Pour effectuer un backflip propre, le snowboarder ramène les genoux vers la poitrine en position groupée pendant la rotation. Cela permet de tourner plus rapidement et de maintenir le contrôle.\r\n\r\nAterrisage : Après avoir effectué la rotation complète, le snowboarder prépare son atterrissage en étendant les jambes pour amortir le choc. Il vise à atterrir en douceur sur la neige, en pliant les genoux pour absorber l\'impact.\r\n\r\nÉquilibre : Une fois l\'atterrissage réussi, le snowboarder rétablit son équilibre et continue à rider sur la pente ou à exécuter d\'autres figures si nécessaire.\r\n\r\nLe backflip en snowboard est une figure extrêmement acrobatique et exigeante qui nécessite une grande maîtrise de l\'équilibre, de la technique et du courage. Il est généralement réservé aux riders expérimentés et est souvent réalisé dans des parcs à neige ou sur des pistes spécialement conçues pour les sauts acrobatiques. Il est important de s\'entraîner en toute sécurité et sous la supervision de professionnels avant d\'essayer des figures aussi avancées.', '2023-12-05 18:10:37', NULL, 4, 6, 'backflip'),
(119, 'Blunt to Fakie', 'La figure de snowboard \"Blunt to Fakie\" est un trick qui se déroule sur un rail ou un obstacle similaire. Elle consiste à glisser la planche sur l\'obstacle avec la partie arrière de la planche (le tail) au-dessus de l\'obstacle et la partie avant de la planche (le nose) pointée vers l\'arrière. Voici une description détaillée de cette figure :\r\n\r\nPosition de départ : Le snowboarder approche de l\'obstacle (généralement un rail ou un rebord enneigé) avec suffisamment de vitesse pour maintenir l\'équilibre pendant la figure. Les pieds sont solidement attachés à la planche à l\'aide de fixations, et le snowboarder se tient en position de conduite avec les épaules perpendiculaires à l\'obstacle.\r\n\r\nEngagement : En approchant l\'obstacle, le snowboarder saute pour monter sur l\'obstacle avec la partie arrière de la planche (le tail) en premier. Cela signifie que le rider va glisser sur l\'obstacle avec le nose pointé vers l\'arrière.\r\n\r\nVerrouillage : Une fois sur l\'obstacle, le snowboarder doit verrouiller la planche en place. Cela implique de maintenir la pression sur la partie arrière de la planche tout en gardant le nose hors de l\'obstacle. Les genoux sont généralement fléchis pour maintenir l\'équilibre.\r\n\r\nGlissement : Avec la planche verrouillée en position \"Blunt,\" le snowboarder glisse le long de l\'obstacle. La stabilité et l\'équilibre sont essentiels pour maintenir une ligne propre et contrôlée tout au long du Blunt.\r\n\r\nSortie : Pour sortir du Blunt, le snowboarder doit généralement effectuer une petite impulsion ou un mouvement de torsion avec les épaules pour libérer la planche de l\'obstacle. Le rider peut ensuite atterrir en douceur sur la neige ou continuer avec d\'autres tricks ou figures.\r\n\r\nLe Blunt to Fakie est une figure avancée en snowboard qui exige une bonne maîtrise de l\'équilibre, de la technique et de la précision. Le \"Fakie\" dans le nom signifie que le rider sort de la figure en se retrouvant en position de conduite avec le nose pointé vers l\'arrière, ce qui ajoute une certaine difficulté à la manœuvre. Comme pour toutes les figures en snowboard, il est important de s\'entraîner en toute sécurité et sous la supervision de professionnels avant d\'essayer des tricks avancés comme le Blunt to Fakie.', '2023-12-05 18:28:09', '2023-12-05 18:28:27', 6, 6, 'blunt-to-fakie');

-- --------------------------------------------------------

--
-- Structure de la table `image`
--

CREATE TABLE `image` (
  `id` int(11) NOT NULL,
  `figure_id` int(11) DEFAULT NULL,
  `filename` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `image`
--

INSERT INTO `image` (`id`, `figure_id`, `filename`) VALUES
(156, NULL, '59b1936a0996b0a22adb3d42be5f6b08.png'),
(157, NULL, NULL),
(158, NULL, '29a5a8d3550c7df33a934811e58690cc.png'),
(162, NULL, '64891d2a6c5e07cc7b318d9991be7cbc.png'),
(165, NULL, '003c4f94bac280e35d461cb444632bc9.png'),
(166, NULL, NULL),
(173, NULL, 'fe3fb06934ec566cca2af07f3f084e45.png'),
(174, NULL, '8e7135853bee54c53ab76e292472c779.png'),
(175, NULL, '9badec120a7b0d087b5232f0e2e6d830.png'),
(176, NULL, 'e24dcea89332c6f8b66b36c473377e46.png'),
(177, NULL, NULL),
(178, NULL, '07e2cfdb306a43ddaf23d15b1bb25de7.png'),
(179, NULL, NULL),
(180, NULL, '72c9d6ba30000b671404ce77d6e716d6.png'),
(181, NULL, 'd03853d513b5c7a18ba65fe10b6537f5.png'),
(182, NULL, 'e2907705ab7196cd22734e0512a8e612.png'),
(183, NULL, 'd62fbe66526a171aed0abd824ea9eabc.png'),
(184, NULL, 'a8d089e0dde8c968b1c4a37fc7f2a254.png'),
(189, NULL, NULL),
(190, 109, '24e842af65e08aa022e1a69fb6d60952.webp'),
(191, 109, '3f44bee306a3bbe9ccce8fd39e345cdc.webp'),
(192, 110, '4c9675ce68d6eccd35ce2fda26c2832f.webp'),
(193, 110, 'f006edf6cb06b2bb923b84a2910335f1.webp'),
(194, 111, '54c35e832dddb73cf80767115c3fe0c6.webp'),
(195, 111, '090f3c967b888800dc959a0fe7f3a455.webp'),
(196, NULL, 'e292f0832f6418c683c7ad71ee2fbc3a.webp'),
(197, NULL, '1557bf1f85cd48f64f66f570bd63a227.webp'),
(198, 109, 'b48f3ca1fc3348296f11b0196e81bb0c.webp'),
(199, 109, '63a4932aeee724ed25dd986c27e33d70.webp'),
(204, 114, 'bdbf5b487285b88afa3469e2c8911558.webp'),
(205, NULL, 'f49d768da4c2c4380d98ba6b44732e7f.webp'),
(206, NULL, '43ebc552f560d935bc32bdcdd56a5c60.webp'),
(207, NULL, '8f99fe60551bda37dd124903341be000.webp'),
(210, NULL, '15154bf462e0a213b3ddf552167cb5f6.webp'),
(211, NULL, '02cf3581d5fa2710935fe7d796ba4767.png'),
(212, NULL, '12937e2879e879d7593f57286ab0a5dc.png'),
(213, NULL, '25b13c3758a3fe4afbfad058338e9663.webp'),
(214, 114, '2c77c7663a93dbebe3f77adb05c2d0d9.webp'),
(215, 114, '3c623bbe3a8b856187e3cd8e10702cd7.webp'),
(216, NULL, NULL),
(217, NULL, NULL),
(218, NULL, NULL),
(219, NULL, NULL),
(220, 114, 'cba6366da54da66f1d1a5a01d9c9776a.webp'),
(221, 110, 'efce5fa2e9a80adc0e655e246612a5ea.webp'),
(222, 110, '091fe4903cb483de69c99d1cb81dac68.webp'),
(223, 111, 'fade8e3297151becf3667e69d918085d.webp'),
(224, 111, '594c54a3935741ad17b2746650b99f3a.webp'),
(225, NULL, 'c7fc3ad23a7f365299c60ed095920878.webp'),
(226, 117, '89324dc5413acfe05ad0c8a63405532f.webp'),
(227, 117, '5a27b218e84eb1554c44fffed0d8f408.webp'),
(228, 117, 'c94c4563699e75906e7084db400dfbd3.webp'),
(229, 117, '6cea054cfa69741e6fba32dc85a03299.webp'),
(230, 118, '29ce64409d2100d610298474e7adaed1.webp'),
(231, 118, '2da166489e50490b5297b56978a55f92.webp'),
(232, 118, 'b3a7268b6de9e9e59ab9f9d584c54b60.webp'),
(233, 118, '3c76b2a10dcbd46876cec3e74fd3d108.webp'),
(234, 119, 'd8673db6038cdc0581318a66c73663d2.webp'),
(235, 119, '830edd81954219a0fdc5b1abcdaedaf9.webp'),
(236, 119, 'e2947f7735ba7345b25ebcf67a1677ee.webp'),
(237, 119, 'ab65a39d2a407b3d435a8470f3853ad8.webp');

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `messenger_messages`
--

INSERT INTO `messenger_messages` (`id`, `body`, `headers`, `queue_name`, `created_at`, `available_at`, `delivered_at`) VALUES
(1, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":4:{i:0;s:41:\\\"registration/confirmation_email.html.twig\\\";i:1;N;i:2;a:3:{s:9:\\\"signedUrl\\\";s:172:\\\"http://127.0.0.1:8000/verify/email?expires=1694508317&id=1&signature=RSAa6LNWaD93LFydprooe%2BQ2aprmsUVel17aLuTuNp8%3D&token=rxLxtgWPrN6cSqWX1skHqlc%2Bj2nIbD9qpcvIE86VfAs%3D\\\";s:19:\\\"expiresAtMessageKey\\\";s:26:\\\"%count% hour|%count% hours\\\";s:20:\\\"expiresAtMessageData\\\";a:1:{s:7:\\\"%count%\\\";i:1;}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:31:\\\"contact@snowtricks.fportemer.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:28:\\\"Confirmation de votre compte\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:22:\\\"synapsefred@hotmail.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:25:\\\"Please Confirm your Email\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2023-09-12 07:45:17', '2023-09-12 07:45:17', NULL),
(2, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":4:{i:0;s:41:\\\"registration/confirmation_email.html.twig\\\";i:1;N;i:2;a:3:{s:9:\\\"signedUrl\\\";s:172:\\\"http://127.0.0.1:8000/verify/email?expires=1694508464&id=2&signature=ZJsoRxCxBGC0oIBmxo8%2FT0sVWYj5tvlJKFgMgYamRR0%3D&token=mZ6HoYQcs74SVZJJh8DE6TKkD5FB3a9%2B7EeYXifUlT4%3D\\\";s:19:\\\"expiresAtMessageKey\\\";s:26:\\\"%count% hour|%count% hours\\\";s:20:\\\"expiresAtMessageData\\\";a:1:{s:7:\\\"%count%\\\";i:1;}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:31:\\\"contact@snowtricks.fportemer.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:28:\\\"Confirmation de votre compte\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:22:\\\"synapsefred@hotmail.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:25:\\\"Please Confirm your Email\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2023-09-12 07:47:44', '2023-09-12 07:47:44', NULL),
(3, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":4:{i:0;s:41:\\\"registration/confirmation_email.html.twig\\\";i:1;N;i:2;a:3:{s:9:\\\"signedUrl\\\";s:178:\\\"http://127.0.0.1:8000/verify/email?expires=1694508530&id=3&signature=ESRZHDuNpRq74EjsPFBvcLYxd7W7DhfsFOk1I8Oc5r4%3D&token=6SKrvfLa%2F6ORICu%2F%2F6Q248GkEaZwY5GQA%2BWIfY3%2Fjwk%3D\\\";s:19:\\\"expiresAtMessageKey\\\";s:26:\\\"%count% hour|%count% hours\\\";s:20:\\\"expiresAtMessageData\\\";a:1:{s:7:\\\"%count%\\\";i:1;}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:31:\\\"contact@snowtricks.fportemer.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:28:\\\"Confirmation de votre compte\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:22:\\\"synapsefred@hotmail.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:25:\\\"Please Confirm your Email\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2023-09-12 07:48:50', '2023-09-12 07:48:50', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `reset_password_request`
--

CREATE TABLE `reset_password_request` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `selector` varchar(20) NOT NULL,
  `hashed_token` varchar(100) NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(180) NOT NULL,
  `roles` longtext NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `username` varchar(255) NOT NULL,
  `validation_token` varchar(64) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `roles`, `password`, `is_verified`, `username`, `validation_token`, `profile_picture`) VALUES
(6, 'synapsefred@hotmail.fr', '[]', '$2y$13$9.TfoHQ3ERBCvqoVH6F0AOyy4512gAD8qN9g50mqOuFvru2Pce6tq', 1, 'Pedro', NULL, 'photo-profil-6564f988555f4.webp'),
(7, 'michel@hotmail.fr', '[]', '$2y$13$lj/oo6xkj4nexxxOu/CB5ey0FshPup6Fsbbi9A4qf2FQIVNs4e4SG', 0, 'Michel', NULL, 'photo-profil-michel-656f6e1d032d4.webp'),
(11, 'vedayshop@netcourrier.com', '[]', '$2y$13$8vCBcaW10xChj6kDY.AvFOiyzGUpkh1eJXoZGCANa/C7cla5kDZy2', 1, 'José', NULL, NULL),
(12, 'synapsefrfdfded@hotmail.fr', '[]', '$2y$13$nMKnT6kCwMKNVGm9Vy5pAextbF0JHsdLYh4dWLKRb8z/dPeZOZFzO', 0, 'Eric', 'c2c024b245f6e5981ce3df2c820de4d65293b89f29c0c413404a9551402008f1', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `video`
--

CREATE TABLE `video` (
  `id` int(11) NOT NULL,
  `figure_id` int(11) DEFAULT NULL,
  `video_link` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `video`
--

INSERT INTO `video` (`id`, `figure_id`, `video_link`) VALUES
(22, NULL, 'https://www.youtube.com/embed/WVdZlY6jN2Y?si=SQduG9pjxzFLyiPU'),
(23, NULL, 'https://www.youtube.com/embed/WVdZlY6jN2Y?si=SQduG9pjxzFLyiPU'),
(24, 111, 'https://www.youtube.com/embed/hgy-Ff2DS6Y?si=AW5YanmNAm3gyuNc'),
(25, 109, 'https://www.youtube.com/embed/AnI7qGQs0Ic?si=Y-ZWY6cgcXGA8hz0'),
(29, NULL, 'https://www.youtube.com/watch?v=6fkUpmHNVOM'),
(30, NULL, 'https://www.youtube.com/watch?v=6fkUpmHNVOM'),
(31, NULL, NULL),
(32, NULL, 'fdfdfdsfdsfdsfdsf'),
(33, NULL, NULL),
(34, NULL, NULL),
(35, 114, 'https://www.youtube.com/embed/6yA3XqjTh_w?si=m1aWhBXvrAkqz_RY'),
(36, 110, 'https://www.youtube.com/embed/2fP_R0tXFAc?si=rOKR7U7-n9aODJoe'),
(37, 117, 'https://www.youtube.com/embed/R3OG9rNDIcs?si=H2r37POuasAmuqX7'),
(38, 118, 'https://www.youtube.com/embed/0sehBOkD01Q?si=SayFUtSh8j--X2AL'),
(39, 119, 'https://www.youtube.com/embed/6UYe5ibyq54?si=Z9AoQIP14LmjFESh'),
(40, 119, NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_67F068BC5C011B5` (`figure_id`),
  ADD KEY `IDX_67F068BCF675F31B` (`author_id`);

--
-- Index pour la table `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Index pour la table `figure`
--
ALTER TABLE `figure`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_2F57B37A989D9B62` (`slug`),
  ADD KEY `IDX_2F57B37AA21214B7` (`categories_id`),
  ADD KEY `IDX_2F57B37AA76ED395` (`user_id`);

--
-- Index pour la table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C53D045F5C011B5` (`figure_id`);

--
-- Index pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Index pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7CE748AA76ED395` (`user_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- Index pour la table `video`
--
ALTER TABLE `video`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7CC7DA2C5C011B5` (`figure_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `commentaire`
--
ALTER TABLE `commentaire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT pour la table `figure`
--
ALTER TABLE `figure`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=120;

--
-- AUTO_INCREMENT pour la table `image`
--
ALTER TABLE `image`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=238;

--
-- AUTO_INCREMENT pour la table `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `video`
--
ALTER TABLE `video`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commentaire`
--
ALTER TABLE `commentaire`
  ADD CONSTRAINT `FK_67F068BC5C011B5` FOREIGN KEY (`figure_id`) REFERENCES `figure` (`id`),
  ADD CONSTRAINT `FK_67F068BCF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `figure`
--
ALTER TABLE `figure`
  ADD CONSTRAINT `FK_2F57B37AA21214B7` FOREIGN KEY (`categories_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `FK_2F57B37AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `image`
--
ALTER TABLE `image`
  ADD CONSTRAINT `FK_C53D045F5C011B5` FOREIGN KEY (`figure_id`) REFERENCES `figure` (`id`);

--
-- Contraintes pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `video`
--
ALTER TABLE `video`
  ADD CONSTRAINT `FK_7CC7DA2C5C011B5` FOREIGN KEY (`figure_id`) REFERENCES `figure` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
