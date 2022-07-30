-- --------------------------------------------------------
-- AirSkyBoat Database Conversion File
-- --------------------------------------------------------
-- Credit to LimitBreak for all of the work contained within this Table
-- and saving HOURS of work (and my sanity)
-- --------------------------------------------------------

-- ----------
-- GENERAL --
-- ----------

UPDATE synth_recipes SET HQCrystal = "4241" WHERE ID = "293" AND ResultName = "Adaman Chain" ; -- HQ crystal should be Terra and not Inferno
UPDATE synth_recipes SET HQCrystal = "4241" WHERE ID = "4143" AND ResultName = "Silver Belt" ; -- HQ crystal should be Terra and not Inferno
UPDATE synth_recipes SET HQCrystal = "4241" WHERE ID = "4144" AND ResultName = "Brass Fng. Gnt." ; -- HQ crystal should be Terra and not Inferno
UPDATE synth_recipes SET HQCrystal = "4241" WHERE ID = "4146" AND ResultName = "Tigereye Ring" ; -- HQ crystal should be Terra and not Inferno
UPDATE synth_recipes SET HQCrystal = "4241" WHERE ID = "4151" AND ResultName = "Peridot Earring" ; -- HQ crystal should be Terra and not Inferno

-- ----------
-- INSERTS --
-- ----------

-- Cooking
REPLACE INTO `synth_recipes` VALUES 
    (5000,0,2041,0,0,0,0,0,0,0,66,4096,4238,614,626,633,1590,1776,4387,4390,5448,5193,5193,5202,5202,2,4,2,4,'Nero di Seppia'),
    (5001,0,2041,0,0,0,0,0,0,0,66,4096,4238,614,626,633,1590,1776,4387,4390,5128,5193,5193,5202,5202,2,4,2,4,'Nero di Seppia'),
    (5002,0,2042,3,0,0,0,0,0,0,78,4096,4238,610,615,623,627,632,4378,4496,4570,5550,5551,5551,5551,1,1,1,1,'Buche au Chocolat'),


-- Leathercraft
    (6000,1,0,0,0,0,0,18,0,0,0,4100,4242,12825,0,0,0,0,0,0,0,817,850,850,850,1,2,2,2,'Lizard Trousers (desynth)'), -- Adding desynth for Lizard Trousers
    (6001,1,0,0,0,5,0,18,0,0,0,4100,4242,12953,0,0,0,0,0,0,0,649,850,850,850,1,3,3,3,'Lizard Ledelsens (desynth)'), -- Adding desynth for Lizard Ledelsens
    (6002,1,0,0,0,0,0,20,0,0,0,4100,4242,15454,0,0,0,0,0,0,0,850,850,850,850,2,3,3,3,'Little Worm Belt (desynth)'), -- Adding desynth for Little Worm Belt
    (6003,1,0,0,0,0,20,25,0,0,0,4100,4242,15313,0,0,0,0,0,0,0,820,825,850,850,2,2,1,1,'Seers Pumps (desynth)'), -- Adding desynth for Seers Pumps
    (6004,1,0,0,0,0,21,26,0,0,0,4100,4242,15343,0,0,0,0,0,0,0,1828,1828,1828,1828,3,3,3,3,'Traders Pigaches (desynth)'), -- Adding desynth for Traders Pigaches
    (6005,1,0,0,0,0,0,26,0,0,0,4100,4242,15343,0,0,0,0,0,0,0,1828,1828,1828,1828,3,3,3,3,'Studded Gloves (desynth)'), -- Adding desynth for Studded Gloves
    (6006,1,0,0,0,0,8,34,0,0,0,4100,4242,12994,0,0,0,0,0,0,0,818,818,848,848,2,3,1,2,'Shoes (desynth)'), -- Adding desynth for Shoes
    (6007,1,0,0,0,0,0,40,0,0,0,4100,4242,14176,0,0,0,0,0,0,0,817,1232,851,851,3,4,1,1,'Field Boots (desynth)'), -- Adding desynth for Field Boots
    (6008,1,0,0,0,0,0,44,0,0,0,4100,4242,12827,0,0,0,0,0,0,0,850,850,850,850,2,2,2,2,'Cuir Trousers (desynth)'), -- Adding desynth for Cuir Trousers
    (6009,1,0,0,0,0,0,45,0,0,0,4100,4242,15320,0,0,0,0,0,0,0,850,851,851,851,2,2,2,2,'Powder Boots (desynth)'), -- Adding desynth for Powder Boots
    (6010,1,0,0,0,0,0,46,0,0,0,4100,4242,12571,0,0,0,0,0,0,0,913,913,913,913,1,1,1,1,'Cuir Bouilli (desynth)'), -- Adding desynth for Cuir Bouilli
    (6011,1,0,0,0,0,8,59,0,0,0,4100,4242,12995,0,0,0,0,0,0,0,848,819,853,853,1,2,1,1,'Moccasins (desynth)'), -- Adding desynth for Moccasins
    (6012,1,0,0,0,0,0,63,0,0,0,4100,4242,13597,0,0,0,0,0,0,0,817,854,854,854,1,1,1,1,'Beak Mantle (desynth)'), -- Adding desynth for Beak Mantle
    (6013,1,0,0,0,0,0,64,0,0,0,4100,4242,12829,0,0,0,0,0,0,0,817,817,817,817,6,6,6,6,'Beak Trousers (desynth)'), -- Adding desynth for Beak Trousers
    (6014,1,0,0,0,28,0,65,0,0,0,4100,4242,13702,0,0,0,0,0,0,0,850,850,850,850,1,1,1,1,'Beak Ledelsens (desynth)'), -- Adding desynth for Beak Ledelsens
    (6015,1,0,0,0,0,0,66,0,0,0,4100,4242,12980,0,0,0,0,0,0,0,651,855,851,851,1,1,1,2,'Battle Boots (desynth)'), -- Adding desynth for Battle Boots
    (6016,1,0,0,28,0,0,67,0,0,0,4100,4242,13698,0,0,0,0,0,0,0,850,850,850,850,1,1,1,1,'Beak Helm (desynth)'), -- Adding desynth for Beak Helm
    (6017,1,0,0,0,0,0,69,0,0,0,4100,4242,15738,0,0,0,0,0,0,0,651,855,855,855,1,1,1,1,'Tabin Boots (desynth)'), -- Adding desynth for Tabin Boots
    (6018,1,0,0,0,0,0,74,0,0,0,4100,4242,16213,0,0,0,0,0,0,0,2296,1869,1869,1869,1,1,2,2,'Lamia Mantle (desynth)'), -- Adding desynth for Lamia Mantle
    (6019,0,2018,0,0,0,0,70,0,0,0,4103,4245,635,635,635,860,860,860,2129,4509,862,862,862,862,3,3,3,3,'Behem. Leather'), -- Behemoth Leatherx3 craft was missing.
    (6020,1,0,0,0,0,0,95,0,0,0,4100,4242,16212,0,0,0,0,0,0,0,2169,2169,2169,2169,1,1,1,1,'Cerberus Mantle (desynth)'), -- Confirmed as a desynth here: https://www.bluegartr.com/threads/39845-Cerberus-Mantle-Desynth
    (6021,1,0,0,0,0,51,99,60,0,0,4100,4242,14418,0,0,0,0,0,0,0,1623,1623,1629,1629,1,1,2,2,'Bison Jacket (desynth)'), -- Adding desynth for Bison Jacket
    (6022,1,0,0,0,0,56,99,0,0,0,4100,4242,15329,0,0,0,0,0,0,0,855,1163,823,823,1,1,1,1,'Blessed Pumps (desynth)'), -- Adding desynth for Blessed Pumps



