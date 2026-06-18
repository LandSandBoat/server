-- Adjusts the levels of mobs in era to be more appropriate for era content.

UPDATE mob_groups SET content_tag = NULL WHERE content_tag = 'ABYSSEA' OR content_tag = 'ROV';

-- ------------------------------------------------------------
-- Bibiki Bay (Zone 4)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 82, maxLevel = 83 WHERE mobname = 'Locus_Bight_Rarab';
UPDATE mob_spawn_points SET minLevel = 85, maxLevel = 85 WHERE mobname = 'Locus_Camelopard';
UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Locus_Hypnos_Eft';
UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Locus_Ghost_Crab';

-- ------------------------------------------------------------
-- Dynamis - Valkurm (Zone 39)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Hippogryph';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Goobbue';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Sabotender';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Flytrap';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Manticore';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Treant';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Funguar';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Sheep';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Fly';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Footsoldier';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Pillager';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Neckchopper';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Bugler';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Dollmaster';
UPDATE mob_spawn_points SET minLevel = 72, maxLevel = 74 WHERE mobname = 'Vanguards_Avatar';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Grappler';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Mesmerizer';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Predator';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Backstabber';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Hawker';
UPDATE mob_spawn_points SET minLevel = 72, maxLevel = 74 WHERE mobname = 'Vanguards_Hecteyes';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Amputator';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Vexer';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Trooper';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Gutslasher';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Impaler';
UPDATE mob_spawn_points SET minLevel = 72, maxLevel = 74 WHERE mobname = 'Vanguards_Wyvern';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Vindicator';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Vigilante';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Kusa';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Militant';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Mason';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Beasttender';
UPDATE mob_spawn_points SET minLevel = 72, maxLevel = 74 WHERE mobname = 'Vanguards_Scorpion';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Constable';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Purloiner';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Drakekeeper';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Thaumaturge';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Minstrel';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Kusa';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Hatamoto';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Protector';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Defender';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Undertaker';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Skirmisher';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Visionary';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Chanter';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Oracle';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Sentinel';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Liberator';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Salvager';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Priest';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Exemplar';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Persecutor';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Partisan';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Prelate';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Inciter';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Assassin';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Ogresoother';
UPDATE mob_spawn_points SET minLevel = 72, maxLevel = 74 WHERE mobname = 'Vanguards_Crow';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Shaman';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Enchanter';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Welldigger';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Ronin';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Pathfinder';
UPDATE mob_spawn_points SET minLevel = 72, maxLevel = 74 WHERE mobname = 'Vanguards_Slime';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Armorer';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Tinkerer';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Maestro';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Hitman';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Dragontamer';

-- ------------------------------------------------------------
-- Dynamis - Buburimu (Zone 40)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Woodnix_Shrillwhistle';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Smithy';
UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Vanguard_Alchemist';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Shamblix_Rottenheart';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Vanguard_Pitfighter';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Vanguard_Ambusher';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Vanguard_Necromancer';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Gosspix_Blabberlips';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Flamecaller_Zoeqdoq';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Elvaansticker_Bxafraff';
UPDATE mob_spawn_points SET minLevel = 73, maxLevel = 75 WHERE mobname = 'Bxafraffs_Wyvern';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hamfist_Gukhbuk';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Lyncean_Juwgneg';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'QuPho_Bloodspiller';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'GiBhe_Fleshfeaster';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'VaRhu_Bodysnatcher';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'TeZha_Ironclad';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Ree_Nata_the_Melomanic';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Koo_Rahi_the_Levinblade';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Doo_Peku_the_Fleetfoot';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Baa_Dava_the_Bibliophage';
UPDATE mob_spawn_points SET minLevel = 73, maxLevel = 75 WHERE mobname = 'Baas_Avatar';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Crab';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Dhalmel';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Uragnite';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Scorpion';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Bunny';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Mandragora';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Crawler';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Raven';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Eft';
UPDATE mob_spawn_points SET minLevel = 82, maxLevel = 82 WHERE mobname = 'Stihi';
UPDATE mob_spawn_points SET minLevel = 82, maxLevel = 82 WHERE mobname = 'Barong';
UPDATE mob_spawn_points SET minLevel = 82, maxLevel = 82 WHERE mobname = 'Alklha';
UPDATE mob_spawn_points SET minLevel = 82, maxLevel = 82 WHERE mobname = 'Aitvaras';

