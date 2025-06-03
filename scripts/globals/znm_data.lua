-----------------------------------
---- ZNM Data Tables
---- Sanraku Trophies, Pop Items, Seals, etc.
-----------------------------------

xi = xi or {}
xi.znm = xi.znm or {}

-----------------------------------
--- General Helper Variables
-----------------------------------

-- Soultrapper Variables
xi.znm.SOULTRAPPER_SUCCESS     = 70   -- Base success rate (%)
xi.znm.SOULPLATE_HPP_MULT      = 1.5  -- Zeni multiplier for low hp %
xi.znm.SOULPLATE_ECOSYSTEM     = 25   -- Sanraku subject of interest ecosystem bonus
xi.znm.SOULPLATE_INTEREST      = 40   -- Sanraku subject of interest superFamily bonus
xi.znm.SOULPLATE_FAUNA         = 50   -- Sanraku recommended fauna bonus
xi.znm.SOULPLATE_NM_MULT       = 1.5  -- Generic NM multiplier
xi.znm.SOULPLATE_HNM_MULT      = 1.75 -- HNM multiplier
xi.znm.SOULPLATE_FACING_MULT   = 1.05 -- Soultrapper used while facing the target
xi.znm.SOULPLATE_HS_MULT       = 1.25 -- Using a High Speed soul plate (success rate bonus only)
xi.znm.SOULPLATE_TRADE_LIMIT   = 10   -- The number of soul plates players can trade per day
xi.znm.SOULPLATE_MIN_VALUE     = 5    -- The minimum amount of zeni per plate
xi.znm.SOULPLATE_MAX_VALUE     = 150  -- The maximum amount of zeni per plate
xi.znm.SOULPLATE_UNIQUE_AMOUNT = 30   -- Certain special mobs get bonus

-----------------------------------
---- ZNM Pop-Item Prices
-----------------------------------
-- Set to true if you want ZNM pop item prices to stay fixed
xi.znm.ZNM_STATIC_POP_PRICES = false

xi.znm.ZNM_POP_COSTS =
{
    [1] = { minPrice = 1000, maxPrice = 2500, addedPrice = 100, decayPrice = 100 },
    [2] = { minPrice = 2000, maxPrice = 5000, addedPrice = 200, decayPrice = 200 },
    [3] = { minPrice = 3000, maxPrice = 7500, addedPrice = 300, decayPrice = 300 },
    [4] = { minPrice = 4000, maxPrice = 9000, addedPrice = 400, decayPrice = 400 },
    [5] = { minPrice = 5000, maxPrice = 12000, addedPrice = 500, decayPrice = 500 },
}