-- Clothcraft
    (7000,1,0,0,0,0,16,0,0,0,0,4100,4242,12721,0,0,0,0,0,0,0,834,818,818,818,2,5,6,7,'Cotton Gloves (desynth)'), -- Adding desynth option for Cotton Gloves
    (7001,1,0,0,0,0,17,0,0,0,0,4100,4242,12608,0,0,0,0,0,0,0,817,817,818,818,7,9,5,6,'Tunic (desynth)'), -- Adding desynth option for Tunic
    (7002,1,0,0,0,0,18,0,0,0,0,4100,4242,13584,0,0,0,0,0,0,0,818,818,818,818,4,5,6,7,'Cotton Cape (desynth)'), -- Adding desynth option for Cotton Cape
    (7003,1,0,0,0,0,20,0,0,0,0,4100,4242,12593,0,0,0,0,0,0,0,834,818,818,818,3,10,11,12,'Cotton Doublet (desynth)'), -- Adding desynth option for Cotton Cape
    (7004,1,0,0,0,0,24,0,0,0,0,4100,4242,12466,0,0,0,0,0,0,0,840,819,819,819,1,5,6,7,'Red Cap (desynth)'), -- Adding desynth option for Red Cap
    (7005,1,0,0,0,0,24,20,0,0,0,4100,4242,15161,0,0,0,0,0,0,0,840,819,819,819,2,2,4,4,'Noct Beret (desynth)'), -- Adding desynth option for Noct Beret
    (7006,1,0,0,0,0,25,0,0,0,0,4100,4242,12722,0,0,0,0,0,0,0,834,819,819,819,2,5,6,7,'Bracers (desynth)'), -- Adding desynth option for Noct Beret
    (7007,1,0,0,0,0,27,20,0,0,0,4100,4242,15311,0,0,0,0,0,0,0,850,850,819,819,1,2,6,9,'Noct Gaiters (desynth)'), -- Adding desynth option for Noct Gaiters
    (7008,1,0,0,0,13,29,0,0,0,0,4100,4242,12594,0,0,0,0,0,0,0,650,650,650,650,1,1,1,1,'Gambison (desynth)'), -- Adding desynth option for Gambison
    (7009,1,0,0,0,0,30,0,0,0,0,4100,4242,15881,0,0,0,0,0,0,0,817,817,817,817,1,1,1,1,'Talisman Obi (desynth)'), -- Adding desynth option for Talisman Obi
    (7010,1,0,0,0,0,34,0,0,0,0,4100,4242,12970,0,0,0,0,0,0,0,818,819,819,819,1,7,8,9,'Soil Kyahan (desynth)'), -- Adding desynth option for Soil Kyahan
    (7011,1,0,0,0,0,36,0,0,0,0,4100,4242,12842,0,0,0,0,0,0,0,819,819,819,819,3,6,6,6,'Soil Sitabaki (desynth)'), -- Adding desynth option for Soil Sitabaki
    (7012,1,0,0,0,0,38,0,0,0,0,4100,4242,13075,0,0,0,0,0,0,0,847,820,820,820,7,1,2,3,'Feather Collar (desynth)'), -- Adding desynth option for Feather Collar
    (7013,1,0,0,0,0,39,0,0,0,0,4100,4242,14423,0,0,0,0,0,0,0,1700,1700,1700,1700,2,2,2,2,'Mist Tunic (desynth)'), -- Adding desynth option for Mist Tunic
    (7014,1,0,0,0,0,39,0,0,0,0,4100,4242,15905,0,0,0,0,0,0,0,1828,1828,1828,1828,1,1,2,2,'Mohbwa Sash (desynth)'), -- Adding desynth option for Mohbwa Sash
    (7015,1,0,0,0,18,41,0,0,0,0,4100,4242,12730,0,0,0,0,0,0,0,819,820,820,820,3,4,4,4,'Wool Cuffs (desynth)'), -- Adding desynth option for Wool Cuffs
    (7016,1,0,0,0,11,42,0,0,0,0,4100,4242,12858,0,0,0,0,0,0,0,650,650,650,650,1,1,1,1,'Wool Slops (desynth)'), -- Adding desynth option for Wool Slops __changed GS subcraft to 11 from 28*sims
    (7017,1,0,0,0,12,43,0,0,0,0,4100,4242,12602,0,0,0,0,0,0,0,820,820,820,820,6,6,6,6,'Wool Robe (desynth)'), -- Adding desynth option for Wool Robe
    (7018,1,0,0,0,11,44,0,0,0,0,4100,4242,13322,0,0,0,0,0,0,0,846,846,744,744,1,2,1,1,'Wing Earring (desynth)'), -- Adding desynth option for Wing Earring
    (7019,1,0,0,0,0,44,0,0,0,0,4100,4242,13931,0,0,0,0,0,0,0,816,816,816,816,1,2,2,2,'Lilac Corsage (desynth)'), -- Adding desynth option for Lilac Corsage
    (7020,1,0,0,0,0,52,0,0,0,0,4100,4242,12865,0,0,0,0,0,0,0,816,820,822,822,1,2,1,1,'Black Slacks (desynth)'), -- Adding desynth option for Black Slacks
    (7021,1,0,0,0,0,55,0,0,0,0,4100,4242,16261,0,0,0,0,0,0,0,2296,2296,2296,2296,1,1,2,3,'Mohbwa Scarf (desynth)'), -- Adding desynth option for Mohbwa Scarf
    (7022,1,0,0,0,8,58,0,0,0,0,4100,4242,12731,0,0,0,0,0,0,0,816,816,816,816,1,1,1,1,'Velvet Cuffs (desynth)'), -- Adding desynth option for Velvet Cuffs
    (7023,1,0,0,0,0,59,0,0,0,0,4100,4242,15907,0,0,0,0,0,0,0,1828,1828,1828,1828,2,2,3,3,'Qiqirn Sash (desynth)'), -- Adding desynth option for Qiqirn Sash
    (7024,1,0,0,0,0,66,0,0,0,0,4100,4242,14492,0,0,0,0,0,0,0,823,823,823,823,1,1,1,1,'High Mana Cloak (desynth)'), -- Adding desynth option for High Mana Cloak
    (7025,1,0,0,0,0,67,0,0,0,0,4100,4242,13752,0,0,0,0,0,0,0,834,834,820,820,2,3,2,2,'Wool Doublet (desynth)'), -- Adding desynth option for Wool Doublet
    (7026,1,0,0,0,0,68,0,0,0,0,4100,4242,12604,0,0,0,0,0,0,0,816,816,816,816,8,8,8,8,'Silk Coat (desynth)'), -- Adding desynth option for Silk Coat
    (7027,1,0,0,0,0,69,36,0,0,0,4100,4242,14374,0,0,0,0,0,0,0,850,851,851,851,1,1,1,1,'Field Tunica (desynth)'), -- Adding desynth option for Field Tunica
    (7028,1,0,0,0,0,73,0,0,0,0,4100,4242,12868,0,0,0,0,0,0,0,816,816,816,816,4,4,4,4,'Silk Slacks (desynth)'), -- Adding desynth option for Silk Slacks
    (7029,1,0,0,0,0,73,0,0,0,0,4100,4242,15460,0,0,0,0,0,0,0,823,823,823,823,1,1,1,1,'Deductive Gold Obi (desynth)'), -- Adding desynth option for Deductive Gold Obi
    (7030,1,0,0,0,0,74,6,0,0,0,4100,4242,15618,0,0,0,0,0,0,0,1700,2304,2304,2304,1,3,4,4,'Vendors Slops (desynth)'), -- Adding desynth option for Vendor's Slops
    (7031,1,0,0,0,0,77,0,0,0,0,4100,4242,12612,0,0,0,0,0,0,0,816,816,816,823,6,7,8,1,'Silk Cloak (desynth)'), -- Adding desynth option for Silk Cloak
    (7032,1,0,0,0,0,80,0,0,0,0,4100,4242,13207,0,0,0,0,0,0,0,823,823,823,823,1,1,1,1,'Brocade Obi (desynth)'), -- Adding desynth option for Brocade Obi
    (7033,1,0,0,0,0,81,0,0,0,0,4100,4242,13578,0,0,0,0,0,0,0,816,816,816,1110,4,5,6,1,'Blue Cape (desynth)'), -- Adding desynth option for Blue Cape
    (7034,1,0,0,48,0,81,0,0,0,0,4100,4242,13881,0,0,0,0,0,0,0,816,816,816,1228,4,5,6,8,'Arhats Jinpachi (desynth)'), -- Adding desynth option for Arhats Jinpachi
    (7035,1,0,0,45,0,82,0,0,0,0,4100,4242,14129,0,0,0,0,0,0,0,816,816,816,816,6,8,10,12,'Arhats Sune-ate (desynth)'), -- Adding desynth option for Arhat's Sune-ate
    (7036,1,0,0,0,0,89,0,0,0,0,4100,4242,13779,0,0,0,0,0,0,0,822,823,821,1132,1,1,1,1,'Black Cloak (desynth)'), -- Adding desynth option for Black Cloak
    (7037,1,0,0,60,0,90,0,0,0,0,4100,4242,12617,0,0,0,0,0,0,0,682,664,821,1132,2,2,1,3,'War Shinobi Gi (desynth)'), -- Adding desynth option for War Shinobi Gi
    (7038,1,0,0,42,0,91,41,0,0,0,4100,4242,13925,0,0,0,0,0,0,0,855,1228,1228,1228,1,8,8,8,'Rst. Jinpachi (desynth)'), -- Adding desynth option for Rst. Jinpachi
    (7039,1,0,0,0,21,92,34,0,0,0,4100,4242,13929,0,0,0,0,0,0,0,816,821,792,851,4,1,1,2,'Errant Hat (desynth)'), -- Adding desynth option for Errant Hat
    (7040,1,0,0,44,0,92,41,0,0,0,4100,4242,13002,0,0,0,0,0,0,0,816,816,816,816,1,1,1,1,'Yasha Sune-ate (desynth)'), -- Adding desynth option for Yasha Sune-ate
    (7041,1,0,0,0,21,92,34,0,0,0,4100,4242,13929,0,0,0,0,0,0,0,816,821,792,851,4,1,1,2,'Errant hat (desynth)'), -- Adding desynth option for Errant Hat
    (7042,1,0,0,0,0,93,0,0,0,0,4100,4242,14315,0,0,0,0,0,0,0,816,816,816,816,2,2,2,2,'Shair Seraweels (desynth)'), -- Adding desynth option for Shair Seraweels
    (7043,1,0,0,0,0,96,0,0,0,0,4100,4242,1368,0,0,0,0,0,0,0,834,820,823,821,1,3,3,3,'Cursed Mitts (desynth)'), -- Adding desynth option for Cursed Mitts
    (7044,1,0,0,0,0,97,0,0,0,0,4100,4242,15391,0,0,0,0,0,0,0,823,823,821,821,1,1,1,1,'Blessed Trousers (desynth)'), -- Adding desynth option for Blessed Trousers
    (7045,1,0,0,0,51,97,51,0,0,0,4100,4242,2451,0,0,0,0,0,0,0,2152,2152,2152,2152,1,1,1,1,'Cursed Coat (desynth)'), -- Adding desynth option for Cursed Coat

-- Bonecraft
    (8000,1,0,0,0,0,0,0,15,0,0,4100,4242,13076,0,0,0,0,0,0,0,817,880,891,891,1,1,4,4,'Fang Necklace (desynth)'), -- Adding desynth option for Fang Necklace
    (8001,1,0,0,0,0,0,5,22,0,0,4100,4242,12966,0,0,0,0,0,0,0,880,850,850,850,1,1,2,2,'Bone Leggings (desynth)'), -- Adding desynth option for Bone Leggings
    (8002,1,0,0,0,0,0,6,24,0,0,4100,4242,12834,0,0,0,0,0,0,0,817,880,850,850,3,1,1,2,'Bone Subligar (desynth)'), -- Adding desynth option for Bone Subligar
    (8003,1,0,0,0,0,0,7,26,0,0,4100,4242,12582,0,0,0,0,0,0,0,880,868,893,893,1,1,1,1,'Bone Harness (desynth)'), -- Adding desynth option for Bone Harness
    (8004,1,0,0,0,0,0,20,29,0,0,4100,4242,15163,0,0,0,0,0,0,0,880,880,927,927,1,1,1,1,'Seers Crown (desynth)'), -- Adding desynth option for Seers Crown
    (8005,1,0,0,0,0,0,8,32,0,0,4100,4242,12967,0,0,0,0,0,0,0,889,852,852,852,1,1,1,1,'Beetle Leggings (desynth)'), -- Adding desynth option for Beetle Leggings
    (8006,1,0,0,0,0,0,0,47,0,0,4100,4242,14987,0,0,0,0,0,0,0,881,881,881,881,1,1,1,1,'Thunder Mittens (desynth)'), -- Adding desynth option for Thunder Mittens
    (8007,1,0,0,0,0,0,0,49,0,0,4100,4242,13091,0,0,0,0,0,0,0,881,881,881,881,1,1,1,1,'Carapace Gorget (desynth)'), -- Adding desynth option for Carapace Gorget
    (8008,1,0,0,0,0,0,0,80,0,0,4100,4242,12563,0,0,0,0,0,0,0,850,821,887,887,1,1,2,2,'Coral Scale Mail (desynth)'), -- Adding desynth option for Coral Scale Mail
    (8009,1,0,0,0,0,0,0,86,0,0,4100,4242,16265,0,0,0,0,0,0,0,879,879,2426,2426,1,1,1,1,'Wivre Gorget (desynth)'), -- Adding desynth option for Wivre Gorget