-- ------------------------------------------------------------
-- Dynamis - Qufim (Zone 41)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Diremite';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Gaylas';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Kraken';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Raptor';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Roc';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Snoll';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Stirge';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Tiger';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Weapon';

-- -----------------------------------------------------------
-- Dynamis Tavnazia (Zone 42)
-- -----------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 73, maxLevel = 75 WHERE mobname = 'Hydras_Avatar';
UPDATE mob_spawn_points SET minLevel = 73, maxLevel = 75 WHERE mobname = 'Hydras_Hound';
UPDATE mob_spawn_points SET minLevel = 73, maxLevel = 75 WHERE mobname = 'Hydras_Wyvern';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Bard';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Beastmaster';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Black_Mage';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Dark_Knight';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Dragoon';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Monk';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Ninja';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Paladin';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Ranger';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Red_Mage';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Samurai';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Summoner';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Thief';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_Warrior';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Hydra_White_Mage';
UPDATE mob_spawn_points SET minLevel = 73, maxLevel = 75 WHERE mobname = 'Kindreds_Avatar';
UPDATE mob_spawn_points SET minLevel = 73, maxLevel = 75 WHERE mobname = 'Kindreds_Vouivre';
UPDATE mob_spawn_points SET minLevel = 73, maxLevel = 75 WHERE mobname = 'Kindreds_Wyvern';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Bard';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Beastmaster';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Black_Mage';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Dark_Knight';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Dragoon';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Monk';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Ninja';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Paladin';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Ranger';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Red_Mage';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Samurai';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Summoner';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Thief';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_Warrior';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kindred_White_Mage';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Cluster';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Nightmare_Leech';

-- ------------------------------------------------------------
-- Bhaflau Thickets (Zone 52)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 75, maxLevel = 75 WHERE mobname = 'Plague_Chigoe';
UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 82 WHERE mobname = 'Locus_Colibri';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 83 WHERE mobname = 'Locus_Wivre';

-- ------------------------------------------------------------
-- Ru'Aun Gardens (Zone 130)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 93, maxLevel = 95 WHERE mobname = 'Aello';
UPDATE mob_spawn_points SET minLevel = 90, maxLevel = 92 WHERE mobname = 'Aellos_Handmaiden';

-- ------------------------------------------------------------
-- Xarcabard [S] (Zone 137)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 90, maxLevel = 92 WHERE mobname = 'Zirnitra';

-- ------------------------------------------------------------
-- Castle Oztroja (Zone 151)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 47, maxLevel = 49 WHERE mobname = 'Yagudo_Muralist';

-- ------------------------------------------------------------
-- The Boyahda Tree (Zone 153)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 72, maxLevel = 75 WHERE mobname = 'Mourning_Crawler';
UPDATE mob_spawn_points SET minLevel = 72, maxLevel = 74 WHERE mobname = 'Viseclaw';

-- ------------------------------------------------------------
-- Ranguemont Pass (Zone 166)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 25, maxLevel = 28 WHERE mobname = 'Bilesucker';
UPDATE mob_spawn_points SET minLevel = 25, maxLevel = 27 WHERE mobname = 'Goblins_Bats' AND (mobid >> 12) & 0x1FF = 166;
UPDATE mob_spawn_points SET minLevel = 26, maxLevel = 30 WHERE mobname = 'Goblin_Artificer';
UPDATE mob_spawn_points SET minLevel = 26, maxLevel = 30 WHERE mobname = 'Goblin_Chaser';
UPDATE mob_spawn_points SET minLevel = 26, maxLevel = 30 WHERE mobname = 'Goblin_Hoodoo';
UPDATE mob_spawn_points SET minLevel = 26, maxLevel = 30 WHERE mobname = 'Goblin_Tanner';
UPDATE mob_spawn_points SET minLevel = 42, maxLevel = 44 WHERE mobname = 'Hovering_Oculus';

