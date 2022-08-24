# RUN job code: 2097152
# DNC job code: 262144
# SCH job code: 524288

# Allow DNC to equip Mercurial Kris
UPDATE item_equipment SET jobs = "474849" WHERE name = "mercurial_kris";

# Allow DNC to equip Skadis gear
UPDATE item_equipment SET jobs = "328992" WHERE name = "skadis_cuirie";
UPDATE item_equipment SET jobs = "328992" WHERE name = "skadis_bazubands";
UPDATE item_equipment SET jobs = "328992" WHERE name = "skadis_chausses";
UPDATE item_equipment SET jobs = "328992" WHERE name = "skadis_jambeaux";
UPDATE item_equipment SET jobs = "328992" WHERE name = "skadis_visor";

# Allow SCH to equip Marduks gear
UPDATE item_equipment SET jobs = "541188" WHERE name = "marduks_jubbah";
UPDATE item_equipment SET jobs = "541188" WHERE name = "marduks_dastanas";
UPDATE item_equipment SET jobs = "541188" WHERE name = "marduks_shalwar";
UPDATE item_equipment SET jobs = "541188" WHERE name = "marduks_crackows";
UPDATE item_equipment SET jobs = "541188" WHERE name = "marduks_tiara";

# Allow RUN to equip Homam gear
UPDATE item_equipment SET jobs = "2138336" WHERE name = "homam_corazza";
UPDATE item_equipment SET jobs = "2138336" WHERE name = "homam_manopolas";
UPDATE item_equipment SET jobs = "2138336" WHERE name = "homam_zucchetto";
UPDATE item_equipment SET jobs = "2138336" WHERE name = "homam_cosciales";
UPDATE item_equipment SET jobs = "2138336" WHERE name = "homam_gambieras";

# Allow RUN to equip Ares gear
UPDATE item_equipment SET jobs = "2105537" WHERE name = "ares_cuirass";
UPDATE item_equipment SET jobs = "2105537" WHERE name = "ares_gauntlets";
UPDATE item_equipment SET jobs = "2105537" WHERE name = "ares_flanchard";
UPDATE item_equipment SET jobs = "2105537" WHERE name = "ares_sollerets";
UPDATE item_equipment SET jobs = "2105537" WHERE name = "ares_mask";

# Allow GEO to equip Nashira gear
UPDATE item_equipment SET jobs = "1097756" WHERE name = "nashira_manteel";
UPDATE item_equipment SET jobs = "1097756" WHERE name = "nashira_gages";
UPDATE item_equipment SET jobs = "1097756" WHERE name = "nashira_turban";
UPDATE item_equipment SET jobs = "1097756" WHERE name = "nashira_seraweels";
UPDATE item_equipment SET jobs = "1097756" WHERE name = "nashira_crackows";

# Allow GEO to equip Morrigan gear
UPDATE item_equipment SET jobs = "1081368" WHERE name = "morrigans_robe";
UPDATE item_equipment SET jobs = "1081368" WHERE name = "morrigans_cuffs";
UPDATE item_equipment SET jobs = "1081368" WHERE name = "morrigans_slops";
UPDATE item_equipment SET jobs = "1081368" WHERE name = "morrigans_pgch.";
UPDATE item_equipment SET jobs = "1081368" WHERE name = "morrigans_coron.";

# Allow RUN to equip Ragnarok
UPDATE item_equipment SET jobs = "2097345" WHERE name = "ragnarok" and itemId = "18282";

# Remove existing item_mods on Geomancy Set (GEO Artifact)
DELETE from item_mods WHERE itemId = "27786";
DELETE from item_mods WHERE itemId = "27926";
DELETE from item_mods WHERE itemId = "28066";
DELETE from item_mods WHERE itemId = "28206";
DELETE from item_mods WHERE itemId = "28346";

# Remove existing item_mods on Bugua Set (GEO Relic)
DELETE from item_mods WHERE itemId = "26664";
DELETE from item_mods WHERE itemId = "26840";
DELETE from item_mods WHERE itemId = "27016";
DELETE from item_mods WHERE itemId = "27192";
DELETE from item_mods WHERE itemId = "27368";

# Remove existing item_mods on Runeist Set (RUN Artifact)
DELETE from item_mods WHERE itemId = "27787";
DELETE from item_mods WHERE itemId = "27927";
DELETE from item_mods WHERE itemId = "28067";
DELETE from item_mods WHERE itemId = "28207";
DELETE from item_mods WHERE itemId = "28347";

# Remove existing item_mods on Runeist Set (RUN Relic)
DELETE from item_mods WHERE itemId = "26666";
DELETE from item_mods WHERE itemId = "26842";
DELETE from item_mods WHERE itemId = "27018";
DELETE from item_mods WHERE itemId = "27194";
DELETE from item_mods WHERE itemId = "27370";