-- Smithing
    (9000,1,0,2,6,0,0,0,0,0,0,4100,4242,16390,0,0,0,0,0,0,0,649,649,649,649,1,2,2,2,'Bronze Knuckles (desynth)'), -- Adding desynth option for Bronze Knuckles
    (9001,1,0,0,20,0,0,0,0,0,0,4100,4242,16450,0,0,0,0,0,0,0,649,649,651,651,1,1,1,1,'Dagger (desynth)'), -- Adding desynth option for Dagger
    (9002,1,0,0,24,0,0,0,0,0,0,4100,4242,17035,0,0,0,0,0,0,0,651,651,651,651,1,1,3,3,'Mace (desynth)'), -- Adding desynth option for Mace
    (9003,1,0,4,26,0,0,0,0,0,0,4100,4242,16643,0,0,0,0,0,0,0,714,651,651,651,1,1,1,1,'Battleaxe (desynth)'), -- Adding desynth option for Battleaxe
    (9004,1,0,0,32,0,0,0,0,0,0,4100,4242,16774,0,0,0,0,0,0,0,817,714,651,651,3,1,2,2,'Scythe (desynth)'), -- Adding desynth option for Scythe
    (9005,1,0,0,32,0,0,0,0,0,0,4100,4242,17942,0,0,0,0,0,0,0,1231,1231,1231,1231,6,6,6,6,'Tomahawk (desynth)'), -- Adding desynth option for Tomahawk
    (9006,1,0,0,33,0,0,0,0,0,0,4100,4242,12936,0,0,0,0,0,0,0,851,651,651,651,1,1,2,3,'Greaves (desynth)'), -- Adding desynth option for Greaves
    (9007,1,0,20,33,0,0,6,0,0,0,4100,4242,16966,0,0,0,0,0,0,0,852,818,651,657,1,1,1,1,'Tachi (desynth)'), -- Adding desynth option for Tachi
    (9008,1,0,0,33,0,0,0,0,0,0,4100,4242,16473,0,0,0,0,0,0,0,652,652,652,652,1,1,1,1,'Kukri (desynth)'), -- Adding desynth option for Kukri
    (9009,1,0,0,37,0,0,0,0,0,0,4100,4242,16399,0,0,0,0,0,0,0,649,851,652,652,1,1,2,2,'Katars (desynth)'), -- Adding desynth option for Katars
    (9010,1,0,0,40,0,0,0,0,0,0,4100,4242,17036,0,0,0,0,0,0,0,1226,1226,653,653,8,10,2,3,'Mythril Mace (desynth)'), -- Adding desynth option for Mythril Mace
    (9011,1,0,5,41,0,0,13,0,0,0,4100,4242,16584,0,0,0,0,0,0,0,714,848,848,848,1,1,1,1,'Mythril Claymore (desynth)'), -- Adding desynth option for Mythril Claymore
    (9012,1,0,11,42,0,0,0,0,0,0,4100,4242,16644,0,0,0,0,0,0,0,710,710,710,710,1,1,1,1,'Mythril Axe (desynth)'), -- Adding desynth option for Mythril Axe
    (9013,1,0,11,43,0,0,0,0,0,0,4100,4242,12962,0,0,0,0,0,0,0,852,852,852,852,1,2,2,2,'Leggings (desynth)'), -- Adding desynth option for Leggings
    (9014,1,0,0,50,0,0,0,0,0,0,4100,4242,12306,0,0,0,0,0,0,0,715,651,651,651,1,1,2,2,'Kite Shield (desynth)'), -- Adding desynth option for Kite Shield
    (9015,1,0,0,53,0,0,0,0,0,0,4100,4242,16901,0,0,0,0,0,0,0,852,715,1226,657,1,1,6,1,'Kodachi (desynth)'), -- Adding desynth option for Kodachi
    (9016,1,0,0,56,0,0,0,14,0,0,4100,4242,16413,0,0,0,0,0,0,0,894,654,654,654,1,1,1,1,'Darksteel Claws (desynth)'), -- Adding desynth option for Darksteel Claws
    (9017,1,0,0,57,0,0,0,0,0,0,4100,4242,13785,0,0,0,0,0,0,0,652,652,652,652,2,2,2,2,'Steel Scale Mail (desynth)'), -- Adding desynth option for Steel Scale Mail
    (9018,1,0,0,60,0,0,0,0,0,0,4100,4242,17037,0,0,0,0,0,0,0,654,654,654,654,1,1,2,3,'Darksteel Mace (desynth)'), -- Adding desynth option for Darksteel Mace 
    (9019,1,0,0,61,0,0,48,0,0,0,4100,4242,15402,0,0,0,0,0,0,0,819,851,654,654,3,2,1,1,'Alumine Brayettes (desynth)'), -- Adding desynth option for Alumine Brayettes
    (9020,1,0,0,64,0,0,0,0,0,0,4100,4242,12683,0,0,0,0,0,0,0,851,851,851,851,1,1,1,1,'Darksteel Mufflers (desynth)'), -- Adding desynth option for Darksteel Mufflers
    (9021,1,0,37,67,16,0,0,0,0,0,4100,4242,18704,0,0,0,0,0,0,0,652,654,654,654,1,1,1,1,'Darksteel Hexagun (desynth)'), -- Adding desynth option for Darksteel Hexagun
    (9022,1,0,0,91,0,0,0,0,0,0,4100,4242,18405,0,0,0,0,0,0,0,2302,2302,2302,2302,1,1,2,2,'Jadagna (desynth)'), -- Adding desynth option for Jadagna
    (9023,1,0,0,91,0,0,0,0,0,0,4100,4242,18406,0,0,0,0,0,0,0,2302,2302,2302,2302,1,1,2,2,'Jadagna +1  (desynth)'),-- Adding desynth option for Jadagna +1
    (9024,1,0,0,95,51,47,0,0,0,0,4100,4242,15330,0,0,0,0,0,0,0,1225,654,654,654,4,1,1,1,'Hachiman Sune-Ate (desynth)'), -- Adding desynth option for Hachiman Sune-Ate
    (9025,1,0,0,98,60,0,0,0,0,0,4100,4242,12420,0,0,0,0,0,0,0,914,1225,654,655,1,6,1,1,'Adaman Barbuta (desynth)'), -- Adding desynth option for Adaman Barbuta
    (9026,1,0,0,98,60,0,0,0,0,0,4100,4242,13941,0,0,0,0,0,0,0,914,1225,654,655,1,6,1,1,'Gem Barbuta (desynth)'), -- Adding desynth option for Gem Barbuta
    (9027,1,0,0,102,60,0,0,0,0,0,4100,4242,12676,0,0,0,0,0,0,0,914,1225,654,655,1,6,1,1,'Adaman Gauntlets (desynth)'), -- Adding desynth option for Adaman Gauntlets
    (9028,1,0,0,102,60,0,0,0,0,0,4100,4242,14828,0,0,0,0,0,0,0,914,1225,654,655,1,6,1,1,'Gem Gauntlets (desynth)'), -- Adding desynth option for Gem Gauntlets


-- Goldsmithing
    (10000,1,0,0,0,13,0,0,0,0,0,4100,4242,16449,0,0,0,0,0,0,0,649,648,648,648,1,1,1,1,'Brass Dagger (desynth)'), -- Adding desynth option for Brass Dagger
    (10001,1,0,0,0,23,0,0,0,0,0,4100,4242,1625,0,0,0,0,0,0,0,650,650,650,745,1,1,1,1,'Moblin Helm (desynth)'), -- Adding lightning crystal desynth option for Moblin Helm
    (10002,1,0,0,0,30,0,0,0,0,0,4100,4242,12689,0,0,0,0,0,0,0,817,818,850,650,3,1,2,2,'Brass Finger Gauntlets (desynth)'), -- Adding desynth option for Brass Finger Gauntlets
    (10003,1,0,0,0,35,0,0,0,0,0,4100,4242,15801,0,0,0,0,0,0,0,744,744,1766,1766,1,1,1,1,'Tigereye Ring (desynth)'), -- Adding desynth option for Tigereye Ring
    (10004,1,0,0,0,36,0,0,0,0,0,4100,4242,17686,0,0,0,0,0,0,0,648,744,1234,1234,1,1,6,6,'Spark Bilbo (desynth)'), -- Adding desynth option for Spark Bilbo
    (10005,1,0,0,0,44,0,0,0,0,0,4100,4242,16456,0,0,0,0,0,0,0,652,652,653,653,1,1,1,1,'Mythril Baselard (desynth)'), -- Adding desynth option for Mythril Baselard
    (10006,1,0,0,0,50,13,0,0,0,0,4100,4242,12554,0,0,0,0,0,0,0,819,819,653,653,1,3,8,8,'Banded Mail (desynth)'), -- Adding desynth option for Banded Mail
    (10007,1,0,0,0,51,0,0,0,0,0,4100,4242,17512,0,0,0,0,0,0,0,880,1232,650,653,3,6,1,1,'Hydro Baghnakhs (desynth)'), -- Adding desynth option for Hydro Baghnakhs
    (10008,1,0,0,0,67,0,0,0,0,0,4100,4242,12545,0,0,0,0,0,0,0,653,851,653,654,1,2,2,2,'Mythril Breastplate (desynth)'), -- Adding desynth option for Mythril Breastplate
    (10009,0,1995,0,0,69,0,0,0,0,0,4096,4238,1858,1858,1858,1858,1858,1858,2144,0,1859,1859,1859,1859,6,6,6,6,'Moblumin Sheet'), -- Adding multiple synth option for Moblumin Sheet
    (10010,1,0,0,0,85,0,0,0,0,0,4100,4242,12368,0,0,0,0,0,0,0,653,1228,745,745,1,6,1,1,'Royal Knight Shield +1 (desynth)'), -- Adding desynth option for Royal Knight Shield +1
    (10011,1,0,0,0,85,0,0,0,0,0,4100,4242,12376,0,0,0,0,0,0,0,653,1228,745,745,1,6,1,1,'Temple Knight Shield +1 (desynth)'), -- Adding desynth option for Temple Knight Shield +1
    (10012,1,0,0,0,85,0,0,0,0,0,4100,4242,13357,0,0,0,0,0,0,0,813,813,746,746,1,1,1,2,'Angels Earring (desynth)'), -- Adding desynth option for Angel's Earring
    (10013,1,0,0,0,85,0,0,0,0,0,4100,4242,13414,0,0,0,0,0,0,0,813,813,746,746,1,1,1,2,'Heavens Earring (desynth)'), -- Adding desynth option for Heavens Earring
    (10014,1,0,0,0,85,0,0,0,0,0,4100,4242,14719,0,0,0,0,0,0,0,813,813,746,746,1,1,1,2,'Heavens Earring +1 (desynth)'), -- Adding desynth option for Heavens Earring +1
    (10015,1,0,0,0,90,0,0,0,0,0,4100,4242,15991,0,0,0,0,0,0,0,2359,2359,747,747,1,1,1,1,'Star Earring (desynth)'), -- Adding desynth option for Star Earring
    (10016,1,0,0,0,100,0,0,0,0,0,4100,4242,15803,0,0,0,0,0,0,0,1271,1271,747,747,1,1,1,1,'Crimson Ring (desynth)'), -- Adding desynth option for Crimson Ring
    (10017,1,0,0,0,100,0,0,0,0,0,4100,4242,15805,0,0,0,0,0,0,0,2359,2359,747,747,1,1,1,1,'Star Ring (desynth)'), -- Adding desynth option for Star Ring
    (10018,1,0,41,43,101,0,0,0,0,0,4100,4242,18482,0,0,0,0,0,0,0,653,653,745,745,1,1,1,2,'Amood (desynth)'), -- Adding desynth option for Amood
    (10019,1,0,0,0,102,0,0,0,0,0,4100,4242,14630,0,0,0,0,0,0,0,747,747,747,1299,1,1,2,1,'Flame Ring (desynth)'), -- Adding desynth option for Flame Ring
    (10020,1,0,0,0,102,0,0,0,0,0,4100,4242,14632,0,0,0,0,0,0,0,747,747,747,1304,1,1,2,1,'Aqua Ring (desynth)'), -- Adding desynth option for Aqua Ring
    (10021,1,0,0,0,102,0,0,0,0,0,4100,4242,14634,0,0,0,0,0,0,0,747,747,747,1302,1,1,2,1,'Soil Ring (desynth)'), -- Adding desynth option for Soil Ring
    (10022,1,0,0,0,102,0,0,0,0,0,4100,4242,14636,0,0,0,0,0,0,0,747,747,747,1301,1,1,2,1,'Breeze Ring (desynth)'), -- Adding desynth option for Breeze Ring
    (10023,1,0,0,0,102,0,0,0,0,0,4100,4242,14638,0,0,0,0,0,0,0,747,747,747,1303,1,1,2,1,'Thunder Ring (desynth)'), -- Adding desynth option for Thunder Ring
    (10024,1,0,0,0,102,0,0,0,0,0,4100,4242,14640,0,0,0,0,0,0,0,747,747,747,1300,1,1,2,1,'Snow Ring (desynth)'), -- Adding desynth option for Snow Ring 
    (10025,1,0,0,0,102,0,0,0,0,0,4100,4242,14642,0,0,0,0,0,0,0,747,747,747,1305,1,1,2,1,'Light Ring (desynth)'), -- Adding desynth option for Light Ring
    (10026,1,0,0,0,102,0,0,0,0,0,4100,4242,14644,0,0,0,0,0,0,0,747,747,747,1306,1,1,2,1,'Dark Ring (desynth)'), -- Adding desynth option for Dark Ring