-- ------------------------------------------------------------
-- Bostaunieux Oubliette (Zone 167)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 55, maxLevel = 59 WHERE mobname = 'Blind_Bat';
UPDATE mob_spawn_points SET minLevel = 64, maxLevel = 66 WHERE mobname = 'Dabilla';
UPDATE mob_spawn_points SET minLevel = 68, maxLevel = 70 WHERE mobname = 'Nachtmahr';
UPDATE mob_spawn_points SET minLevel = 60, maxLevel = 68 WHERE mobname = 'Panna_Cotta';
UPDATE mob_spawn_points SET minLevel = 68, maxLevel = 70 WHERE mobname = 'Wurdalak';

-- ------------------------------------------------------------
-- Toraimarai Canal (Zone 169)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 57, maxLevel = 59 WHERE mobname = 'Blackwater_Pugil';
UPDATE mob_spawn_points SET minLevel = 45, maxLevel = 47 WHERE mobname = 'Bigclaw';
UPDATE mob_spawn_points SET minLevel = 57, maxLevel = 59 WHERE mobname = 'Blackwater_Pugil';
UPDATE mob_spawn_points SET minLevel = 59, maxLevel = 61 WHERE mobname = 'Bloodsucker';
UPDATE mob_spawn_points SET minLevel = 58, maxLevel = 60 WHERE mobname = 'Deviling_Bats';
UPDATE mob_spawn_points SET minLevel = 65, maxLevel = 67 WHERE mobname = 'Drowned_Bones';
UPDATE mob_spawn_points SET minLevel = 60, maxLevel = 62 WHERE mobname = 'Plunderer_Crab';
UPDATE mob_spawn_points SET minLevel = 65, maxLevel = 67 WHERE mobname = 'Rapier_Scorpion';
UPDATE mob_spawn_points SET minLevel = 66, maxLevel = 69 WHERE mobname = 'Sodden_Bones';
UPDATE mob_spawn_points SET minLevel = 65, maxLevel = 67 WHERE mobname = 'Starborer';

-- ------------------------------------------------------------
-- Zeruhn Mines (Zone 172)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 4, maxLevel = 6 WHERE mobname = 'Burrower_Worm';
UPDATE mob_spawn_points SET minLevel = 2, maxLevel = 4 WHERE mobname = 'Colliery_Bat';
UPDATE mob_spawn_points SET minLevel = 3, maxLevel = 5 WHERE mobname = 'Soot_Crab';
UPDATE mob_spawn_points SET minLevel = 3, maxLevel = 6 WHERE mobname = 'Veindigger_Leech';

-- ------------------------------------------------------------
-- Korroloka Tunnel (Zone 173)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 29, maxLevel = 32 WHERE mobname = 'Lacerator';
UPDATE mob_spawn_points SET minLevel = 23, maxLevel = 31 WHERE mobname = 'Spool_Leech';

-- ------------------------------------------------------------
-- Kuftal Tunnel (Zone 174)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Kuftal_Delver';
UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Machairodus';

-- ------------------------------------------------------------
-- The Shrine of Ru'Avitau (Zone 178)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Baelfyr';
UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Byrgen';
UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Gefyrst';
UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Ungeweder';

-- ------------------------------------------------------------
-- Dynamis - Jeuno (Zone 188)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Eremix_Snottynostril';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Karashix_Swollenskull';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Kikklix_Longlegs';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Mortilox_Wartpaws';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Prowlox_Barrelbelly';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Snypestix_Eaglebeak';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Tymexox_Ninefingers';

