-- --------------------------------------------------------
-- AirSkyBoat Database Conversion File
-- Replace Ability Charge times
-- --------------------------------------------------------

REPLACE INTO `abilities_charges` (`recastId`, `job`, `level`, `maxCharges`, `chargeTime`, `meritModID`) VALUES
    (102, 9, 25, 3, 60, 902);