-- Alchemy
    (11000, 0, 2034, 0, 0, 0, 0, 0, 0, 8, 0, 4101, 4243, 612, 1643, 1646, 1648, 4368, 4447, 0, 0, 5298, 5298, 5298, 5298, 1, 2, 3, 4, 'Muting Potion'), -- Craft was missing
    (11001, 1, 0, 0, 0, 0, 0, 0, 0, 9, 0, 16600, 0, 0, 0, 0, 0, 0, 0, 0, 0, 913, 649, 649, 649, 1, 2, 2, 2, 'Wax Sword (desynth)'); -- Adding desynth option for Wax Sword


-- --------------
-- WOODWORKING --
-- --------------
UPDATE synth_recipes SET Cloth = "11" WHERE ID = "1" AND ResultName = "Simple Bed"; -- Seems to be Clothcraft 11 by comments here: https://ffxi.allakhazam.com/db/item.html?fitem=1926
UPDATE synth_recipes SET Gold = "57" WHERE ID = "38" AND ResultName = "Wardrobe"; -- Goldsmithing should be at least 57 as confirmed here: https://www.ffxiah.com/item/124/wardrobe
UPDATE synth_recipes SET Crystal = "4099" WHERE ID = "41" AND ResultName = "Coffee Table"; -- Confirmed that this is earth crystal: https://ffxi.allakhazam.com/db/item.html?fitem=10693. Sub levels aren't confirmed.
UPDATE synth_recipes SET ResultHQ1Qty = "1" WHERE ID = "405" AND ResultName = "Ancient Lumber"; -- Mythic Pole. No BG data. FFXiwiki says HQ1 is Ancient Lumberx1.
UPDATE synth_recipes SET Result = "930", ResultHQ1 = "851", ResultHQ2 = "717", ResultHQ3 = "809", ResultName = "Beastman Blood" WHERE ID = "498"; -- There is no agreement on desynth. Using FFXIWIKI data: https://ffxiclopedia.fandom.com/wiki/Frost_Shield
UPDATE synth_recipes SET ResultHQ2 = "710", ResultHQ3 = "710", ResultHQ2Qty = "1", ResultHQ3Qty = "2" WHERE ID = "825" and ResultName = "Coeurl Whisker"; -- Harp. As per BG and FFXIwiki HQ2/3 should be Chestnut lumberx1 and x2.
UPDATE synth_recipes SET ResultHQ2Qty = "10", ResultHQ3Qty = "12" WHERE ID = "1018" and ResultName = "Divine Sap"; -- HQ2 should yield 10 and HQ3 12.s
UPDATE synth_recipes SET Ingredient1 = "698" WHERE ID = "1062" and ResultName = "Bwtch. Ash Lbr."; -- Should use Ash Log and not Ash Lumber as confirmed here: https://www.ffxiah.com/item/1671/bwtch-ash-lbr
UPDATE synth_recipes SET Smith = "60" WHERE ID = "3221" AND ResultName = "Iron-splitter"; -- Most sites list this as Smithing 60.
UPDATE synth_recipes SET Smith = "60" WHERE ID = "3224" AND ResultName = "Steel-splitter"; -- Unconfirmed on the sub, but FFXIwiki has it at 60.
UPDATE synth_recipes SET ResultHQ3 = "718" WHERE ID = "3493" and ResultName = "Parchment"; -- Angel's Flute. Nerfing HQ3 following a patch from 06/09/08: https://www.bg-wiki.com/ffxi/Version_Update_(06/09/2008)
UPDATE synth_recipes SET KeyItem = "1987" WHERE ID = "3915" and ResultName = "Black Bolt"; -- This also requires keyitem "Boltmaker".
UPDATE synth_recipes SET Smith = "38" WHERE ID = "3343" AND ResultName = "Dark Mezraq"; -- Subcraft levels aren't confirmed anywhere, but this post confirms both subs should be Apprentice (38-50): https://www.bluegartr.com/threads/49240-Dark-mezraq-subcraft-question
UPDATE synth_recipes SET Bone = "1" WHERE ID = "343" AND ResultName = "Yew Lumber"; -- Subcraft levels aren't confirmed anywhere, but this post confirms both subs should be Apprentice (38-50): https://www.bluegartr.com/threads/49240-Dark-mezraq-subcraft-question


-- ----------
-- COOKING --
-- ----------
UPDATE synth_recipes SET Cook = "43", Result = "17876", ResultHQ1 = "17876", ResultHQ2 = "17876", ResultHQ3 = "17876", ResultQty = "1", ResultHQ1Qty = "1", ResultHQ2Qty = "1", ResultHQ3Qty = "1" WHERE ID = "3284" AND ResultName = "Fish Broth"; -- Most sites list this as single fish broth in all ranks and also Cooking 43
UPDATE synth_recipes SET ResultHQ1 = "4588", ResultHQ2 = "4588", ResultHQ3 = "4588" WHERE ID = "1530" AND ResultName = "Eel Kabob"; -- HQ1 and ahead should yield Broiled Eel.
UPDATE synth_recipes SET Leather = "1" WHERE ID = "2734" AND ResultName = "Apple Tank"; -- Couldn't find a single source proving this is LTW 24. Changing to 1 as that's the only data I found and is inline with Orange Tank.
UPDATE synth_recipes SET Leather = "1" WHERE ID = "2735" AND ResultName = "Pear Tank"; -- Couldn't find a single source proving this is LTW 49. Changing to 1 as that's the only data I found and is inline with Orange Tank.
UPDATE synth_recipes SET Leather = "1" WHERE ID = "2736" AND ResultName = "Pamama Tank"; -- Couldn't find a single source proving this is LTW 37. Changing to 1 as that's the only data I found and is inline with Orange Tank.
UPDATE synth_recipes SET Leather = "1" WHERE ID = "2737" AND ResultName = "Persikos Tank"; -- Couldn't find a single source proving this is LTW 12. Changing to 1 as that's the only data I found and is inline with Orange Tank.
UPDATE synth_recipes SET ResultName = "Imperial Coffee" WHERE ResultName = "Imperial_Coffee" AND ID = "4572"; -- Just fixing a minor typo.
UPDATE synth_recipes SET ResultName = "Peeled Lobster" WHERE ResultName = "Peeled_Lobster" AND ID = "4564"; -- Just fixing a minor typo.
UPDATE synth_recipes SET ResultHQ1 = "4295", ResultHQ2 = "4295", ResultHQ3 = "4295" WHERE ID = "1572" AND ResultName = "Coeurl Saute"; -- HQs should be Royal Saute.
DELETE FROM synth_recipes WHERE ID = "3943" AND ResultName = "Salt Ramen Soup"; -- OOE. 2020.
DELETE FROM synth_recipes WHERE ID = "4078" AND ResultName = "Sea Dragon Liver"; -- OOE. 2015.
DELETE FROM synth_recipes WHERE ID = "4080" AND ResultName = "Ramen Noodles"; -- OOE. 2015.

-- -----------------
-- LEATHERWORKING --
-- -----------------
UPDATE synth_recipes SET Wood = "50" WHERE ID = "1768" AND ResultName = "Hoplon"; -- FFXIAH, FFXIWIKI and Somepage says Woodworking is 50. Will keep it like that.
DELETE FROM synth_recipes WHERE ID = "3637" AND ResultName = "Sealord Leather"; -- OOE. 2014.
DELETE FROM synth_recipes WHERE ID = "4276" AND ResultName = "Sealord Leather"; -- OOE. 2014.

