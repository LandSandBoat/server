------------------------------------
-- Abyssea Job SQL Adjustments
-- This module reverts relevant SQL tables for jobs to their pre-Abyssea values
------------------------------------
-- Source : https://www.bg-wiki.com/ffxi/Version_Update_(03/26/2012)
------------------------------------

------------------------------------
-- Warrior
------------------------------------

-- Reverts Warrior's Charge cooldown to 15 minutes
UPDATE abilities SET recastTime = 900 WHERE name = 'warriors_charge';

-- Change warrior's Charge merit value to reduce cooldown by 150 seconds per merit
UPDATE merits SET value = 150 WHERE name = 'warriors_charge';