-----------------------------------
--- Sanraku's "Subjects of Interest" and "Recommended Fauna"
--- Their order matches Ryo's csid (913) 'eventUpdate' value
--- 61 "Subjects of Interest", 54 "Recommended Fauna"
-----------------------------------
xi.znm.SANRAKUS_INTEREST =
{ -- [interest ID] = {superFamily ID, ecoSystem, optional Name},
    [1]  = { superFamily = 113, ecoSystem = { 48, 108, 113, 124, 130, 142, 160, 169, 170 } },                                       -- Pugil, Aquans
    [2]  = { superFamily = 130, ecoSystem = { 48, 108, 113, 124, 130, 142, 160, 169, 170 } },                                       -- Sea Monk
    [3]  = { superFamily = 108, ecoSystem = { 48, 108, 113, 124, 130, 142, 160, 169, 170 } },                                       -- Verified Orobon
    [4]  = { superFamily = 148, ecoSystem = { 42, 65, 82, 95, 127, 132, 148, 161 } },                                               -- Worm, Amorph
    [5]  = { superFamily = 95, ecoSystem = { 42, 65, 82, 95, 127, 132, 148, 161 } },                                                -- Leech, Amorph
    [6]  = { superFamily = 42, ecoSystem = { 42, 65, 82, 95, 127, 132, 148, 161 } },                                                -- Slime, Amorph
    [7]  = { superFamily = 65, ecoSystem = { 42, 65, 82, 95, 127, 132, 148, 161 } },                                                -- Flan, Amorph
    [8]  = { superFamily = 32, ecoSystem = { 1, 6, 29, 32, 37, 53, 79, 91, 97, 102, 134, 159, 164, 168, 183, 194, } },              -- Bomb, Arcana
    [9]  = { superFamily = 194, ecoSystem = { 1, 6, 29, 32, 37, 53, 79, 91, 97, 102, 134, 159, 164, 168, 183, 194, } },             -- Cluster Bomb, Arcana
    [10] = { superFamily = 28, ecoSystem = { 28, 46, 47, 54, 56, 68, 84, 86, 91, 109, 118, 143, 154, 167, 186 } },                  -- Ghost, Undead
    [11] = { superFamily = 91, ecoSystem = { 28, 46, 47, 54, 56, 68, 84, 86, 91, 109, 118, 143, 154, 167, 186 } },                  -- Skeleton, Undead
    [12] = { superFamily = 54, ecoSystem = { 28, 46, 47, 54, 56, 68, 84, 86, 91, 109, 118, 143, 154, 167, 186 } },                  -- Doomed, Undead
    [13] = { superFamily = 40, ecoSystem = { 9, 26, 27, 40, 52, 63, 66, 75, 93, 129, 135, 144, 155, 156, 157, 173, 196 } },         -- Chigoe, Vermin
    [14] = { superFamily = 135, ecoSystem = { 9, 26, 27, 40, 52, 63, 66, 75, 93, 129, 135, 144, 155, 156, 157, 173, 196 } },        -- Spider, Vermin
    [15] = { superFamily = 26, ecoSystem = { 9, 26, 27, 40, 52, 63, 66, 75, 93, 129, 135, 144, 155, 156, 157, 173, 196 } },         -- Verified Bee, Vermin
    [16] = { superFamily = 63, ecoSystem = { 9, 26, 27, 40, 52, 63, 66, 75, 93, 129, 135, 144, 155, 156, 157, 173, 196 } },         -- Verified Crawler, Vermin
    [17] = { superFamily = 196, ecoSystem = { 9, 26, 27, 40, 52, 63, 66, 75, 93, 129, 135, 144, 155, 156, 157, 173, 196 } },        -- Wamoura Larvae, Vermin
    [18] = { superFamily = 66, ecoSystem = { 9, 26, 27, 40, 52, 63, 66, 75, 93, 129, 135, 144, 155, 156, 157, 173, 196 } },         -- Fly, Vermin
    [19] = { superFamily = 52, ecoSystem = { 9, 26, 27, 40, 52, 63, 66, 75, 93, 129, 135, 144, 155, 156, 157, 173, 196 } },         -- Verified Diremite, Vermin
    [20] = { superFamily = 129, ecoSystem = { 9, 26, 27, 40, 52, 63, 66, 75, 93, 129, 135, 144, 155, 156, 157, 173, 196 } },        -- Scorpion, Vermin
    [21] = { superFamily = 144, ecoSystem = { 9, 26, 27, 40, 52, 63, 66, 75, 93, 129, 135, 144, 155, 156, 157, 173, 196 } },        -- Wamoura, Vermin
    [22] = { superFamily = 89, ecoSystem = { 4, 57, 58, 70, 78, 89, 92, 133, 135, 182, 189, 190 } },                                -- Imp, Demon
    [23] = { superFamily = 114, ecoSystem = { 55, 78, 88, 109, 114, 149, 184, 192 } },                                              -- Puk, Dragon
    [24] = { superFamily = 109, ecoSystem = { 55, 78, 88, 109, 114, 149, 184, 192 } },                                              -- Wyvern, Dragon
    [25] = { superFamily = 55, ecoSystem = { 55, 78, 88, 109, 114, 149, 184, 192 } },                                               -- Dragon, Dragon
    [26] = { superFamily = 25, ecoSystem = { 6, 10, 25, 31, 43, 45, 73, 83, 171, 177, 185, 197 } },                                 -- Bat, Bird
    [27] = { superFamily = 197, ecoSystem = { 6, 10, 25, 31, 43, 45, 73, 83, 171, 177, 185, 197 } },                                -- Bat Trio, Bird
    [28] = { superFamily = 45, ecoSystem = { 6, 10, 25, 31, 43, 45, 73, 83, 171, 177, 185, 197 } },                                 -- Colibri, Bird
    [29] = { superFamily = 31, ecoSystem = { 6, 10, 25, 31, 43, 45, 73, 83, 171, 177, 185, 197 } },                                 -- Bird, Bird
    [30] = { superFamily = 10, ecoSystem = { 6, 10, 25, 31, 43, 45, 73, 83, 171, 177, 185, 197 } },                                 -- Apkallu, Bird
    [31] = { superFamily = 43, ecoSystem = { 6, 10, 25, 31, 43, 45, 73, 83, 171, 177, 185, 197 } },                                 -- Cockatrice, Bird
    [32] = { superFamily = 90, ecoSystem = { 27, 28, 33, 38, 44, 51, 90, 100, 101, 106, 119, 121, 137, 174, 175, 176 } },           -- Sheep, Beast
    [33] = { superFamily = 137, ecoSystem = { 27, 28, 33, 38, 44, 51, 90, 100, 101, 106, 119, 121, 137, 174, 175, 176 } },          -- Tiger, Beast
    [34] = { superFamily = 101, ecoSystem = { 27, 28, 33, 38, 44, 51, 90, 100, 101, 106, 119, 121, 137, 174, 175, 176 } },          -- Marid, Beast
    [35] = { superFamily = 121, ecoSystem = { 27, 28, 33, 38, 44, 51, 90, 100, 101, 106, 119, 121, 137, 174, 175, 176 } },          -- Ram, Beast
    [36] = { superFamily = 128, ecoSystem = { 67, 69, 80, 99, 104, 120, 125, 128, 139, 172, 179, 180, 181 } },                      -- Verified Sapling, Plantoid
    [37] = { superFamily = 67, ecoSystem = { 67, 69, 80, 99, 104, 120, 125, 128, 139, 172, 179, 180, 181 } },                       -- Flytrap, Plantoid
    [38] = { superFamily = 69, ecoSystem = { 67, 69, 80, 99, 104, 120, 125, 128, 139, 172, 179, 180, 181 } },                       -- Funguar, Plantoid
    [39] = { superFamily = 139, ecoSystem = { 67, 69, 80, 99, 104, 120, 125, 128, 139, 172, 179, 180, 181 } },                      -- Treant, Plantoid
    [40] = { superFamily = 104, ecoSystem = { 67, 69, 80, 99, 104, 120, 125, 128, 139, 172, 179, 180, 181 } },                      -- Verified Morbol, Plantoid
    [41] = { superFamily = 60, ecoSystem = { 2, 34, 60, 61, 109, 123, 147, 163, 178 } },                                            -- Lizard, Lizard
    [42] = { superFamily = 123, ecoSystem = { 2, 34, 60, 61, 109, 123, 147, 163, 178 } },                                           -- Raptor, Lizard
    [43] = { superFamily = 34, ecoSystem = { 2, 34, 60, 61, 109, 123, 147, 163, 178 } },                                            -- Bugard, Lizard
    [44] = { superFamily = 147, ecoSystem = { 2, 34, 60, 61, 109, 123, 147, 163, 178 } },                                           -- Verified Wivre, Lizard
    [45] = { superFamily = 62, ecoSystem = { 11, 62, 87 }, name = 'FireElemental' },                                                -- Fire Elemental, Elemental
    [46] = { superFamily = 62, ecoSystem = { 11, 62, 87 }, name = 'IceElemental' },                                                 -- Ice Elemental, Elemental
    [47] = { superFamily = 62, ecoSystem = { 11, 62, 87 }, name = 'AirElemental' },                                                 -- Air Elemental, Elemental
    [48] = { superFamily = 62, ecoSystem = { 11, 62, 87 }, name = 'EarthElemental' },                                               -- Earth Elemental, Elemental
    [49] = { superFamily = 62, ecoSystem = { 11, 62, 87 }, name = 'ThunderElement`' },                                              -- Thunder Elemental, Elemental
    [50] = { superFamily = 62, ecoSystem = { 11, 62, 87 }, name = 'WaterElemental' },                                               -- Water Elemental, Elemental
    [51] = { superFamily = 62, ecoSystem = { 11, 62, 87 }, name = 'DarkElemental' },                                                -- Verified Dark Elemental, Elemental
    [52] = { superFamily = 195, ecoSystem = { 8, 35, 74, 76, 77, 94, 98, 107, 112, 115, 116, 126, 138, 140, 151, 158, 193, 195 } }, -- Moblin, Beastman
    [53] = { superFamily = 112, ecoSystem = { 8, 35, 74, 76, 77, 94, 98, 107, 112, 115, 116, 126, 138, 140, 151, 158, 193, 195 } }, -- Poroggo, Beastmen
    [54] = { superFamily = 126, ecoSystem = { 8, 35, 74, 76, 77, 94, 98, 107, 112, 115, 116, 126, 138, 140, 151, 158, 193, 195 } }, -- Sahagin, Beastmen
    [55] = { superFamily = 98, ecoSystem = { 8, 35, 74, 76, 77, 94, 98, 107, 112, 115, 116, 126, 138, 140, 151, 158, 193, 195 } },  -- Mamool Ja, Beastmen
    [56] = { superFamily = 94, ecoSystem = { 8, 35, 74, 76, 77, 94, 98, 107, 112, 115, 116, 126, 138, 140, 151, 158, 193, 195 } },  -- Lamiae, Beastmen
    [57] = { superFamily = 193, ecoSystem = { 8, 35, 74, 76, 77, 94, 98, 107, 112, 115, 116, 126, 138, 140, 151, 158, 193, 195 } }, -- Merrow, Beastmen
    [58] = { superFamily = 115, ecoSystem = { 8, 35, 74, 76, 77, 94, 98, 107, 112, 115, 116, 126, 138, 140, 151, 158, 193, 195 } }, -- Qiqirn, beastmen
    [59] = { superFamily = 140, ecoSystem = { 8, 35, 74, 76, 77, 94, 98, 107, 112, 115, 116, 126, 138, 140, 151, 158, 193, 195 } }, -- Verified Troll, Beastmen
    [60] = { superFamily = 118, ecoSystem = { 28, 46, 47, 54, 56, 68, 84, 86, 91, 109, 118, 143, 154, 167, 186 } },                 -- Qutrub, Undead
    [61] = { superFamily = 133, ecoSystem = { 4, 57, 58, 70, 78, 89, 92, 133, 135, 182, 189, 190 } },                               -- Soulflayer, Demon
}