-- ------------------------------------------------------------
-- King Ranperre's Tomb (Zone 190)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 77, maxLevel = 79 WHERE mobname = 'Hati';
UPDATE mob_spawn_points SET minLevel = 80, maxLevel = 83 WHERE mobname = 'Locus_Dire_Bat';
UPDATE mob_spawn_points SET minLevel = 63, maxLevel = 65 WHERE mobname = 'Locus_Cutlass_Scorpion';
UPDATE mob_spawn_points SET minLevel = 60, maxLevel = 62 WHERE mobname = 'Locus_Thousand_Eyes';
UPDATE mob_spawn_points SET minLevel = 80, maxLevel = 82 WHERE mobname = 'Locus_Hati';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Locus_Spartoi_Warrior';
UPDATE mob_spawn_points SET minLevel = 78, maxLevel = 80 WHERE mobname = 'Locus_Spartoi_Sorcerer';
UPDATE mob_spawn_points SET minLevel = 80, maxLevel = 82 WHERE mobname = 'Locus_Lemures';
UPDATE mob_spawn_points SET minLevel = 80, maxLevel = 82 WHERE mobname = 'Locus_Tomb_Worm';
UPDATE mob_spawn_points SET minLevel = 80, maxLevel = 82 WHERE mobname = 'Locus_Armet_Beetle';

-- ------------------------------------------------------------
-- Dangruf Wadi (Zone 191)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Couloir_Leech';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Fume_Lizard';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Goblin_Bladesmith';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Goblin_Brigand';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Goblin_Bushwhacker';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Goblin_Conjurer';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Goblin_Headsman';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Goblin_Healer';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Natty_Gibbon';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Prim_Pika';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Trimmer';
UPDATE mob_spawn_points SET minLevel = 21, maxLevel = 23 WHERE mobname = 'Witchetty_Grub';

-- ------------------------------------------------------------
-- Inner Horutoto Ruins (Zone 192)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 17, maxLevel = 20 WHERE mobname = 'Covin_Bat';
UPDATE mob_spawn_points SET minLevel = 11, maxLevel = 16 WHERE mobname = 'Deathwatch_Beetle';
UPDATE mob_spawn_points SET minLevel = 20, maxLevel = 23 WHERE mobname = 'Goblin_Flesher';
UPDATE mob_spawn_points SET minLevel = 20, maxLevel = 23 WHERE mobname = 'Goblin_Lurcher';
UPDATE mob_spawn_points SET minLevel = 20, maxLevel = 23 WHERE mobname = 'Goblin_Metallurgist';
UPDATE mob_spawn_points SET minLevel = 20, maxLevel = 23 WHERE mobname = 'Goblin_Trailblazer';
UPDATE mob_spawn_points SET minLevel = 25, maxLevel = 28 WHERE mobname = 'Skinnymajinx';
UPDATE mob_spawn_points SET minLevel = 25, maxLevel = 28 WHERE mobname = 'Skinnymalinks';
UPDATE mob_spawn_points SET minLevel = 12, maxLevel = 15 WHERE mobname = 'Troika_Bats';

-- ------------------------------------------------------------
-- Ordelle's Caves (Zone 193)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 25, maxLevel = 27 WHERE mobname = 'Bilis_Leech';
UPDATE mob_spawn_points SET minLevel = 23, maxLevel = 26 WHERE mobname = 'Buds_Bunny';
UPDATE mob_spawn_points SET minLevel = 27, maxLevel = 29 WHERE mobname = 'Swagger_Spruce';
UPDATE mob_spawn_points SET minLevel = 29, maxLevel = 31 WHERE mobname = 'Targe_Beetle';

-- ------------------------------------------------------------
-- Outer Horutoto Ruins (Zone 194)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 23, maxLevel = 26 WHERE mobname = 'Fetor_Bats';
UPDATE mob_spawn_points SET minLevel = 23, maxLevel = 25 WHERE mobname = 'Fuligo';
UPDATE mob_spawn_points SET minLevel = 20, maxLevel = 23 WHERE mobname = 'Thorn_Bat';