-- -------------
-- CLOTHCRAFT --
-- -------------
UPDATE synth_recipes SET Desynth = "1" WHERE ID = "538" AND ResultName = "Grass Thread"; -- Yagudo Necklace should be a desynth.
UPDATE synth_recipes SET Leather = "20" WHERE ID = "2567" AND ResultName = "Garish Mitts"; -- Can't find a single source confirming LTW 12. Leaving it as 20 as per FFXIWIKI.
UPDATE synth_recipes SET Cloth = "39" WHERE ID = "1258" AND ResultName = "Mohbwa Cloth"; -- Changing to Cloth 39. Couldn't find a single source for 42.
UPDATE synth_recipes SET Ingredient4 = "829", Ingredient5 = "829" WHERE ID = "1832" AND ResultName = "Silk Hat"; -- Couple websites include Silk Clothx2.
UPDATE synth_recipes SET Gold = "53", Ingredient4 = "816", Ingredient5 = "816", Ingredient6 = "816", ResultHQ1Qty = "12", ResultHQ2Qty = "12", ResultHQ3Qty = "12" WHERE ID = "1330" AND ResultName = "Platinum Silk"; -- Added GS 53 requirement. Gold thread changed to Silk thread. Also HQ1+ quantities changed to 12.
UPDATE synth_recipes SET Gold = "19" WHERE ID = "1951" AND ResultName = "Silk Cuffs"; -- No data on GS level. Adjusting to FFXIWIKI level (19).
UPDATE synth_recipes SET Gold = "19" WHERE ID = "2580" AND ResultName = "Silken Cuffs"; -- No data on GS level. Adjusting to FFXIWIKI level (19).
UPDATE synth_recipes SET gold = "11" WHERE ID ="2005"; -- updates wool slop SYNTH GoldSmithing subcraft level
UPDATE synth_recipes SET gold = "11" WHERE ID ="7016"; -- updates wool slop DESYNTH GoldSmithing subcraft level
DELETE FROM synth_recipes WHERE ID = "4569" AND ResultName = "Giant Bird Fletchings"; -- Duplicated entry of ID 1015.
DELETE FROM synth_recipes WHERE ID = "4570" AND ResultName = "Giant Bird Fletchings"; -- Duplicated entry of ID 1016.
DELETE FROM synth_recipes WHERE ID = "3616" AND ResultName = "Areion Boots"; -- OOE. 2012.

-- ------------
-- BONECRAFT --
-- ------------
UPDATE synth_recipes SET ResultHQ1Qty = "1" WHERE ID = "783" AND ResultName = "Seashell"; -- HQ1 should give one unit as per BGWiki and FFXIclopedia.
UPDATE synth_recipes SET ResultHQ2 = "17846" WHERE ID = "3139" AND ResultName = "Cornette"; -- Making HQ2 a +2 as per FFXIwiki and Allakhazam.
UPDATE synth_recipes SET ResultHQ2 = "850", ResultHQ3 = "850" WHERE ID = "767" AND ResultName = "Bone Chip"; -- HQ2 and HQ3 should drop Sheep Leather.
UPDATE synth_recipes SET Result = "17296", ResultHQ1 = "792" WHERE ID = "3085" AND ResultName = "Pearl"; -- Pearl should not be normal desynth but HQ1
UPDATE synth_recipes SET Result = "17296", ResultHQ1 = "792" WHERE ID = "3086" AND ResultName = "Pearl"; -- Pearl should not be normal desynth but HQ1
UPDATE synth_recipes SET Bone = "28" WHERE ID = "1816" AND ResultName = "Beetle Mask"; -- Most sites list this as lvl 28. Changing to that.
UPDATE synth_recipes SET ResultHQ2 = "894", ResultHQ3 = "894" WHERE ID = "719" AND ResultName = "Lizard Skin"; -- Adding Bettle Jaw as HQ2/HQ3.
UPDATE synth_recipes SET Wood = "58" WHERE ID = "3322" AND ResultName = "Mandibular Sickle"; -- Woodworking should be 58 as per FFXIAH
UPDATE synth_recipes SET Bone = "51" WHERE ID = "3020" AND ResultName = "Bone Rod"; -- Most websites list it as 51 craft. Changing.
UPDATE synth_recipes SET Gold = "31" WHERE ID = "2688" AND ResultName = "Wivre ring"; -- Although not 100% confirmed this should have GS sub. BGWiki lists 31.
UPDATE synth_recipes SET ResultName = "Gavial Cuisses (desynth)" WHERE ResultName = "GavialCuissesDesynth"; -- Unifying names for desynths.
UPDATE synth_recipes SET ResultName = "Gavial Cuisses+1 (desynth)" WHERE ResultName = "GavialCuisses+1Desynth"; -- Unifying names for desynths.

-- -----------
-- SMITHING --
-- -----------
UPDATE synth_recipes SET Smith = "7" WHERE ID = "2041" AND ResultName = "Bronze Leggings"; -- Should be 7 and not 2
UPDATE synth_recipes SET ResultName = "Bronze Subligar Desynth (desynth)" WHERE ResultName = "Bronze Subligar Desynth"; -- Unifying names for desynths.
UPDATE synth_recipes SET ResultHQ2 = "666", ResultHQ3 = "666" WHERE ID = "252" AND ResultName = "Bronze Sheet"; -- Goblin Helm wind desynth shouldn't give Steel Ingot but Steel sheets 
UPDATE synth_recipes SET Result = "16593", ResultHQ1 = "16593", ResultHQ2 = "16593", ResultHQ3 = "16593", ResultName = "Plain Sword" WHERE ID = "2881"; -- This is "Plain Sword" recipe and not "Two-Handed Sword"
UPDATE synth_recipes SET Result = "17955", ResultHQ1 = "17955", ResultHQ2 = "17955", ResultHQ3 = "17955", ResultName = "Plain Pick" WHERE ID = "3299"; -- This is "Plain Pick" recipe and not "War Pick"
UPDATE synth_recipes SET Result = "16110", ResultHQ1 = "16110", ResultHQ2 = "16110", ResultHQ3 = "16110", ResultName = "Padded Cap" WHERE ID = "2719"; -- This is "Plain Cap" recipe and not "Padded Cap"
UPDATE synth_recipes SET Result = "853", ResultHQ1 = "716" WHERE ID = "237" AND ResultName = "Mythril Ingot" ; -- Normal result and HQ1 should be Raptor Skin and Oak Lumber
UPDATE synth_recipes SET Alchemy = "51", Smith = "0" WHERE ID = "864" AND ResultName = "Animal Glue" ; -- This should be an Alchemy desynth.
UPDATE synth_recipes SET Crystal = "4098", HQCrystal = "4240" WHERE ID = "3130" AND ResultName = "Darksteel Bolt" ; -- This should use wind crystal and not fire
UPDATE synth_recipes SET Gold = "41" WHERE ID = "3424" AND ResultName = "Dark Amood" ; -- Not reliable data out there, but unlikely this is a Goldsmith 1 requirement
UPDATE synth_recipes SET ResultHQ2 = "655", ResultHQ3 = "655" WHERE ID = "240" AND ResultName ="Darksteel Ingot"; -- Adding Adaman Ore has HQ2/3 desynth options
UPDATE synth_recipes SET Gold = "60" WHERE ID = "1317" AND ResultName = "Cursed Helm" ; -- Matching GS requirement from FFXIciclopedia
UPDATE synth_recipes SET Smith = "100" WHERE ID = "1318" AND ResultName = "C. Breastplate" ; -- Cursed Breastplate is listed as Smithing 100 in most sites
DELETE FROM synth_recipes WHERE ID = "164" AND ResultName = "Bronze Ingot"; -- Not much data about Lgn. Knuckles desynth. Deleting for now.
DELETE FROM synth_recipes WHERE ID = "220" AND ResultName = "Iron Ingot"; -- Time Hammer desynth level isn't confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "436" AND ResultName = "Silver Ingot"; -- Curtana level desynth not confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "168" AND ResultName = "Bronze Ingot"; -- Ancient Sword level desynth not confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "171" AND ResultName = "Bronze Ingot"; -- Royal Archer's Sword level desynth not confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "575" AND ResultName = "Grass Thread"; -- Plantreaper level desynth not confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "174" AND ResultName = "Bronze Ingot"; -- Cougar Baghnakhs level desynth not confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "802" AND ResultName = "Ram Horn"; -- Kaiser Sword level desynth not confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "219" AND ResultName = "Iron Ingot"; -- Decurion's Dagger level desynth not confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "175" AND ResultName = "Moth Axe"; -- Moth Axe level desynth not confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "3516" AND ResultName = "Iron Ingot"; -- OOE. Orc Helmet is a WOTG item.
DELETE FROM synth_recipes WHERE ID = "3517" AND ResultName = "Iron Ingot"; -- OOE. Orc Pauldron is a WOTG item.
DELETE FROM synth_recipes WHERE ID = "389" AND ResultName = "Mahogany Lbr."; -- Huge Moth Axe level desynth not confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "144" AND ResultName = "Bronze Ingot"; -- Goblin Cup level desynth not confirmed anywhere. Removing for now.
DELETE FROM synth_recipes WHERE ID = "4375" AND ResultName = "Armor Plate Iii"; -- OOE. Added in 2015.
DELETE FROM synth_recipes WHERE ID = "3514" AND ResultName = "Steel Ingot"; -- OOE. Heavy Quadav Backplate is a WOTG item.
DELETE FROM synth_recipes WHERE ID = "3515" AND ResultName = "Steel Ingot"; -- OOE. Heavy Quadav Chestplate is a WOTG item.
DELETE FROM synth_recipes WHERE ID = "4394" AND ResultName = "Uruz Blade"; -- OOE. Added in 2020.
DELETE FROM synth_recipes WHERE ID = "3922" AND ResultName = "Damascus Ingot"; -- OOE. Added in 2014.
DELETE FROM synth_recipes WHERE ID = "4431" AND ResultName = "Ber. Arrowheads"; -- OOE. Added in 2014.
DELETE FROM synth_recipes WHERE ID = "4432" AND ResultName = "Ber. Bolt Heads"; -- OOE. Added in 2014.