xi.znm.SANRAKUS_FAUNA =
{ -- Recommended Fauna refer to a specific enemy, identified by zone and type
    [1]  = { zone = xi.zone.MOUNT_ZHAYOLM, name = 'Cerberus' },                       -- Mount Zhayolm
    [2]  = { zone = xi.zone.WAJAOM_WOODLANDS, name = 'Hydra' },                       -- Wajaom Woodlands
    [3]  = { zone = xi.zone.ILRUSI_ATOLL, name = 'Cursed_Chest' },                    -- Golden Salvage (Assault)
    [4]  = { zone = xi.zone.ILRUSI_ATOLL, name = 'Imp' },                             -- Demolition Duty (Assault)
    [5]  = { zone = xi.zone.ILRUSI_ATOLL, name = 'Orobon' },                          -- Desperately Seeking Cephalopods (Assault)
    [6]  = { zone = xi.zone.ILRUSI_ATOLL, name = 'Khimaira_14X' },                    -- Bellerophon's Bliss (Assault)
    [7]  = { zone = xi.zone.ILRUSI_ATOLL, name = 'Martial_Maestro_Megomak' },         -- Bellerophon's Bliss (Assault)
    [8]  = { zone = xi.zone.PERIQIA, name = 'Arrapago_Crab' },                        -- Seagull Grounded (Assault)
    [9]  = { zone = xi.zone.PERIQIA, name = 'Batteilant_Bhoot' },                     -- Requiem (Assault)
    [10] = { zone = xi.zone.PERIQIA, name = 'Black_Baron' },                          -- Shooting Down the Baron (Assault)
    [11] = { zone = xi.zone.PERIQIA, name = 'Qiqirn_Miner' },                         -- Defuse the Threat (Assault)
    [12] = { zone = xi.zone.PERIQIA, name = 'King_Goldemar' },                        -- The Price is Right (Assault)
    [13] = { zone = xi.zone.LEBROS_CAVERN, name = 'Dahak' },                          -- Evade and Escape (Assault)
    [14] = { zone = xi.zone.LEBROS_CAVERN, name = 'Ranch_Wamoura' },                  -- Wamoura Farm Raid (Assault)
    [15] = { zone = xi.zone.LEBROS_CAVERN, name = 'Black_Shuck' },                    -- Better Than One (Assault)
    [16] = { zone = xi.zone.LEBROS_CAVERN, name = 'Nocuous_Inferno' },                -- Better Than One (Assault)
    [17] = { zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS, name = 'Festive_Firedrake' }, -- Blitzkrieg (Assault)
    [18] = { zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS, name = 'Molted_Ziz' },        -- Blitzkrieg (Assault)
    [19] = { zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS, name = 'Marid' },             -- Marids in the Mist (Assault)
    [20] = { zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS, name = 'Poroggo' },           -- Azure Ailments (Assault)
    [21] = { zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS, name = 'Qiqirn_Huckster' },   -- Azure Ailments (Assault)
    [22] = { zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS, name = 'Leech' },             -- Azure Ailments (Assault)
    [23] = { zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS, name = 'Orochi' },            -- The Susanoo Shuffle (Assault)
    [24] = { zone = xi.zone.LEUJAOAM_SANCTUM, name = 'Coney' },                       -- Shanarha Grass Conservation (Assault)
    [25] = { zone = xi.zone.LEUJAOAM_SANCTUM, name = 'Imp' },                         -- Supplies Recovery (Assault)
    [26] = { zone = xi.zone.LEUJAOAM_SANCTUM, name = 'Count_Dracula' },               -- Bloody Rondo (Assault)
    [27] = { zone = xi.zone.THE_ASHU_TALIF, name = 'Bubbly' },                        -- Targeting the Captain (Assault)
    [28] = { zone = xi.zone.TALACCA_COVE, name = 'Imp_Bandsman' },                    -- Call to Arms (ISNM)
    [29] = { zone = xi.zone.TALACCA_COVE, name = 'Angler_Orobon' },                   -- Compliments to the Chef (ISNM)
    [30] = { zone = xi.zone.NAVUKGO_EXECUTION_CHAMBER, name = 'Watch_Wamoura' },      -- Tough Nut to Crack (ISNM)
    [31] = { zone = xi.zone.NAVUKGO_EXECUTION_CHAMBER, name = 'Two-Faced_Flan' },     -- Happy Caster (ISNM)
    [32] = { zone = xi.zone.JADE_SEPULCHER, name = 'Mocking_Colibri' },               -- Making a Mockery (ISNM)
    [33] = { zone = xi.zone.JADE_SEPULCHER, name = 'Phantom_Puk' },                   -- Shadows of the Mind (ISNM)
    [34] = { zone = xi.zone.NYZUL_ISLE, name = 'Adamantoise' },                       -- (Floors 20, 40)
    [35] = { zone = xi.zone.NYZUL_ISLE, name = 'Behemoth' },                          -- (Floors 20, 40)
    [36] = { zone = xi.zone.NYZUL_ISLE, name = 'Fafnir' },                            -- (Floors 20, 40)
    [37] = { zone = xi.zone.NYZUL_ISLE, name = 'Khimaira' },                          -- (Floors 60, 80, 100)
    [38] = { zone = xi.zone.NYZUL_ISLE, name = 'Cerberus' },                          -- (Floors 60, 80, 100)
    [39] = { zone = xi.zone.NYZUL_ISLE, name = 'Hydra' },                             -- (Floors 60, 80, 100)
    [40] = { zone = xi.zone.ZHAYOLM_REMNANTS, name = 'Battleclad_Chariot' },          -- Zhayolm Remnants (Salvage)
    [41] = { zone = xi.zone.ZHAYOLM_REMNANTS, name = 'Jakko' },                       -- (Salvage)
    [42] = { zone = xi.zone.ARRAPAGO_REMNANTS, name = 'Armored_Chariot' },            -- (Salvage)
    [43] = { zone = xi.zone.ARRAPAGO_REMNANTS, name = 'Princess_Pudding' },           -- (Salvage)
    [44] = { zone = xi.zone.BHAFLAU_REMNANTS, name = 'Long-Bowed_Chariot' },          -- (Salvage)
    [45] = { zone = xi.zone.BHAFLAU_REMNANTS, name = 'Demented_Jalaawa' },            -- (Salvage)
    [46] = { zone = xi.zone.SILVER_SEA_REMNANTS, name = 'Long-Armed_Chariot' },       -- (Salvage)
    [47] = { zone = xi.zone.SILVER_SEA_REMNANTS, name = 'Don_Poroggo' },              -- (Salvage)
    [48] =
    {
        zone = xi.zone.HAZHALM_TESTING_GROUNDS, -- First Wing Bosses (Einherjar - one spawns at random)
        name = { 'Hakenmann', 'Hildesvini', 'Himinrjot', 'Hraesvelg', 'Morbol_Emperor', 'Nihhus' },
    },
    [49] =
    {
        zone = xi.zone.HAZHALM_TESTING_GROUNDS, -- Second Wing Bosses (Einherjar - one spawns at random)
        name = { 'Andhrimnir', 'Ariri_Samariri', 'Balrahn', 'Hrungnir', 'Mokkuralfi', 'Tanngrisnir' },
    },
    [50] =
    {
        zone = xi.zone.HAZHALM_TESTING_GROUNDS, -- Third Wing Bosses (Einherjar - one spawns at random)
        name = { 'Dendainsonne', 'Freke', 'Gorgimera', 'Motsognir', 'Stoorworm', 'Vampyr_Jarl' },
    },
    [51] = { zone = xi.zone.HAZHALM_TESTING_GROUNDS, 'Odin' },           -- Odin's Chamber (Einherjar)
    [52] = { zone = xi.zone.AL_ZAHBI, name = 'Gulool_Ja_Ja' },           -- Al Zhabi (Besieged)
    [53] = { zone = xi.zone.AL_ZAHBI, name = 'Gurfurlur_the_Menacing' }, -- Al Zhabi (Besieged)
    [54] = { zone = xi.zone.AL_ZAHBI, name = 'Medusa' },
}

