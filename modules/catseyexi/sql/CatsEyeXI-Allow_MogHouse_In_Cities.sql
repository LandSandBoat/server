# allow use of Mog House anywhere in cities
UPDATE zone_settings SET misc = '616' WHERE name = 'Southern_San_dOria';
UPDATE zone_settings SET misc = '104' WHERE name = 'Northern_San_dOria';
UPDATE zone_settings SET misc = '616' WHERE name = 'Port_San_dOria';

UPDATE zone_settings SET misc = '104' WHERE name = 'Port_Bastok';
UPDATE zone_settings SET misc = '616' WHERE name = 'Bastok_Mines';
UPDATE zone_settings SET misc = '616' WHERE name = 'Bastok_Markets';
UPDATE zone_settings SET misc = '40' WHERE name = 'Metalworks';

UPDATE zone_settings SET misc = '104' WHERE name = 'Port_Windurst';
UPDATE zone_settings SET misc = '616' WHERE name = 'Windurst_Woods';
UPDATE zone_settings SET misc = '616' WHERE name = 'Windurst_Walls';
UPDATE zone_settings SET misc = '104' WHERE name = 'Windurst_Waters';

UPDATE zone_settings SET misc = '616' WHERE name = 'Southern_San_dOria_[S]';
UPDATE zone_settings SET misc = '616' WHERE name = 'Bastok_Markets_[S]';
UPDATE zone_settings SET misc = '104' WHERE name = 'Windurst_Waters_[S]';

UPDATE zone_settings SET misc = '1576' WHERE name = 'Aht_Urhgan_Whitegate';
UPDATE zone_settings SET misc = '696' WHERE name = 'Al_Zahbi';

UPDATE zone_settings SET misc = '1640' WHERE name = 'Port_Jeuno';
UPDATE zone_settings SET misc = '1640' WHERE name = 'Lower_Jeuno';
UPDATE zone_settings SET misc = '1640' WHERE name = 'Upper_Jeuno';
UPDATE zone_settings SET misc = '1640' WHERE name = 'RuLude_Gardens';