-- ---------------
-- GOLDSMITHING --
-- ---------------
DELETE FROM synth_recipes WHERE ID = "934" AND ResultName = "Mythril Nugget"; -- Mythril Mace should be a Smithing desynth
DELETE FROM synth_recipes WHERE ID = "4163" AND ResultName = "Aquamarine"; -- OOE. 2014.
DELETE FROM synth_recipes WHERE ID = "4165" AND ResultName = "Oberons Sainti"; -- OOE. 2014.
DELETE FROM synth_recipes WHERE ID = "4166" AND ResultName = "Oberons Knuckles"; -- OOE. 2014.
DELETE FROM synth_recipes WHERE ID = "4183" AND ResultName = "Translucent Rock"; -- OOE. 2013 (Marble Nugget).
DELETE FROM synth_recipes WHERE ID = "4184" AND ResultName = "Accelerator Iii"; -- OOE. 2015.
DELETE FROM synth_recipes WHERE ID = "4185" AND ResultName = "Mana Jammer Iii"; -- OOE. 2015.
DELETE FROM synth_recipes WHERE ID = "4187" AND ResultName = "Mana Tank Iv"; -- OOE. 2018.
DELETE FROM synth_recipes WHERE ID = "4188" AND ResultName = "Accelerator Iv"; -- OOE. 2018.
DELETE FROM synth_recipes WHERE ID = "4189" AND ResultName = "Mana Jammer Iv"; -- OOE. 2018.
UPDATE synth_recipes SET Gold = "20" WHERE ID = "3457" AND ResultName = "Brass Grip"; -- Mixed information. Desynth is 20, so aligning with that.
UPDATE synth_recipes SET ResultHQ2 = "710", ResultHQ3 = "710", ResultHQ2Qty = "1", ResultHQ3Qty = "1" WHERE ID = "179" AND ResultName = "Bronze Ingot"; -- HQ2 and higher should be Chestnut Lumber.
UPDATE synth_recipes SET ResultHQ2 = "14692", ResultHQ3 = "14692" WHERE ID = "2148" AND ResultName = "Lapis Laz. Earring"; -- HQ2 and HQ3 should be Tranq. Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14689", ResultHQ3 = "14689" WHERE ID = "2142" AND ResultName = "Sardonyx Earring"; -- HQ2 and HQ3 should be Courage Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14695", ResultHQ3 = "14695" WHERE ID = "2154" AND ResultName = "Opal Earring"; -- HQ2 and HQ3 should be Hope Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14690", ResultHQ3 = "14690" WHERE ID = "2144" AND ResultName = "Clear Earring"; -- HQ2 and HQ3 should be Knowledge Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14691", ResultHQ3 = "14691" WHERE ID = "2146" AND ResultName = "Amethyst Earring"; -- HQ2 and HQ3 should be Balance Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14693", ResultHQ3 = "14693" WHERE ID = "2150" AND ResultName = "Amber Earring"; -- HQ2 and HQ3 should be Stamina Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14694", ResultHQ3 = "14694" WHERE ID = "2152" AND ResultName = "Onyx Earring"; -- HQ2 and HQ3 should be Energy Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14688", ResultHQ3 = "14688" WHERE ID = "2140" AND ResultName = "Tml. Earring"; -- HQ2 and HQ3 should be Reflex Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14599", ResultHQ3 = "14599" WHERE ID = "2199" AND ResultName = "Opal Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14593", ResultHQ3 = "14593" WHERE ID = "2201" AND ResultName = "Sardonyx Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14592", ResultHQ3 = "14592" WHERE ID = "2234" AND ResultName = "Tourmaline Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14594", ResultHQ3 = "14594" WHERE ID = "2237" AND ResultName = "Clear Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14595", ResultHQ3 = "14595" WHERE ID = "2239" AND ResultName = "Amethyst Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14596", ResultHQ3 = "14596" WHERE ID = "2241" AND ResultName = "Lapis Lazuli Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14597", ResultHQ3 = "14597" WHERE ID = "2243" AND ResultName = "Amber Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14598", ResultHQ3 = "14598" WHERE ID = "2245" AND ResultName = "Onyx Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET Result = "818" WHERE ID = "494" AND ResultName = "Sardonyx"; -- Per Allakhazam comments regular result is Cotton Thread and not Sardonyx
UPDATE synth_recipes SET ResultHQ2 = "14703", ResultHQ3 = "14703" WHERE ID = "2124" AND ResultName = "Pearl Earring"; -- HQ2 and HQ3 should be Tranq. Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14696", ResultHQ3 = "14696" WHERE ID = "2129" AND ResultName = "Peridot Earring"; -- HQ2 and HQ3 should be Courage Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14702", ResultHQ3 = "14702" WHERE ID = "2130" AND ResultName = "Black Earring"; -- HQ2 and HQ3 should be Hope Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14697", ResultHQ3 = "14697" WHERE ID = "2156" AND ResultName = "Blood Earring"; -- HQ2 and HQ3 should be Knowledge Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14698", ResultHQ3 = "14698" WHERE ID = "2158" AND ResultName = "Goshenite Earring"; -- HQ2 and HQ3 should be Balance Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14699", ResultHQ3 = "14699" WHERE ID = "2160" AND ResultName = "Ametrine Earring"; -- HQ2 and HQ3 should be Stamina Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14700", ResultHQ3 = "14700" WHERE ID = "2162" AND ResultName = "Turquoise Earring"; -- HQ2 and HQ3 should be Energy Earring+1.
UPDATE synth_recipes SET ResultHQ2 = "14701", ResultHQ3 = "14701" WHERE ID = "2164" AND ResultName = "Sphene Earring"; -- HQ2 and HQ3 should be Reflex Earring+1.
UPDATE synth_recipes SET Gold = "46" WHERE ID = "709" AND ResultName = "Ram Leather"; -- Sollerets desynth. Should match level of craft.
UPDATE synth_recipes SET ResultHQ2 = "14600", ResultHQ3 = "14600" WHERE ID = "2247" AND ResultName = "Peridot Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14601", ResultHQ3 = "14601" WHERE ID = "2249" AND ResultName = "Garnet Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14602", ResultHQ3 = "14602" WHERE ID = "2251" AND ResultName = "Goshenite Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14603", ResultHQ3 = "14603" WHERE ID = "2253" AND ResultName = "Ametrine Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14604", ResultHQ3 = "14604" WHERE ID = "2255" AND ResultName = "Turquoise Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14605", ResultHQ3 = "14605" WHERE ID = "2257" AND ResultName = "Sphene Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14606", ResultHQ3 = "14606" WHERE ID = "2259" AND ResultName = "Black Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14607", ResultHQ3 = "14607" WHERE ID = "2261" AND ResultName = "Pearl Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ1Qty = "3", ResultHQ2Qty = "3", ResultHQ3Qty = "3" WHERE ID = "233" AND ResultName = "Mythril Ingot"; -- HQ1 onwards should give 3 ingots (Wing Gorget desynth).
UPDATE synth_recipes SET Smith = "31" WHERE ID = "816" AND ResultName = "Mercury"; -- Adding sub-craft requirement to "Chakram" desynth.
UPDATE synth_recipes SET Crystal = "4098", HQCrystal = "4240" WHERE ID = "1116" AND ResultName = "Vivio Platinum"; -- Most sites list it with Wind instead of Fire crystal.
UPDATE synth_recipes SET ResultHQ2 = "14704", ResultHQ3 = "14704" WHERE ID = "2166" AND ResultName = "Green Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14705", ResultHQ3 = "14705" WHERE ID = "2168" AND ResultName = "Sun Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14706", ResultHQ3 = "14706" WHERE ID = "2170" AND ResultName = "Zircon Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14707", ResultHQ3 = "14707" WHERE ID = "2172" AND ResultName = "Purple Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14708", ResultHQ3 = "14708" WHERE ID = "2174" AND ResultName = "Aquamrne. Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14709", ResultHQ3 = "14709" WHERE ID = "2176" AND ResultName = "Yellow Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14710", ResultHQ3 = "14710" WHERE ID = "2178" AND ResultName = "Night Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14711", ResultHQ3 = "14711" WHERE ID = "2180" AND ResultName = "Moon Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2Qty = "2", ResultHQ3Qty = "2" WHERE ID = "447" AND ResultName = "Platinum Ingot"; -- HQ2 onwards should give 2 ingots (Platinum Earring desynth).
UPDATE synth_recipes SET ResultHQ3 = "745" WHERE ID = "3540" AND ResultName = "Gold Ingot"; -- HQ3 should be Gold Ingot (Gold Bangles desynth).
UPDATE synth_recipes SET ResultHQ3 = "745" WHERE ID = "3541" AND ResultName = "Gold Ingot"; -- HQ3 should be Gold Ingot (Gold Bangles+1 desynth).
UPDATE synth_recipes SET Gold = "71" WHERE ID = "815" AND ResultName = "Mercury"; -- Gold Cuisses desynth should be same level as synth.
UPDATE synth_recipes SET Gold = "78" WHERE ID = "929" AND ResultName = "Gold Nugget"; -- Matching level requirement from FFXIciclopedia.
UPDATE synth_recipes SET ResultHQ2 = "14608", ResultHQ3 = "14608" WHERE ID = "2263" AND ResultName = "Jadeite Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14609", ResultHQ3 = "14609" WHERE ID = "2265" AND ResultName = "Sun Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14610", ResultHQ3 = "14610" WHERE ID = "2267" AND ResultName = "Zircon Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14611", ResultHQ3 = "14611" WHERE ID = "2269" AND ResultName = "Fluorite Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14612", ResultHQ3 = "14612" WHERE ID = "2271" AND ResultName = "Aquamarine Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14613", ResultHQ3 = "14613" WHERE ID = "2273" AND ResultName = "Chrysoberyl Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14614", ResultHQ3 = "14614" WHERE ID = "2275" AND ResultName = "Painite Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14615", ResultHQ3 = "14615" WHERE ID = "2277" AND ResultName = "Moon Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "746", ResultHQ3 = "746" WHERE ID = "448" AND ResultName = "Platinum Ingot"; -- Ruby Earring desynth should give Platinum Ingot at HQ2/HQ3.
UPDATE synth_recipes SET ResultHQ2 = "14717", ResultHQ3 = "14717" WHERE ID = "2126" AND ResultName = "Topaz Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14712", ResultHQ3 = "14712" WHERE ID = "2182" AND ResultName = "Emerald Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14713", ResultHQ3 = "14713" WHERE ID = "2184" AND ResultName = "Ruby Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14714", ResultHQ3 = "14714" WHERE ID = "2186" AND ResultName = "Diamond Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14715", ResultHQ3 = "14715" WHERE ID = "2188" AND ResultName = "Spinel Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14716", ResultHQ3 = "14716" WHERE ID = "2190" AND ResultName = "Sapphire Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14718", ResultHQ3 = "14718" WHERE ID = "2192" AND ResultName = "Death Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14719", ResultHQ3 = "14719" WHERE ID = "2194" AND ResultName = "Angels Earring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "746", ResultHQ3 = "746", ResultHQ3Qty = "2" WHERE ID = "4535" AND ResultName = "Platinum Ingot"; -- Death Earring desynth should give Platinum Ingot at HQ2/HQ3.
UPDATE synth_recipes SET Ingredient8 = "810" WHERE ID = "55" AND ResultName = "Buckler Plaque"; -- Should be Fluorite x2
UPDATE synth_recipes SET ResultHQ2 = "14617", ResultHQ3 = "14617" WHERE ID = "2206" AND ResultName = "Emerald Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14618", ResultHQ3 = "14618" WHERE ID = "2208" AND ResultName = "Ruby Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14619", ResultHQ3 = "14619" WHERE ID = "2210" AND ResultName = "Diamond Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14620", ResultHQ3 = "14620" WHERE ID = "2212" AND ResultName = "Spinel Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14621", ResultHQ3 = "14621" WHERE ID = "2214" AND ResultName = "Sapphire Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14622", ResultHQ3 = "14622" WHERE ID = "2216" AND ResultName = "Topaz Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14623", ResultHQ3 = "14623" WHERE ID = "2226" AND ResultName = "Death Ring"; -- HQ2 and HQ3 should be +1 version.
UPDATE synth_recipes SET ResultHQ2 = "14624", ResultHQ3 = "14624" WHERE ID = "2228" AND ResultName = "Angels Ring"; -- HQ2 and HQ3 should be +1 version.