-----------------------------------
---- Sanraku's Trophy Trades and Pop Items
-----------------------------------
xi.znm.TROPHIES =
{ -- [mob_trophy] = seal_rewarded
    [xi.item.VULPANGUES_WING]             = xi.keyItem.MAROON_SEAL,
    [xi.item.CHAMROSHS_BEAK]              = xi.keyItem.MAROON_SEAL,
    [xi.item.GIGIROONS_CAPE]              = xi.keyItem.MAROON_SEAL,
    [xi.item.BRASS_BORERS_COCOON]         = xi.keyItem.CERISE_SEAL,
    [xi.item.GLOBULE_OF_CLARET]           = xi.keyItem.CERISE_SEAL,
    [xi.item.OBS_ARM]                     = xi.keyItem.CERISE_SEAL,
    [xi.item.VELIONISS_BONE]              = xi.keyItem.PINE_GREEN_SEAL,
    [xi.item.LIL_APKALLUS_EGG]            = xi.keyItem.PINE_GREEN_SEAL,
    [xi.item.CHIGRE]                      = xi.keyItem.PINE_GREEN_SEAL,
    [xi.item.IRIZ_IMAS_HIDE]              = xi.keyItem.APPLE_GREEN_SEAL,
    [xi.item.AMOOSHAHS_TENDRIL]           = xi.keyItem.APPLE_GREEN_SEAL,
    [xi.item.IRIRI_SAMARIRIS_HAT]         = xi.keyItem.APPLE_GREEN_SEAL,
    [xi.item.ANANTABOGAS_HEART]           = xi.keyItem.SALMON_COLORED_SEAL,
    [xi.item.PILE_OF_REACTONS_ASHES]      = xi.keyItem.SALMON_COLORED_SEAL,
    [xi.item.BLOB_OF_DEXTROSES_BLUBBER]   = xi.keyItem.SALMON_COLORED_SEAL,
    [xi.item.ZAREEKHLS_NECKPIECE]         = xi.keyItem.AMBER_COLORED_SEAL,
    [xi.item.VERDELETS_WING]              = xi.keyItem.AMBER_COLORED_SEAL,
    [xi.item.WULGARUS_HEAD]               = xi.keyItem.AMBER_COLORED_SEAL,
    [xi.item.ARMED_GEARS_FRAGMENT]        = xi.keyItem.CHARCOAL_GREY_SEAL,
    [xi.item.GOTOH_ZHAS_NECKLACE]         = xi.keyItem.DEEP_PURPLE_SEAL,
    [xi.item.DEAS_HORN]                   = xi.keyItem.CHESTNUT_COLORED_SEAL,
    [xi.item.NOSFERATUS_CLAW]             = xi.keyItem.PURPLISH_GREY_SEAL,
    [xi.item.BHURBORLORS_VAMBRACE]        = xi.keyItem.GOLD_COLORED_SEAL,
    [xi.item.ACHAMOTHS_ANTENNA]           = xi.keyItem.COPPER_COLORED_SEAL,
    [xi.item.MAHJLAEFS_STAFF]             = xi.keyItem.FALLOW_COLORED_SEAL,
    [xi.item.EXPERIMENTAL_LAMIAS_ARMBAND] = xi.keyItem.TAUPE_COLORED_SEAL,
    [xi.item.NUHNS_ESCA]                  = xi.keyItem.SIENNA_COLORED_SEAL,
    [xi.item.TINNINS_FANG]                = xi.keyItem.LILAC_COLORED_SEAL,
    [xi.item.SARAMEYAS_HIDE]              = xi.keyItem.BRIGHT_BLUE_SEAL,
    [xi.item.TYGERS_TAIL]                 = xi.keyItem.LAVENDER_COLORED_SEAL,
}

