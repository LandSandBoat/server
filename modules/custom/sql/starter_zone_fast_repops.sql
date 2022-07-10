-- ---------------------------------------------------------------------------
--  Module to decrease repop times to 1 minute in Starter Zones 
-- ---------------------------------------------------------------------------

-- ------------------------------------------------------------
-- West Ronfaure (Zone 100)
-- ------------------------------------------------------------

UPDATE mob_groups SET respawntime='60' WHERE name='Wild_Rabbit' AND zoneid='100';
UPDATE mob_groups SET respawntime='60' WHERE name='Tunnel_Worm' AND zoneid='100';

-- ------------------------------------------------------------
-- East Ronfaure (Zone 101)
-- ------------------------------------------------------------

UPDATE mob_groups SET respawntime='60' WHERE name='Wild_Rabbit' AND zoneid='101';
UPDATE mob_groups SET respawntime='60' WHERE name='Tunnel_Worm' AND zoneid='101';

-- ------------------------------------------------------------
-- North Gustaberg (Zone 106)
-- ------------------------------------------------------------

UPDATE mob_groups SET respawntime='60' WHERE name='Huge_Hornet' AND zoneid='106';
UPDATE mob_groups SET respawntime='60' WHERE name='Tunnel_Worm' AND zoneid='106';

-- ------------------------------------------------------------
-- South Gustaberg (Zone 107)
-- ------------------------------------------------------------

UPDATE mob_groups SET respawntime='60' WHERE name='Huge_Hornet' AND zoneid='107';
UPDATE mob_groups SET respawntime='60' WHERE name='Tunnel_Worm' AND zoneid='107';

-- ------------------------------------------------------------
-- West Sarutabaruta (Zone 115)
-- ------------------------------------------------------------

UPDATE mob_groups SET respawntime='60' WHERE name='Tiny_Mandragora' AND zoneid='115';
UPDATE mob_groups SET respawntime='60' WHERE name='Bumblebee' AND zoneid='115';

-- ------------------------------------------------------------
-- East Sarutabaruta (Zone 116)
-- ------------------------------------------------------------

UPDATE mob_groups SET respawntime='60' WHERE name='Tiny_Mandragora' AND zoneid='116';
UPDATE mob_groups SET respawntime='60' WHERE name='Bumblebee' AND zoneid='116';

-- ------------------------------------------------------------
-- Zeruhn Mines (Zone 172)
-- ------------------------------------------------------------

UPDATE mob_groups SET respawntime='60' WHERE name='Ding_Bats' AND zoneid='172';
UPDATE mob_groups SET respawntime='60' WHERE name='Tunnel_Worm' AND zoneid='172';
UPDATE mob_groups SET respawntime='60' WHERE name='Mouse_Bat' AND zoneid='172';
UPDATE mob_groups SET respawntime='60' WHERE name='River_Crab' AND zoneid='172';

