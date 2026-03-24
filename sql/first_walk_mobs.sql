-- First Walk Mobs for Walk of Echoes
-- Level 30 Cap Instance

-- Delete any existing entries first
DELETE FROM mob_spawn_points WHERE mobname IN ('Caldera_Crab', 'Damask_Crab', 'Cyanic_Crab');
DELETE FROM mob_pools WHERE name IN ('Caldera_Crab', 'Damask_Crab', 'Cyanic_Crab');
DELETE FROM mob_groups WHERE name IN ('Caldera_Crab', 'Damask_Crab', 'Cyanic_Crab') AND zoneid = 182;

-- Create mob pools (using crab family ID 75)
INSERT INTO mob_pools (poolid, name, familyid, modelid, mJob, sJob, cmbSkill, cmbDmgMult, cmbDelay, behavior, aggro, links, mobType, immunity, namevis, flag)
VALUES 
(9001, 'Caldera_Crab', 75, 521, 7, 1, 150, 100, 240, 1, 1, 1, 1, 0, 0, 0),  -- Boss (PLD/WAR)
(9002, 'Damask_Crab', 75, 521, 7, 1, 120, 100, 240, 1, 1, 1, 1, 0, 0, 0),   -- Regular (PLD/WAR)
(9003, 'Cyanic_Crab', 75, 521, 7, 1, 120, 100, 240, 1, 1, 1, 1, 0, 0, 0);   -- Regular (PLD/WAR)

-- Create mob groups (removed minLevel/maxLevel - not in table)
INSERT INTO mob_groups (groupid, poolid, zoneid, name, respawntime, spawntype, dropid, HP, MP, allegiance)
VALUES
(1, 9001, 182, 'Caldera_Crab', 300, 0, 0, 2500, 0, 0),  -- Boss: 3 spawns, higher HP
(2, 9002, 182, 'Damask_Crab', 300, 0, 0, 1500, 0, 0),   -- Regular: 9 spawns
(3, 9003, 182, 'Cyanic_Crab', 300, 0, 0, 1500, 0, 0);   -- Regular: 9 spawns

-- Spawn points around the instance area (238, -8, -248)
-- Boss crabs (3 total) - Caldera Crab
INSERT INTO mob_spawn_points (mobid, mobname, groupid, pos_x, pos_y, pos_z, pos_rot, minLevel, maxLevel)
VALUES
(17629658, 'Caldera_Crab', 1, 250, -8, -250, 0, 30, 30),
(17629659, 'Caldera_Crab', 1, 238, -8, -235, 64, 30, 30),
(17629660, 'Caldera_Crab', 1, 225, -8, -248, 128, 30, 30);

-- Regular crabs (9 total) - Damask Crab
INSERT INTO mob_spawn_points (mobid, mobname, groupid, pos_x, pos_y, pos_z, pos_rot, minLevel, maxLevel)
VALUES
(17629661, 'Damask_Crab', 2, 260, -8, -260, 0, 28, 28),
(17629662, 'Damask_Crab', 2, 255, -8, -240, 32, 28, 28),
(17629663, 'Damask_Crab', 2, 245, -8, -265, 64, 28, 28),
(17629664, 'Damask_Crab', 2, 220, -8, -260, 96, 28, 28),
(17629665, 'Damask_Crab', 2, 215, -8, -240, 128, 28, 28),
(17629666, 'Damask_Crab', 2, 230, -8, -230, 160, 28, 28),
(17629667, 'Damask_Crab', 2, 250, -8, -235, 192, 28, 28),
(17629668, 'Damask_Crab', 2, 240, -8, -270, 224, 28, 28),
(17629669, 'Damask_Crab', 2, 225, -8, -255, 255, 28, 28);

-- Regular crabs (9 total) - Cyanic Crab
INSERT INTO mob_spawn_points (mobid, mobname, groupid, pos_x, pos_y, pos_z, pos_rot, minLevel, maxLevel)
VALUES
(17629670, 'Cyanic_Crab', 3, 265, -8, -245, 0, 28, 28),
(17629671, 'Cyanic_Crab', 3, 258, -8, -255, 32, 28, 28),
(17629672, 'Cyanic_Crab', 3, 243, -8, -243, 64, 28, 28),
(17629673, 'Cyanic_Crab', 3, 233, -8, -260, 96, 28, 28),
(17629674, 'Cyanic_Crab', 3, 220, -8, -245, 128, 28, 28),
(17629675, 'Cyanic_Crab', 3, 228, -8, -238, 160, 28, 28),
(17629676, 'Cyanic_Crab', 3, 248, -8, -258, 192, 28, 28),
(17629677, 'Cyanic_Crab', 3, 235, -8, -268, 224, 28, 28),
(17629678, 'Cyanic_Crab', 3, 253, -8, -248, 255, 28, 28);