xi.znm.POP_ITEMS =
{
    -- Ordered to match the csid options
    -- { mob, popitemID, ZNMtier (for pop price updating), seals_to_remove}
    { mob = 'Vulpangue',               item = xi.item.HELLCAGE_BUTTERFLY,            tier = 1, seal = 0 },
    { mob = 'Chamrosh',                item = xi.item.JUG_OF_FLORAL_NECTAR,          tier = 1, seal = 0 },
    { mob = 'Cheese Hoarder Gigiroon', item = xi.item.WEDGE_OF_RODENT_CHEESE,        tier = 1, seal = 0 },
    { mob = 'Iriz Ima',                item = xi.item.BUNCH_OF_SENORITA_PAMAMAS,     tier = 2, seal = xi.keyItem.MAROON_SEAL },
    { mob = 'Lividroot Amooshah',      item = xi.item.JAR_OF_OILY_BLOOD,             tier = 2, seal = xi.keyItem.MAROON_SEAL },
    { mob = 'Iriri Samariri',          item = xi.item.STRAND_OF_SAMARIRI_CORPSEHAIR, tier = 2, seal = xi.keyItem.MAROON_SEAL },
    { mob = 'Armed Gear',              item = xi.item.BAR_OF_FERRITE,                tier = 3, seal = xi.keyItem.APPLE_GREEN_SEAL },
    { mob = 'Gotoh Zha the Redolent',  item = xi.item.BAGGED_SHEEP_BOTFLY,           tier = 3, seal = xi.keyItem.APPLE_GREEN_SEAL },
    { mob = 'Dea',                     item = xi.item.OLZHIRYAN_CACTUS_PADDLE,       tier = 3, seal = xi.keyItem.APPLE_GREEN_SEAL },
    {
        mob = 'Tinnin',
        item = xi.item.JUG_OF_MONKEY_WINE,
        tier = 4,
        seal =
        {
            xi.keyItem.CHARCOAL_GREY_SEAL,
            xi.keyItem.DEEP_PURPLE_SEAL,
            xi.keyItem.CHESTNUT_COLORED_SEAL,
        },
    },
    { mob = 'Brass Borer',           item = xi.item.CLUMP_OF_SHADELEAVES,      tier = 1, seal = 0 },
    { mob = 'Claret',                item = xi.item.BEAKER_OF_PECTIN,          tier = 1, seal = 0 },
    { mob = 'Ob',                    item = xi.item.FLASK_OF_COG_LUBRICANT,    tier = 1, seal = 0 },
    { mob = 'Anantaboga',            item = xi.item.SLAB_OF_RAW_BUFFALO,       tier = 2, seal = xi.keyItem.CERISE_SEAL },
    { mob = 'Reacton',               item = xi.item.LUMP_OF_BONE_CHARCOAL,     tier = 2, seal = xi.keyItem.CERISE_SEAL },
    { mob = 'Dextrose',              item = xi.item.PINCH_OF_GRANULATED_SUGAR, tier = 2, seal = xi.keyItem.CERISE_SEAL },
    { mob = 'Nosferatu',             item = xi.item.VIAL_OF_PURE_BLOOD,        tier = 3, seal = xi.keyItem.SALMON_COLORED_SEAL },
    { mob = 'Khromasoul Bhurborlor', item = xi.item.VINEGAR_PIE,               tier = 3, seal = xi.keyItem.SALMON_COLORED_SEAL },
    { mob = 'Achamoth',              item = xi.item.JAR_OF_ROCK_JUICE,         tier = 3, seal = xi.keyItem.SALMON_COLORED_SEAL },
    {
        mob = 'Sarameya',
        item = xi.item.CHUNK_OF_BUFFALO_CORPSE,
        tier = 4,
        seal =
        {
            xi.keyItem.COPPER_COLORED_SEAL,
            xi.keyItem.GOLD_COLORED_SEAL,
            xi.keyItem.PURPLISH_GREY_SEAL,
        },
    },
    { mob = 'Velionis',              item = xi.item.GOLDEN_TEETH,            tier = 1, seal = 0 },
    { mob = 'Lil\' Apkallu',         item = xi.item.GREENLING,               tier = 1, seal = 0 },
    { mob = 'Chigre',                item = xi.item.BOTTLE_OF_SPOILT_BLOOD,  tier = 1, seal = 0 },
    { mob = 'Wulgaru',               item = xi.item.OPALUS_GEM,              tier = 2, seal = xi.keyItem.PINE_GREEN_SEAL },
    { mob = 'Zareehkl the Jubilant', item = xi.item.MERROW_NO_11_MOLTING,    tier = 2, seal = xi.keyItem.PINE_GREEN_SEAL },
    { mob = 'Verdelet',              item = xi.item.MINT_DROP,               tier = 2, seal = xi.keyItem.PINE_GREEN_SEAL },
    { mob = 'Mahjlaef the Paintorn', item = xi.item.BOUND_EXORCISM_TREATISE, tier = 3, seal = xi.keyItem.AMBER_COLORED_SEAL },
    { mob = 'Experimental Lamia',    item = xi.item.CLUMP_OF_MYRRH,          tier = 3, seal = xi.keyItem.AMBER_COLORED_SEAL },
    { mob = 'Nuhn',                  item = xi.item.WHOLE_ROSE_SCAMPI,       tier = 3, seal = xi.keyItem.AMBER_COLORED_SEAL },
    {
        mob = 'Tyger',
        item = xi.item.CHUNK_OF_SINGED_BUFFALO,
        tier = 4,
        seal =
        {
            xi.keyItem.TAUPE_COLORED_SEAL,
            xi.keyItem.FALLOW_COLORED_SEAL,
            xi.keyItem.SIENNA_COLORED_SEAL,
        },
    },
    {
        mob = 'Pandemonium Warden',
        item = xi.item.PANDEMONIUM_KEY,
        tier = 5,
        seal =
        {
            xi.keyItem.LILAC_COLORED_SEAL,
            xi.keyItem.LAVENDER_COLORED_SEAL,
            xi.keyItem.BRIGHT_BLUE_SEAL,
        },
    },
}