-- ----------
-- ALCHEMY --
-- ----------
UPDATE synth_recipes SET Ingredient3 = "928" WHERE ID = "3834" AND ResultName = "Sairui-ran"; -- Should use Bomb Ash and not Djiin Ash.
UPDATE synth_recipes SET ResultHQ2 = "933", ResultHQ3 = "933" WHERE ID = "863" AND ResultName = "Animal Glue"; -- Shrimp Lure desynth should give Glass Fiber on HQ2/3
UPDATE synth_recipes SET ResultHQ1Qty = "99" WHERE ID = "3441" AND ResultName = "Steel Bullet"; -- HQ1 should give 99 bullets.
UPDATE synth_recipes SET Ingredient6 = "928", Ingredient7 = "928", Ingredient8 = "947" WHERE ID = "3099" AND ResultName = "Grenade"; -- Was missing 3 of the ingredients.
UPDATE synth_recipes SET Ingredient6 = "928", Ingredient7 = "928", Ingredient8 = "947" WHERE ID = "3100" AND ResultName = "Grenade"; -- Was missing 3 of the ingredients.
UPDATE synth_recipes SET Ingredient6 = "1108" WHERE ID = "3101" AND ResultName = "Grenade"; -- Was missing 1 of the ingredients.
UPDATE synth_recipes SET ResultHQ2 = "1226", ResultHQ3 = "1226", ResultHQ2Qty = "10", ResultHQ3Qty = "10" WHERE ID = "1388" AND ResultName = "Holy Water"; -- Holy Sword desynth. Should give Mythril Nugget on HQ2/3.
UPDATE synth_recipes SET ResultHQ2 = "933", ResultHQ3 = "933" WHERE ID = "710" AND ResultName = "Ram Leather"; -- Suzaku Sune-Ate desynth should give Glass Fiber on HQ2/3
UPDATE synth_recipes SET Alchemy = "88" WHERE ID = "1299" AND ResultName = "Viper Dust"; -- Most websites list this as 88.
UPDATE synth_recipes SET ResultHQ2 = "1226", ResultHQ3 = "1226", ResultHQ2Qty = "10", ResultHQ3Qty = "10" WHERE ID = "1652" AND ResultName = "Hallowed Water"; -- Sacred Lance desynth should give Mythril Nugget on HQ2/3
UPDATE synth_recipes SET ResultHQ2 = "866", ResultHQ3 = "866", ResultHQ2Qty = "2", ResultHQ3Qty = "2" WHERE ID = "749" AND ResultName = "Wyvern Scales"; -- Cursed Mail desynth should give Wyvern Scales on HQ2/3.
DELETE FROM synth_recipes WHERE ID = "4549" AND ResultName = "Miasmal Counteragent"; -- OOE. 2010.
DELETE FROM synth_recipes WHERE ID = "662" AND ResultName = "Genbus Kabuto"; -- Not much info about this desynth. Removing for now.
DELETE FROM synth_recipes WHERE ID = "3376" AND ResultName = "Leucous Voulge"; -- OOE. 2020.
DELETE FROM synth_recipes WHERE ID = "3453" AND ResultName = "Spirit Maul"; -- Barely any historical trace of this item. Removing for now.
DELETE FROM synth_recipes WHERE ID = "3801" AND ResultName = "Resolution Ring"; -- OOE. 2014.
DELETE FROM synth_recipes WHERE ID = "3800" AND ResultName = "Regulator"; -- OOE. 2018.
DELETE FROM synth_recipes WHERE ID = "2780" AND ResultName = "Stun Jamadhars"; -- OOE. 2013.
DELETE FROM synth_recipes WHERE ID = "3764" AND ResultName = "Elixir Tank"; -- OOE. 2008.
DELETE FROM synth_recipes WHERE ID = "96" AND ResultName = "San. Tea Set"; -- OOE. 2008.


-- Adding sub-craft requirements to desynths