-- ------------------------------------------------------------
-- The Eldieme Necropolis (Zone 195)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 60, maxLevel = 63 WHERE mobname = 'Hellbound_Warlock';
UPDATE mob_spawn_points SET minLevel = 60, maxLevel = 63 WHERE mobname = 'Hellbound_Warrior';
UPDATE mob_spawn_points SET minLevel = 34, maxLevel = 34 WHERE mobname = 'Namorodo';
UPDATE mob_spawn_points SET minLevel = 53, maxLevel = 55 WHERE mobname = 'Nekros_Hound';

-- ------------------------------------------------------------
-- Gusgen Mines (Zone 196)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 26, maxLevel = 30 WHERE mobname = 'Accursed_Soldier';
UPDATE mob_spawn_points SET minLevel = 23, maxLevel = 27 WHERE mobname = 'Accursed_Sorcerer';
UPDATE mob_spawn_points SET minLevel = 27, maxLevel = 30 WHERE mobname = 'Madfly';
UPDATE mob_spawn_points SET minLevel = 23, maxLevel = 26 WHERE mobname = 'Rockmill';

-- ------------------------------------------------------------
-- Crawler's Nest (Zone 197)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 50, maxLevel = 53 WHERE mobname = 'Dancing_Jewel';
UPDATE mob_spawn_points SET minLevel = 47, maxLevel = 49 WHERE mobname = 'King_Crawler';
UPDATE mob_spawn_points SET minLevel = 50, maxLevel = 54 WHERE mobname = 'Olid_Funguar';
UPDATE mob_spawn_points SET minLevel = 55, maxLevel = 57 WHERE mobname = 'Vespo';

-- ------------------------------------------------------------
-- Maze of Shakhrami (Zone 198)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 24, maxLevel = 28 WHERE mobname = 'Bleeder_Leech';
UPDATE mob_spawn_points SET minLevel = 23, maxLevel = 26 WHERE mobname = 'Chaser_Bats';
UPDATE mob_spawn_points SET minLevel = 29, maxLevel = 31 WHERE mobname = 'Crypterpillar';
UPDATE mob_spawn_points SET minLevel = 26, maxLevel = 29 WHERE mobname = 'Warren_Bat';

-- ------------------------------------------------------------
-- Garlaige Citadel (Zone 200)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 40, maxLevel = 43 WHERE mobname = 'Donjon_Bat';
UPDATE mob_spawn_points SET minLevel = 53, maxLevel = 55 WHERE mobname = 'Fortalice_Bats';
UPDATE mob_spawn_points SET minLevel = 59, maxLevel = 62 WHERE mobname = 'Kaboom';
UPDATE mob_spawn_points SET minLevel = 56, maxLevel = 58 WHERE mobname = 'Warden_Beetle';

-- ------------------------------------------------------------
-- Fei'Yin (Zone 204)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 51, maxLevel = 54 WHERE mobname = 'Balayang';
UPDATE mob_spawn_points SET minLevel = 56, maxLevel = 58 WHERE mobname = 'Sentient_Carafe';
UPDATE mob_spawn_points SET minLevel = 55, maxLevel = 57 WHERE mobname = 'Wekufe';

-- ------------------------------------------------------------
-- Gustav Tunnel (Zone 212)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Boulder_Eater';
UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Pygmytoise';

-- ------------------------------------------------------------
-- Labyrinth_of_Onzozo (Zone 213)
-- ------------------------------------------------------------

UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Babaulas';
UPDATE mob_spawn_points SET minLevel = 81, maxLevel = 84 WHERE mobname = 'Boribaba';
UPDATE mob_spawn_points SET minLevel = 80, maxLevel = 81 WHERE mobname = 'Lord_of_Onzozo';