-----------------------------------
---- Sanraku's ZNM Menu Options
---- ZNM bitmask order is the same as pop_items' order
-----------------------------------
-- Default: Tier 1 ZNMs + 'Don't Ask'
-- (if bit = 0: add ZNM to Sanraku's Menu)
xi.znm.DefaultMenu = 0x7F8FE3F8
-- xi.znm.DefaultMenu = 0x7FFFFFFF -- No Tier 1 NMs available (need to audit their behaviours)

-- Adjusts the bitmask based on owned seals
xi.znm.MENU_BITMASKS =
{
    [0x38]       = xi.keyItem.MAROON_SEAL,         -- Tinnin T2 ZNMs
    [0x1C0]      = xi.keyItem.APPLE_GREEN_SEAL,    -- Tinnin T3 ZNMs
    [0xE000]     = xi.keyItem.CERISE_SEAL,         -- Sarameya T2 ZNMs
    [0x70000]    = xi.keyItem.SALMON_COLORED_SEAL, -- Sarameya T3 ZNMs
    [0x3800000]  = xi.keyItem.PINE_GREEN_SEAL,     -- Tyger T2 ZNMs
    [0x1C000000] = xi.keyItem.AMBER_COLORED_SEAL,  -- Tyger T3 ZNMs
    [0x200]      =
    {
        xi.keyItem.CHARCOAL_GREY_SEAL, -- Tinnin
        xi.keyItem.DEEP_PURPLE_SEAL,
        xi.keyItem.CHESTNUT_COLORED_SEAL,
    },
    [0x80000]    =
    {
        xi.keyItem.PURPLISH_GREY_SEAL, -- Sarameya
        xi.keyItem.GOLD_COLORED_SEAL,
        xi.keyItem.COPPER_COLORED_SEAL,
    },
    [0x20000000] =
    {
        xi.keyItem.TAUPE_COLORED_SEAL, -- Tyger
        xi.keyItem.FALLOW_COLORED_SEAL,
        xi.keyItem.SIENNA_COLORED_SEAL,
    },
    [0x40000000] =
    {
        xi.keyItem.LILAC_COLORED_SEAL, -- Pandemonium Warden
        xi.keyItem.BRIGHT_BLUE_SEAL,
        xi.keyItem.LAVENDER_COLORED_SEAL,
    },
}