UPDATE synth_recipes SET Bone = "1" WHERE ID = "343" AND ResultName = "Yew Lumber"; -- Longbow. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "14" WHERE ID = "342" AND ResultName = "Yew Lumber"; -- Darksteel Scythe. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "2" WHERE ID = "302" AND ResultName = "Lauan Lumber"; -- Lauan Shield. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "2" WHERE ID = "317" AND ResultName = "Maple Lumber"; -- Maple Shield. Desynth should include subcraft levels.
UPDATE synth_recipes SET Bone = "5" WHERE ID = "337" AND ResultName = "Willow Lumber"; -- Self Bow. Desynth should include subcraft levels.
UPDATE synth_recipes SET Bone = "1" WHERE ID = "343" AND ResultName = "Yew Lumber"; -- Longbow. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "9" WHERE ID = "367" AND ResultName = "Ash Lumber"; -- Bronze Spear. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "6" WHERE ID = "699" AND ResultName = "Sheep Leather"; -- Wrapped Bow. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "10" WHERE ID = "737" AND ResultName = "Rabbit Hide"; -- Bolt Belt. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "19" WHERE ID = "824" AND ResultName = "Coeurl Whisker"; -- Zamburak. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "11" WHERE ID = "221" AND ResultName = "Iron Ingot"; -- Quarterstaff. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "14" WHERE ID = "176" AND ResultName = "Bronze Ingot"; -- Great Club. Desynth should include subcraft levels.
UPDATE synth_recipes SET Alchemy = "25" WHERE ID = "535" AND ResultName = "Silk Thread"; -- War Bow. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "28" WHERE ID = "850" AND ResultName = "Carbon Fiber"; -- Arbalest. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "37" WHERE ID = "369" AND ResultName = "Ash Lumber"; -- Partisan. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "18" WHERE ID = "941" AND ResultName = "Iron Nugget"; -- Hickory Shield. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "19" WHERE ID = "212" AND ResultName = "Iron Ingot"; -- Round Shield. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "21" WHERE ID = "330" AND ResultName = "Walnut Lumber"; -- Battle Staff. Desynth should include subcraft levels.
UPDATE synth_recipes SET Alchemy = "57" WHERE ID = "3501" AND ResultName = "Ash Lumber"; -- Cermet Lance. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "59", Bone = "46" WHERE ID = "398" AND ResultName = "Rosewood Lbr."; -- Rpt. Crossbow. Desynth should include subcraft levels.
UPDATE synth_recipes SET Bone = "41" WHERE ID = "626" AND ResultName = "Rainbow Thread"; -- Gendawa. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "31" WHERE ID = "329" AND ResultName = "Walnut Lumber"; -- Eight-Sided Pole. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "60" WHERE ID = "331" AND ResultName = "Walnut Lumber"; -- Iron-Splitter. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "60" WHERE ID = "332" AND ResultName = "Walnut Lumber"; -- Steel-Splitter. Desynth should include subcraft levels.
UPDATE synth_recipes SET Alchemy = "21" WHERE ID = "468" AND ResultName = "Yellow Rock"; -- Kinkobo. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "10" WHERE ID = "721" AND ResultName = "Lizard Skin"; -- Iron Mittens. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "15" WHERE ID = "381" AND ResultName = "Oak Lumber"; -- Heavy Axe. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "3" WHERE ID = "149" AND ResultName = "Bronze Ingot"; -- Bronze Cap. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "3" WHERE ID = "155" AND ResultName = "Bronze Ingot"; -- Bronze Mittens. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "2" WHERE ID = "363" AND ResultName = "Ash Lumber"; -- Bronze Axe. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "6" WHERE ID = "574" AND ResultName = "Grass Thread"; -- Bronze Zaghnal. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "3" WHERE ID = "157" AND ResultName = "Bronze Subligar Desynth"; -- Bronze Subligar. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "3" WHERE ID = "151" AND ResultName = "Bronze Ingot"; -- Bronze Harness. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "5" WHERE ID = "156" AND ResultName = "Bronze Ingot"; -- Scale Cuisses. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "1" WHERE ID = "348" AND ResultName = "Holly Lumber"; -- Metal Knuckles. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "10" WHERE ID = "281" AND ResultName = "Bronze Scales"; -- Pellet Belt. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "5" WHERE ID = "319" AND ResultName = "Maple Lumber"; -- Butterfly Axe. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "6" WHERE ID = "204" AND ResultName = "Brass Ingot"; -- Scimitar. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "7" WHERE ID = "433" AND ResultName = "Silver Ingot"; -- Bilbo. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "5" WHERE ID = "705" AND ResultName = "Ram Leather"; -- Chain Mittens. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "16", Leather = "2" WHERE ID = "361" AND ResultName = "Ash Lumber"; -- Claymore. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "33" WHERE ID = "310" AND ResultName = "Elm Lumber"; -- Warhammer. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "5" WHERE ID = "694" AND ResultName = "Sheep Leather"; -- Iron Cuisses. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "16", Leather = "5" WHERE ID = "726" AND ResultName = "Lizard Skin"; -- Wakizashi. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "13" WHERE ID = "4576" AND ResultName = "Eisendiechlings_Desynth"; -- Eisendiechlings. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "6" WHERE ID = "366" AND ResultName = "Ash Lumber"; -- War Pick. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "19" WHERE ID = "435" AND ResultName = "Silver Ingot"; -- Fleuret. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "9" WHERE ID = "718" AND ResultName = "Lizard Skin"; -- Padded Cap. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "15" WHERE ID = "381" AND ResultName = "Oak Lumber"; -- Heavy Axe. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "10" WHERE ID = "721" AND ResultName = "Lizard Skin"; -- Iron Mittens. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "13", Leather = "2" WHERE ID = "727" AND ResultName = "Lizard Skin"; -- Shinobi-Gatana. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "21", Gold = "19" WHERE ID = "3530" AND ResultName = "Bronze Ingot"; -- Musketoon. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "12" WHERE ID = "324" AND ResultName = "Chestnut Lumber"; -- Mythril Knuckles. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "12" WHERE ID = "722" AND ResultName = "Lizard Skin"; -- Iron Subligar. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "8" WHERE ID = "309" AND ResultName = "Elm Lumber"; -- Mythril Pick. Desynth should include subcraft levels.
UPDATE synth_recipes SET Bone = "13" WHERE ID = "794" AND ResultName = "Beetle Jaw"; -- Mythril Claws. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "40", Gold = "13" WHERE ID = "227" AND ResultName = "Steel Ingot"; -- Arquebus. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "18", Leather = "4" WHERE ID = "135" AND ResultName = "Copper Ingot"; -- Uchigatana. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "5" WHERE ID = "695" AND ResultName = "Sheep Leather"; -- Steel Cuisses. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "33", Gold = "16" WHERE ID = "3528" AND ResultName = "Steel Ingot"; -- Marss Hexagun. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "19" WHERE ID = "577" AND ResultName = "Grass Thread"; -- Mythril Zaghnal. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "51", Cloth = "1" WHERE ID = "533" AND ResultName = "Silk Thread"; -- Alumine Haubert. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "25" WHERE ID = "241" AND ResultName = "Darksteel Ingot"; -- Odorous Knife. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "41" WHERE ID = "731" AND ResultName = "Tiger Leather"; -- Darksteel Mittens. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "8" WHERE ID = "4530" AND ResultName = "Elm Lumber"; -- Darksteel Pick. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "14" WHERE ID = "342" AND ResultName = "Yew Lumber"; -- Darksteel Scythe. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "51" WHERE ID = "4568" AND ResultName = "RisingSunDesynth"; -- Rising Sun. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "15" WHERE ID = "228" AND ResultName = "Steel Ingot"; -- Kanesada +1. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "50", Gold = "54" WHERE ID = "205" AND ResultName = "Brass Ingot"; -- Hellfire. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "14", Alchemy = "59" WHERE ID = "341" AND ResultName = "Yew Lumber"; -- Death Scythe. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "42", Gold = "44" WHERE ID = "943" AND ResultName = "Steel Nugget"; -- Bhuj. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "54", Gold = "23" WHERE ID = "4537" AND ResultName = "Brass Nugget"; -- Culverin. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "60" WHERE ID = "814" AND ResultName = "Mercury"; -- Adaman Gauntlets. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "60" WHERE ID = "3741" AND ResultName = "Tiger Leather"; -- Adaman Cuirass. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "6" WHERE ID = "136" AND ResultName = "Copper Ingot"; -- Sabiki Rig. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "14" WHERE ID = "128" AND ResultName = "Copper Ingot"; -- Banded Helm. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "21" WHERE ID = "216" AND ResultName = "Iron Ingot"; -- Mythril Degen. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "31" WHERE ID = "816" AND ResultName = "Mercury"; -- Chakram. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "34", Bone = "50" WHERE ID = "945" AND ResultName = "Steel Nugget"; -- Shotel. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "53" WHERE ID = "817" AND ResultName = "Mercury"; -- Moonring Blade. Desynth should include subcraft levels.
UPDATE synth_recipes SET Alchemy = "54" WHERE ID = "708" AND ResultName = "Ram Leather"; -- Gold Sabatons. Desynth should include subcraft levels.
UPDATE synth_recipes SET Alchemy = "54" WHERE ID = "670" AND ResultName = "Sheep Leather"; -- Gold Gauntlets. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "28" WHERE ID = "225" AND ResultName = "Steel Ingot"; -- Rapier. Desynth should include subcraft levels.
UPDATE synth_recipes SET Alchemy = "41" WHERE ID = "704" AND ResultName = "Ram Leather"; -- Cursed Diechlings. Desynth should include subcraft levels.
UPDATE synth_recipes SET Alchemy = "41" WHERE ID = "843" AND ResultName = "Cermet Chunk"; -- Cursed Schuhs. Desynth should include subcraft levels.
UPDATE synth_recipes SET Alchemy = "41" WHERE ID = "842" AND ResultName = "Cermet Chunk"; -- C. Handschuhs. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "58" WHERE ID = "936" AND ResultName = "Dst. Nugget"; -- Koenig Shield. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "51", Alchemy = "41" WHERE ID = "126" AND ResultName = "Copper Ingot"; -- Cursed Schaller. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "53" WHERE ID = "443" AND ResultName = "Gold Ingot"; -- Verdun. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "3" WHERE ID = "303" AND ResultName = "Lauan Lumber"; -- Tekko. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "9" WHERE ID = "4574" AND ResultName = "TradersChapeau_Desynth"; -- Traders Chapeau. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "6" WHERE ID = "304" AND ResultName = "Lauan Lumber"; -- Cotton Tekko. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "9" WHERE ID = "1103" AND ResultName = "Red Grs. Thread"; -- Traders Cuffs. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "9" WHERE ID = "590" AND ResultName = "Cotton Thread"; -- Linen Cuffs. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "9" WHERE ID = "1105" AND ResultName = "Red Grs. Thread"; -- Traders Slops. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "20" WHERE ID = "598" AND ResultName = "Cotton Thread"; -- Seers Mitts. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "20" WHERE ID = "622" AND ResultName = "Wool Thread"; -- Seers Slacks. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "9" WHERE ID = "1104" AND ResultName = "Red Grs. Thread"; -- Traders Saio. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "20" WHERE ID = "609" AND ResultName = "Linen Thread"; -- Noct Gloves. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "20" WHERE ID = "608" AND ResultName = "Linen Thread"; -- Noct Doublet. Desynth should include subcraft levels.
UPDATE synth_recipes SET Bone = "8" WHERE ID = "786" AND ResultName = "Bat Fang"; -- Fly Lure. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "8" WHERE ID = "191" AND ResultName = "Brass Ingot"; -- Velvet Hat. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "8" WHERE ID = "614" AND ResultName = "Wool Thread"; -- Velvet Slops. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "52" WHERE ID = "629" AND ResultName = "Silver Thread"; -- Silk Hat. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "20" WHERE ID = "519" AND ResultName = "Silk Thread"; -- Jesters Cape. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "49" WHERE ID = "525" AND ResultName = "Silk Thread"; -- Arhats Tekko. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "21" WHERE ID = "523" AND ResultName = "Silk Thread"; -- Arhats Gi. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "43", Leather = "43" WHERE ID = "527" AND ResultName = "Silk Thread"; -- Rasetsu Sune-Ate. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "26" WHERE ID = "713" AND ResultName = "Ram Leather"; -- Errant Slops. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "41", Leather = "41" WHERE ID = "937" AND ResultName = "Dst. Nugget"; -- Yasha Tekko. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "41", Leather = "35" WHERE ID = "514" AND ResultName = "Silk Thread"; -- Yasha Hakama. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "50", Leather = "30" WHERE ID = "530" AND ResultName = "Silk Thread"; -- Errant Hpl. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "41", Leather = "35" WHERE ID = "697" AND ResultName = "Sheep Leather"; -- Rst. Hakama. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "24", Leather = "26" WHERE ID = "526" AND ResultName = "Silk Thread"; -- Errant Cuffs. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "52", Leather = "48" WHERE ID = "733" AND ResultName = "Tiger Leather"; -- Rasetsu Samue. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "1" WHERE ID = "357" AND ResultName = "Ash Lumber"; -- Cesti. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "27" WHERE ID = "698" AND ResultName = "Sheep Leather"; -- Noct Brais. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "48", Gold = "50" WHERE ID = "685" AND ResultName = "Sheep Leather"; -- Brigandine. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "55" WHERE ID = "730" AND ResultName = "Tiger Leather"; -- War Beret. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "54" WHERE ID = "1071" AND ResultName = "H.q. Bugard Skin"; -- Barone Cosciales. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "52" WHERE ID = "528" AND ResultName = "Silk Thread"; -- Errant Pigaches. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "11" WHERE ID = "691" AND ResultName = "Sheep Leather"; -- Austere Hat. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "21", Smith = "31" WHERE ID = "714" AND ResultName = "Ram Leather"; -- Cardinal Vest. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "41", Gold = "46" WHERE ID = "534" AND ResultName = "Silk Thread"; -- Shair Gages. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "54" WHERE ID = "3747" AND ResultName = "Tiger Leather"; -- Bison Kecks. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "3" WHERE ID = "738" AND ResultName = "Rabbit Hide"; -- Cat Baghnakhs. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "3" WHERE ID = "770" AND ResultName = "Bone Chip"; -- Bone Earring. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "14" WHERE ID = "206" AND ResultName = "Brass Ingot"; -- Cornette. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "5" WHERE ID = "769" AND ResultName = "Bone Chip"; -- Bone Mittens. Desynth should include subcraft levels.
UPDATE synth_recipes SET Wood = "6" WHERE ID = "365" AND ResultName = "Ash Lumber"; -- Bone Pick. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "9" WHERE ID = "720" AND ResultName = "Lizard Skin"; -- Beetle Harness. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "11" WHERE ID = "747" AND ResultName = "Fish Scales"; -- Carapace Mittens. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "12" WHERE ID = "748" AND ResultName = "Fish Scales"; -- Cpc. Leggings. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "12" WHERE ID = "604" AND ResultName = "Linen Thread"; -- Carapace Subligar. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "13" WHERE ID = "776" AND ResultName = "Crab Shell"; -- Carapace Harness. Desynth should include subcraft levels.
UPDATE synth_recipes SET Smith = "47" WHERE ID = "788" AND ResultName = "Giant Femur"; -- Bandits Gun. Desynth should include subcraft levels.
UPDATE synth_recipes SET Cloth = "26" WHERE ID = "785" AND ResultName = "Beetle Shell"; -- Justaucorps. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "32" WHERE ID = "4538" AND ResultName = "Linen Cloth"; -- Scorpion Subligar. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "46" WHERE ID = "605" AND ResultName = "Linen Thread"; -- Coral Subligar. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "48" WHERE ID = "779" AND ResultName = "Coral Fragment"; -- Coral Mittens. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "38" WHERE ID = "112" AND ResultName = "Coeurl Leather"; -- Igqira Tiara. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "53" WHERE ID = "1040" AND ResultName = "Buffalo Leather"; -- Dragon Subligar. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "46", Alchemy = "41" WHERE ID = "896" AND ResultName = "Manticore Hair"; -- Igqira Manillas. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "53" WHERE ID = "750" AND ResultName = "Wyvern Scales"; -- Dragon Leggings. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "26" WHERE ID = "3738" AND ResultName = "Sheep Leather"; -- Gavial Mail. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "1" WHERE ID = "200" AND ResultName = "Brass Ingot"; -- Water Tank. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "11" WHERE ID = "137" AND ResultName = "Copper Ingot"; -- Minnow. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "12" WHERE ID = "207" AND ResultName = "Brass Ingot"; -- Frog Lure. Desynth should include subcraft levels.
UPDATE synth_recipes SET Gold = "21" WHERE ID = "863" AND ResultName = "Animal Glue"; -- Shrimp Lure. Desynth should include subcraft levels.
UPDATE synth_recipes SET Leather = "34" WHERE ID = "199" AND ResultName = "Brass Ingot"; -- Ether Tank. Desynth should include subcraft levels.
UPDATE synth_recipes SET Bone = "16" WHERE ID = "795" AND ResultName = "Beetle Jaw"; -- Cermet Claws. Desynth should include subcraft levels.

