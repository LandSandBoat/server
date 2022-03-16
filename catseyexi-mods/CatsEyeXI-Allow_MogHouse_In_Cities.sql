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
UPDATE zone_settings SET misc = '101' WHERE name = 'Windurst_Waters';

UPDATE zone_settings SET misc = '72' WHERE name = 'Selbina';
UPDATE zone_settings SET misc = '650' WHERE name = 'Rabao';
UPDATE zone_settings SET misc = '650' WHERE name = 'Norg';