-- --------------------------------------------------------
-- AirSkyBoat Database Conversion File
-- --------------------------------------------------------
-- Table Structure Definition
--
-- 
-- 
-- --------------------------------------------------------

REPLACE INTO `item_usable` (`itemid`, `name`, `validTargets`, `activation`, `animation`, `animationTime`, `maxCharges`, `useDelay`, `reuseDelay`, `aoe`) VALUES
    (4255, 'pinch_of_mana_powder', 1, 3, 89, 0, 0, 0, 0, 1),
    (5322, 'flask_of_healing_powder', 1, 3, 30, 0, 0, 0, 0, 1),
    (5395, 'bottle_of_clerics_drink', 1, 1, 34, 0, 0, 0, 0, 1),
    (5824, 'lucid_potion_i', 1, 4, 30, 0, 0, 0, 0, 0),
    (5825, 'lucid_potion_ii', 1, 4, 31, 0, 0, 0, 0, 0),
    (5826, 'lucid_potion_iii', 1, 4, 31, 0, 0, 0, 0, 0),
    (5827, 'lucid_ether_i', 1, 4, 0, 32, 0, 0, 0, 0),
    (5828, 'lucid_ether_ii', 1, 4, 0, 33, 0, 0, 0, 0),
    (5829, 'lucid_ether_iii', 1, 4, 0, 33, 0, 0, 0, 0),
    (5830, 'lucid_elixir_i', 1, 4, 34, 0, 0, 0, 0, 0),
    (5831, 'lucid_elixir_ii', 1, 4, 34, 0, 0, 0, 0, 0),
    (5835, 'tube_of_healing_salve_i', 1, 4, 0, 0, 0, 0, 0, 0),
    (5836, 'tube_of_healing_salve_ii', 1, 4, 0, 0, 0, 0, 0, 0),
    (5837, 'tube_of_clear_salve_i', 1, 4, 0, 0, 0, 0, 0, 0),
    (5838, 'tube_of_clear_salve_ii', 1, 4, 0, 0, 0, 0, 0, 0),
    (15198, 'sprout_beret', 4, 3, 0, 0, 1, 30, 600, 0),
    (18433, 'kagiroi', 20, 1, 0, 0, 50, 30, 600, 0),
    (18612, 'ram_staff', 1, 2, 0, 0, 1, 30, 86400, 0),
    (18613, 'fourth_staff', 1, 2, 0, 0, 1, 30, 86400, 0),
    (18614, 'cobra_staff', 1, 2, 0, 0, 1, 30, 86400, 0);

