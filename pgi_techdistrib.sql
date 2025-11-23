-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 23, 2025 at 10:20 PM
-- Server version: 8.0.44
-- PHP Version: 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pgi_techdistrib`
--

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `id` int NOT NULL,
  `nom` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telephone` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `adresse` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`id`, `nom`, `email`, `telephone`, `adresse`) VALUES
(1, 'Lisa', 'sam@gmail.com', '0734534567', 'Paris 15'),
(3, 'Sam', 'jamai@gmail.com', '0734534567', 'Paris'),
(5, 'Nadine', 'nadine@gmail.com', '06 59 72 11 03', 'paris');

-- --------------------------------------------------------

--
-- Table structure for table `commandes`
--

CREATE TABLE `commandes` (
  `id` int NOT NULL,
  `client_id` int NOT NULL,
  `date_commande` date NOT NULL,
  `total` decimal(10,2) NOT NULL DEFAULT '0.00',
  `statut` varchar(50) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'En attente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `commandes`
--

INSERT INTO `commandes` (`id`, `client_id`, `date_commande`, `total`, `statut`) VALUES
(4, 3, '2025-11-11', 29.90, 'Payée'),
(8, 1, '2025-11-07', 79.89, 'Payée'),
(11, 5, '2025-11-21', 0.00, 'Annulée'),
(12, 5, '2025-11-22', 0.00, 'Payée');

-- --------------------------------------------------------

--
-- Table structure for table `details_commandes`
--

CREATE TABLE `details_commandes` (
  `id` int NOT NULL,
  `commande_id` int NOT NULL,
  `product_id` int NOT NULL,
  `quantite` int NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL,
  `annule` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `details_commandes`
--

INSERT INTO `details_commandes` (`id`, `commande_id`, `product_id`, `quantite`, `prix_unitaire`, `annule`) VALUES
(5, 8, 2, 1, 49.99, 0),
(9, 11, 3, 3, 0.00, 1),
(10, 12, 3, 1, 0.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `id` int NOT NULL,
  `last_name` varchar(80) COLLATE utf8mb4_general_ci NOT NULL,
  `first_name` varchar(80) COLLATE utf8mb4_general_ci NOT NULL,
  `role` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(120) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`id`, `last_name`, `first_name`, `role`, `email`, `phone`, `created_at`) VALUES
(2, 'Dupont', 'Marc', 'Magasinier', 'marc.dupont@techdistrib.fr', '06 41 28 93 73', '2025-11-23 19:49:46'),
(3, 'Lemoine', 'Sarah', 'Acheteuse', 'sarah.lemoine@techdistrib.fr', '07 82 10 54 39', '2025-11-23 19:50:48'),
(4, 'Ribeiro', 'Lucas', 'Responsable des ventes', 'lucas.ribeiro@techdistrib.fr', '06 59 72 11 03', '2025-11-23 19:51:51');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `sku` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(160) COLLATE utf8mb4_general_ci NOT NULL,
  `category` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `reorder_level` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sku`, `name`, `category`, `reorder_level`, `created_at`, `price`) VALUES
(2, 'MS-010', 'Souris optique', 'Périphériques', 15, '2025-11-10 16:53:51', 0.00),
(3, 'SSD-512', 'SSD 512 Go NVMe', 'Stockage', 5, '2025-11-10 16:53:51', 0.00),
(5, 'KB-001', 'Clavier mécanique', 'Périphériques', 10, '2025-11-23 18:31:03', 50.00);

-- --------------------------------------------------------

--
-- Table structure for table `purchase_orders`
--

CREATE TABLE `purchase_orders` (
  `id` int NOT NULL,
  `supplier_id` int NOT NULL,
  `order_date` date NOT NULL,
  `status` enum('DRAFT','SENT','RECEIVED_PART','RECEIVED_ALL','CANCELLED') COLLATE utf8mb4_general_ci DEFAULT 'DRAFT',
  `notes` text COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase_orders`
--

INSERT INTO `purchase_orders` (`id`, `supplier_id`, `order_date`, `status`, `notes`) VALUES
(1, 1, '2025-11-11', 'RECEIVED_ALL', ''),
(2, 1, '2025-11-11', 'RECEIVED_ALL', 'RAS'),
(3, 2, '2025-11-19', 'RECEIVED_ALL', 'RAS'),
(4, 2, '2025-11-19', 'RECEIVED_ALL', 'RAS'),
(5, 1, '2025-11-23', 'RECEIVED_ALL', 'RAS'),
(6, 2, '2025-11-23', 'RECEIVED_ALL', 'RAS');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_items`
--

CREATE TABLE `purchase_order_items` (
  `id` int NOT NULL,
  `purchase_order_id` int NOT NULL,
  `product_id` int NOT NULL,
  `qty_ordered` int NOT NULL,
  `unit_cost` decimal(10,2) NOT NULL,
  `qty_received` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase_order_items`
--

INSERT INTO `purchase_order_items` (`id`, `purchase_order_id`, `product_id`, `qty_ordered`, `unit_cost`, `qty_received`) VALUES
(4, 2, 2, 100, 200.00, 100),
(5, 1, 3, 5, 200.00, 5),
(7, 4, 3, 2, 50.00, 2),
(9, 5, 2, 5, 20.00, 5),
(12, 5, 2, 2, 7.00, 2),
(13, 6, 2, 5, 100.00, 5);

-- --------------------------------------------------------

--
-- Table structure for table `stock_movements`
--

CREATE TABLE `stock_movements` (
  `id` bigint NOT NULL,
  `product_id` int NOT NULL,
  `movement_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `type` enum('IN','OUT','ADJ') COLLATE utf8mb4_general_ci NOT NULL,
  `quantity` int NOT NULL,
  `source` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `ref_id` varchar(60) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stock_movements`
--

INSERT INTO `stock_movements` (`id`, `product_id`, `movement_date`, `type`, `quantity`, `source`, `ref_id`) VALUES
(5, 2, '2025-11-19 19:23:03', 'IN', 100, 'PO', '#2'),
(6, 3, '2025-11-19 19:24:12', 'IN', 5, 'PO', '#1'),
(8, 3, '2025-11-19 19:54:19', 'OUT', 2, 'SALE', ''),
(11, 3, '2025-11-19 19:57:35', 'IN', 2, 'PO', '#4'),
(19, 2, '2025-11-20 00:43:12', 'ADJ', -100, 'ADJUST', 'RAS'),
(20, 2, '2025-11-20 00:43:56', 'ADJ', -20, 'ADJUST', 'RAS'),
(22, 3, '2025-11-23 16:30:27', 'IN', 3, 'SALE_CANCEL', '#CMD11'),
(24, 3, '2025-11-23 16:39:48', 'IN', 1, 'SALE_CANCEL', '#CMD9'),
(25, 2, '2025-11-23 16:40:08', 'IN', 1, 'SALE_CANCEL', '#CMD10'),
(26, 3, '2025-11-23 16:48:38', 'IN', 3, 'SALE_CANCEL', '#CMD11'),
(27, 2, '2025-11-23 20:12:03', 'IN', 5, 'PO', '#5'),
(28, 2, '2025-11-23 20:12:03', 'IN', 1, 'PO', '#5'),
(29, 2, '2025-11-23 20:12:14', 'IN', 1, 'PO', '#5'),
(30, 2, '2025-11-23 20:13:52', 'IN', 3, 'PO', '#6'),
(31, 2, '2025-11-23 20:14:15', 'IN', 2, 'PO', '#6'),
(32, 3, '2025-11-23 20:31:36', 'OUT', 2, 'SALE', ''),
(33, 2, '2025-11-23 20:35:00', 'ADJ', 2, 'ADJUST', 'inventaire'),
(34, 3, '2025-11-23 20:35:30', 'OUT', 1, 'SALE', ''),
(35, 5, '2025-11-23 20:36:07', 'ADJ', -3, 'ADJUST', 'Ajustement -');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `phone` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_general_ci,
  `payment_terms` varchar(80) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `name`, `email`, `phone`, `address`, `payment_terms`, `created_at`) VALUES
(1, 'Informatix SAS', 'contact@informatix.fr', '01 44 00 00 00', NULL, '30 jours', '2025-11-10 16:53:50'),
(2, 'MegaParts', 'sales@megaparts.eu', '+33 1 42 42 42 42', NULL, '45 jours', '2025-11-10 16:53:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(60) COLLATE utf8mb4_general_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('ADMIN','PURCHASER','STOCK') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'STOCK',
  `employee_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password_hash`, `role`, `employee_id`) VALUES
(1, 'admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commandes`
--
ALTER TABLE `commandes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`);

--
-- Indexes for table `details_commandes`
--
ALTER TABLE `details_commandes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `commande_id` (`commande_id`),
  ADD KEY `fk_detail_produit` (`product_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sku` (`sku`);

--
-- Indexes for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `supplier_id` (`supplier_id`);

--
-- Indexes for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `purchase_order_id` (`purchase_order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `employee_id` (`employee_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `commandes`
--
ALTER TABLE `commandes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `details_commandes`
--
ALTER TABLE `details_commandes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `stock_movements`
--
ALTER TABLE `stock_movements`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `commandes`
--
ALTER TABLE `commandes`
  ADD CONSTRAINT `commandes_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`);

--
-- Constraints for table `details_commandes`
--
ALTER TABLE `details_commandes`
  ADD CONSTRAINT `details_commandes_ibfk_1` FOREIGN KEY (`commande_id`) REFERENCES `commandes` (`id`);

--
-- Constraints for table `purchase_orders`
--
ALTER TABLE `purchase_orders`
  ADD CONSTRAINT `purchase_orders_ibfk_1` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `purchase_order_items`
--
ALTER TABLE `purchase_order_items`
  ADD CONSTRAINT `purchase_order_items_ibfk_1` FOREIGN KEY (`purchase_order_id`) REFERENCES `purchase_orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `purchase_order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `stock_movements`
--
ALTER TABLE `stock_movements`
  ADD CONSTRAINT `stock_movements_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
