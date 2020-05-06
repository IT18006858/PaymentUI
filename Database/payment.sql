-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 06, 2020 at 07:00 PM
-- Server version: 10.1.39-MariaDB
-- PHP Version: 7.3.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `payment`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `patientID` int(5) NOT NULL,
  `docID` int(5) NOT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `specialization` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `docID` int(5) NOT NULL,
  `doc_name` varchar(30) NOT NULL,
  `pmso` varchar(6) NOT NULL,
  `specialization` varchar(15) NOT NULL,
  `doc_fee` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`docID`, `doc_name`, `pmso`, `specialization`, `doc_fee`) VALUES
(1, 'Pawan', '22563', 'Head', 2500);

-- --------------------------------------------------------

--
-- Table structure for table `lab`
--

CREATE TABLE `lab` (
  `reportID` int(11) NOT NULL,
  `patientID` int(11) NOT NULL,
  `docID` int(11) NOT NULL,
  `report_date` date NOT NULL,
  `report` varchar(20) NOT NULL,
  `report_view` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patientID` int(5) NOT NULL,
  `pname` varchar(30) NOT NULL,
  `pnic` varchar(10) NOT NULL,
  `pcontact_number` varchar(10) NOT NULL,
  `paddress` varchar(50) NOT NULL,
  `pemail` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patientID`, `pname`, `pnic`, `pcontact_number`, `paddress`, `pemail`) VALUES
(1, 'Salman', '963481551V', '0717573515', 'N/A', 'abc@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payID` int(10) NOT NULL,
  `patientID` varchar(11) NOT NULL,
  `docID` varchar(11) NOT NULL,
  `card_no` varchar(16) NOT NULL,
  `cvv` varchar(3) NOT NULL,
  `card_type` varchar(10) NOT NULL,
  `exp_date` varchar(10) NOT NULL,
  `amount` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payID`, `patientID`, `docID`, `card_no`, `cvv`, `card_type`, `exp_date`, `amount`) VALUES
(1, '1', '1', '152363814567', '236', 'master', '2020-04-01', 2500),
(2, '1', '1', '8520852020', '456', 'visa', '2020-04-24', 2500),
(3, '123', '256', '147852369', '236', 'amex', '2024-05-26', 5000),
(4, '12', '15', '789456123', '852', 'MASTER', '2024-05-26', 1500),
(6, '443', '558', '852159327', '863', 'VISA', '2024-05-26', 3000);

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE `prescription` (
  `patientID` int(11) NOT NULL,
  `doctorID` int(11) NOT NULL,
  `brand_name` varchar(10) NOT NULL,
  `generic_name` varchar(10) NOT NULL,
  `qty` int(5) NOT NULL,
  `date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`patientID`,`docID`),
  ADD KEY `docID` (`docID`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`docID`);

--
-- Indexes for table `lab`
--
ALTER TABLE `lab`
  ADD PRIMARY KEY (`reportID`),
  ADD KEY `patientID` (`patientID`,`docID`),
  ADD KEY `docID` (`docID`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patientID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payID`),
  ADD KEY `docfk` (`docID`),
  ADD KEY `patientfk` (`patientID`);

--
-- Indexes for table `prescription`
--
ALTER TABLE `prescription`
  ADD PRIMARY KEY (`patientID`,`doctorID`),
  ADD KEY `doctorID` (`doctorID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `docID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lab`
--
ALTER TABLE `lab`
  MODIFY `reportID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patientID` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`docID`) REFERENCES `doctor` (`docID`),
  ADD CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patientID`);

--
-- Constraints for table `lab`
--
ALTER TABLE `lab`
  ADD CONSTRAINT `lab_ibfk_1` FOREIGN KEY (`docID`) REFERENCES `doctor` (`docID`),
  ADD CONSTRAINT `lab_ibfk_2` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patientID`);

--
-- Constraints for table `prescription`
--
ALTER TABLE `prescription`
  ADD CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`doctorID`) REFERENCES `doctor` (`docID`),
  ADD CONSTRAINT `prescription_ibfk_2` FOREIGN KEY (`patientID`) REFERENCES `patient` (`patientID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
