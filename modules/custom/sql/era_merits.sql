-- Replaces retail merits with Era merits

-- WHM
UPDATE merits SET name = 'protectra_v', upgrade = 5, value = 5, jobs = 4, upgradeid = 7, catagoryid = 33 WHERE meritid = 2184;
UPDATE merits SET name = 'shellra_v', upgrade = 5, value = 2, jobs = 4, upgradeid = 7, catagoryid = 33 WHERE meritid = 2186;

-- BLM
UPDATE merits SET name = 'flare_ii', upgrade = 5, value = 1, jobs = 8, upgradeid = 7, catagoryid = 34 WHERE meritid = 2252;
UPDATE merits SET name = 'freeze_ii', upgrade = 5, value = 1, jobs = 8, upgradeid = 7, catagoryid = 34 WHERE meritid = 2254;
UPDATE merits SET name = 'tornado_ii', upgrade = 5, value = 1, jobs = 8, upgradeid = 7, catagoryid = 34 WHERE meritid = 2256;
UPDATE merits SET name = 'quake_ii', upgrade = 5, value = 1, jobs = 8, upgradeid = 7, catagoryid = 34 WHERE meritid = 2258;
UPDATE merits SET name = 'burst_ii', upgrade = 5, value = 1, jobs = 8, upgradeid = 7, catagoryid = 34 WHERE meritid = 2260;
UPDATE merits SET name = 'flood_ii', upgrade = 5, value = 1, jobs = 8, upgradeid = 7, catagoryid = 34 WHERE meritid = 2262;

-- RDM
UPDATE merits SET name = 'dia_iii', upgrade = 5, value = 30, jobs = 16, upgradeid = 7, catagoryid = 35 WHERE meritid = 2316;
UPDATE merits SET name = 'slow_ii', upgrade = 5, value = 1, jobs = 16, upgradeid = 7, catagoryid = 35 WHERE meritid = 2318;
UPDATE merits SET name = 'paralyze_ii', upgrade = 5, value = 1, jobs = 16, upgradeid = 7, catagoryid = 35 WHERE meritid = 2320;
UPDATE merits SET name = 'phalanx_ii', upgrade = 5, value = 3, jobs = 16, upgradeid = 7, catagoryid = 35 WHERE meritid = 2322;
UPDATE merits SET name = 'bio_iii', upgrade = 5, value = 30, jobs = 16, upgradeid = 7, catagoryid = 35 WHERE meritid = 2324;
UPDATE merits SET name = 'blind_ii', upgrade = 5, value = 1, jobs = 16, upgradeid = 7, catagoryid = 35 WHERE meritid = 2326;

-- BRD
UPDATE merits SET name = 'foe_sirvente', upgrade = 5, value = 5, jobs = 512, upgradeid = 7, catagoryid = 40 WHERE meritid = 2632;
UPDATE merits SET name = 'adventurers_dirge', upgrade = 5, value = 3, jobs = 512, upgradeid = 7, catagoryid = 40 WHERE meritid = 2634;

-- Max Merits
UPDATE merits SET upgrade = 15 WHERE meritid = 68;