-- ------------------------------------------------------------
-- RaKaznar_Inner_Court (Zone 276)
-- ------------------------------------------------------------

UPDATE mob_groups 
SET content_tag = 'ROV' 
WHERE zoneid = 276
AND name NOT IN (
    'Dolorous_Cyhiraeth',
    'Draftdance_Fluturini',
    'Poxhound',
    'Wayward_Bhoot',
    'Whitenoise_Bats'
);

UPDATE mob_groups
SET respawntime = 0, spawntype = 128
WHERE zoneid = 276
AND name IN (
    'Dolorous_Cyhiraeth',
    'Draftdance_Fluturini',
    'Poxhound',
    'Wayward_Bhoot',
    'Whitenoise_Bats'
);

UPDATE mob_pools 
SET mobType = 2, flag = 1 
WHERE name IN (
    'Dolorous_Cyhiraeth',
    'Draftdance_Fluturini',
    'Poxhound',
    'Wayward_Bhoot',
    'Whitenoise_Bats'
);

-- Whitenoise Bats
UPDATE mob_spawn_points SET minLevel = 100, maxLevel = 100 WHERE mobname = 'Whitenoise_Bats';
UPDATE mob_spawn_points SET pos_x = 808.750, pos_y = 90.000, pos_z = 67.350, pos_rot = 249 WHERE mobid = 17907757;
UPDATE mob_pools SET speciesid = 295, modelid = 0x0000140C00000000000000000000000000000000, mJob = 6, sJob = 13, cmbSkill = 2, cmbDelay = 50, cmbDmgMult = 40, immunity = 655, skill_list_id = 394 WHERE name = 'Whitenoise_Bats';
UPDATE mob_groups SET HP = 30000, MP = 10000 WHERE name = 'Whitenoise_Bats';

-- Wayward Bhoot
UPDATE mob_spawn_points SET minLevel = 95, maxLevel = 95 WHERE mobname = 'Wayward_Bhoot';
UPDATE mob_spawn_points SET pos_x = -182.000, pos_y = -450.000, pos_z = -200.000, pos_rot = 34 WHERE mobid = 17907733;
UPDATE mob_pools SET spellList = 28, skill_list_id = 121 WHERE name = 'Wayward_Bhoot';
UPDATE mob_groups SET HP = 35000, MP = 10000 WHERE name = 'Wayward_Bhoot';

-- Dolorous Cyhiraeth
UPDATE mob_spawn_points SET minLevel = 95, maxLevel = 95 WHERE mobname = 'Dolorous_Cyhiraeth';
UPDATE mob_spawn_points SET pos_x = -200.000, pos_y = -450.000, pos_z = -220.000, pos_rot = 87 WHERE mobid = 17907735;
UPDATE mob_groups SET HP = 35000, MP = 10000 WHERE name = 'Dolorous_Cyhiraeth';

-- Poxhound
UPDATE mob_spawn_points SET minLevel = 90, maxLevel = 95 WHERE mobname = 'Poxhound';
UPDATE mob_spawn_points SET pos_x = -190.000, pos_y = -440.000, pos_z = -140.000, pos_rot = 63 WHERE mobid = 17907715;
UPDATE mob_groups SET HP = 100000 WHERE name = 'Poxhound';

-- Draftdance Fluturini
UPDATE mob_spawn_points SET minLevel = 90, maxLevel = 100 WHERE mobname = 'Draftdance_Fluturini';
UPDATE mob_spawn_points SET pos_x = -169.000, pos_y = -440.000, pos_z = -139.000, pos_rot = 146 WHERE mobid = 17907713;
UPDATE mob_groups SET HP = 30000 WHERE name = 'Draftdance_Fluturini';

-- ------------------------------------------------------------
-- Mount Zhayolm (Zone 61)
-- ------------------------------------------------------------

UPDATE mob_groups SET dropid = 4465 WHERE name = 'Sicklemoon_Jagil';
