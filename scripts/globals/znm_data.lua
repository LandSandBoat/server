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
xi.znm.SOULTRAPPER_SUCCESS      = 70  -- Base success rate (%)
xi.znm.SOULPLATE_HPP_MULT       = 1   -- Zeni multiplier for low hp %
xi.znm.SOULPLATE_INTEREST_MULT  = 3   -- Sanraku subject of interest multiplier
xi.znm.SOULPLATE_FAUNA_MULT     = 4   -- Sanraku recommended fauna multiplier
xi.znm.SOULPLATE_NM_MULT        = 2   -- Generic NM multiplier (won't stack with rec. fauna)
xi.znm.SOULPLATE_FACING_MULT    = 1.5 -- Soultrapper used while facing the target
xi.znm.SOULPLATE_HS_MULT        = 1.5 -- Using a High Speed soul plate
xi.znm.SOULPLATE_TRADE_LIMIT    = 10  -- The number of soul plates players can trade per day
xi.znm.SOULPLATE_MIN_VALUE      = 1   -- The minimum amount of zeni per plate
xi.znm.SOULPLATE_MAX_VALUE      = 150 -- The maximum amount of zeni per plate

-----------------------------------
---- ZNM Pop-Item Prices
-----------------------------------
-- Set to true if you want ZNM pop item prices to stay fixed
xi.znm.ZNM_STATIC_POP_PRICES = false

xi.znm.ZNM_POP_COSTS = {
    [1] = {minPrice = 1000, maxPrice = 2500, addedPrice = 100, decayPrice = 100},
    [2] = {minPrice = 2000, maxPrice = 5000, addedPrice = 200, decayPrice = 200},
    [3] = {minPrice = 3000, maxPrice = 7500, addedPrice = 300, decayPrice = 300},
    [4] = {minPrice = 4000, maxPrice = 9000, addedPrice = 400, decayPrice = 400},
    [5] = {minPrice = 5000, maxPrice = 12000, addedPrice = 500, decayPrice = 500}
}

------------------------------------------------------------
--- Sanraku's "Subjects of Interest" and "Recommended Fauna"
--- Their order matches Ryo's csid (913) 'eventUpdate' value
--- 61 "Subjects of Interest", 54 "Recommended Fauna"
------------------------------------------------------------
xi.znm.SANRAKUS_INTEREST = {
    -- Some families were easier to verify using superfamilies, so the first value is a bool to check
    -- {isSuperFamID?, (super)familyID}
    [1]  = {isSuperFamID = 0, familyID = 197}, -- Pugil
    [2]  = {isSuperFamID = 1, familyID = 129}, -- Sea Monk
    [3]  = {isSuperFamID = 0, familyID = 191}, -- Orobon
    [4]  = {isSuperFamID = 0, familyID = 258}, -- Worm
    [5]  = {isSuperFamID = 0, familyID = 172}, -- Leech
    [6]  = {isSuperFamID = 1, familyID = 42},  -- Slime
    [7]  = {isSuperFamID = 0, familyID = 112}, -- Flan
    [8]  = {isSuperFamID = 0, familyID = 56},  -- Bomb
    [9]  = {isSuperFamID = 1, familyID = 32},  -- Cluster Bomb
    [10] = {isSuperFamID = 0, familyID = 121}, -- Ghost
    [11] = {isSuperFamID = 0, familyID = 227}, -- Skeleton
    [12] = {isSuperFamID = 0, familyID = 86},  -- Doomed
    [13] = {isSuperFamID = 0, familyID = 64},  -- Chigoe
    [14] = {isSuperFamID = 0, familyID = 235}, -- Spider
    [15] = {isSuperFamID = 0, familyID = 48},  -- Bee
    [16] = {isSuperFamID = 0, familyID = 79},  -- Crawler
    [17] = {isSuperFamID = 0, familyID = 253}, -- Wamoura Larvae
    [18] = {isSuperFamID = 0, familyID = 113}, -- Fly
    [19] = {isSuperFamID = 0, familyID = 81},  -- Diremite
    [20] = {isSuperFamID = 0, familyID = 217}, -- Scorpion
    [21] = {isSuperFamID = 0, familyID = 254}, -- Wamoura
    [22] = {isSuperFamID = 0, familyID = 89},  -- Imp
    [23] = {isSuperFamID = 0, familyID = 198}, -- Puk
    [24] = {isSuperFamID = 1, familyID = 109}, -- Wyvern
    [25] = {isSuperFamID = 0, familyID = 87},  -- Dragon
    [26] = {isSuperFamID = 0, familyID = 46},  -- Bat
    [27] = {isSuperFamID = 0, familyID = 47},  -- Bat Trio
    [28] = {isSuperFamID = 0, familyID = 72},  -- Colibri
    [29] = {isSuperFamID = 0, familyID = 55},  -- Bird
    [30] = {isSuperFamID = 0, familyID = 27},  -- Apkallu
    [31] = {isSuperFamID = 0, familyID = 70},  -- Cockatrice
    [32] = {isSuperFamID = 0, familyID = 226}, -- Sheep
    [33] = {isSuperFamID = 0, familyID = 242}, -- Tiger
    [34] = {isSuperFamID = 0, familyID = 180}, -- Marid
    [35] = {isSuperFamID = 0, familyID = 208}, -- Ram
    [36] = {isSuperFamID = 0, familyID = 216}, -- Sapling
    [37] = {isSuperFamID = 0, familyID = 114}, -- Flytrap
    [38] = {isSuperFamID = 0, familyID = 116}, -- Funguar
    [39] = {isSuperFamID = 0, familyID = 245}, -- Treant
    [40] = {isSuperFamID = 0, familyID = 186}, -- Morbol
    [41] = {isSuperFamID = 0, familyID = 174}, -- Lizard
    [42] = {isSuperFamID = 0, familyID = 210}, -- Raptor
    [43] = {isSuperFamID = 0, familyID = 58},  -- Bugard
    [44] = {isSuperFamID = 0, familyID = 257}, -- Wivre
    [45] = {isSuperFamID = 0, familyID = 102}, -- Fire Elemental
    [46] = {isSuperFamID = 0, familyID = 103}, -- Ice Elemental
    [47] = {isSuperFamID = 0, familyID = 99},  -- Wind Elemental
    [48] = {isSuperFamID = 0, familyID = 101}, -- Earth Elemental
    [49] = {isSuperFamID = 0, familyID = 105}, -- Thunder Elemental
    [50] = {isSuperFamID = 0, familyID = 106}, -- Water Elemental
    [51] = {isSuperFamID = 0, familyID = 100}, -- Dark Elemental
    [52] = {isSuperFamID = 0, familyID = 184}, -- Moblin
    [53] = {isSuperFamID = 0, familyID = 196}, -- Poroggo
    [54] = {isSuperFamID = 0, familyID = 213}, -- Sahagin
    [55] = {isSuperFamID = 0, familyID = 176}, -- Mamool Ja
    [56] = {isSuperFamID = 0, familyID = 171}, -- Lamiae
    [57] = {isSuperFamID = 0, familyID = 182}, -- Merrow
    [58] = {isSuperFamID = 0, familyID = 199}, -- Qiqirn
    [59] = {isSuperFamID = 0, familyID = 246}, -- Troll
    [60] = {isSuperFamID = 0, familyID = 117}, -- Qutrub
    [61] = {isSuperFamID = 0, familyID = 233}, -- Soulflayer
}

xi.znm.SANRAKUS_FAUNA = { -- Recommended Fauna refer to a specific enemy, identified by zone and type
    [1]  = {zone = xi.zone.MOUNT_ZHAYOLM,               name = "Cerberus"}, -- Mount Zhayolm
    [2]  = {zone = xi.zone.WAJAOM_WOODLANDS,            name = "Hydra"}, -- Wajaom Woodlands
    [3]  = {zone = xi.zone.ILRUSI_ATOLL,                name = "Cursed_Chest"}, -- Golden Salvage (Assault)
    [4]  = {zone = xi.zone.ILRUSI_ATOLL,                name = "Imp"}, -- Demolition Duty (Assault)
    [5]  = {zone = xi.zone.ILRUSI_ATOLL,                name = "Orobon"}, -- Desperately Seeking Cephalopods (Assault)
    [6]  = {zone = xi.zone.ILRUSI_ATOLL,                name = "Khimaira_14X"}, -- Bellerophon's Bliss (Assault)
    [7]  = {zone = xi.zone.ILRUSI_ATOLL,                name = "Martial_Maestro_Megomak"}, -- Bellerophon's Bliss (Assault)
    [8]  = {zone = xi.zone.PERIQIA,                     name = "Arrapago_Crab"}, -- Seagull Grounded (Assault)
    [9]  = {zone = xi.zone.PERIQIA,                     name = "Batteilant_Bhoot"}, -- Requiem (Assault)
    [10] = {zone = xi.zone.PERIQIA,                     name = "Black_Baron"}, -- Shooting Down the Baron (Assault)
    [11] = {zone = xi.zone.PERIQIA,                     name = "Qiqirn_Miner"}, -- Defuse the Threat (Assault)
    [12] = {zone = xi.zone.PERIQIA,                     name = "King_Goldemar"}, -- The Price is Right (Assault)
    [13] = {zone = xi.zone.LEBROS_CAVERN,               name = "Dahak"}, -- Evade and Escape (Assault)
    [14] = {zone = xi.zone.LEBROS_CAVERN,               name = "Ranch_Wamoura"}, -- Wamoura Farm Raid (Assault)
    [15] = {zone = xi.zone.LEBROS_CAVERN,               name = "Black_Shuck"}, -- Better Than One (Assault)
    [16] = {zone = xi.zone.LEBROS_CAVERN,               name = "Nocuous_Inferno"}, -- Better Than One (Assault)
    [17] = {zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS,  name = "Festive_Firedrake"}, -- Blitzkrieg (Assault)
    [18] = {zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS,  name = "Molted_Ziz"}, -- Blitzkrieg (Assault)
    [19] = {zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS,  name = "Marid"}, -- Marids in the Mist (Assault)
    [20] = {zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS,  name = "Poroggo"}, -- Azure Ailments (Assault)
    [21] = {zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS,  name = "Qiqirn_Huckster"}, -- Azure Ailments (Assault)
    [22] = {zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS,  name = "Leech"}, -- Azure Ailments (Assault)
    [23] = {zone = xi.zone.MAMOOL_JA_TRAINING_GROUNDS,  name = "Orochi"}, -- The Susanoo Shuffle (Assault)
    [24] = {zone = xi.zone.LEUJAOAM_SANCTUM,            name = "Coney"}, -- Shanarha Grass Conservation (Assault)
    [25] = {zone = xi.zone.LEUJAOAM_SANCTUM,            name = "Imp"}, -- Supplies Recovery (Assault)
    [26] = {zone = xi.zone.LEUJAOAM_SANCTUM,            name = "Count_Dracula"}, -- Bloody Rondo (Assault)
    [27] = {zone = xi.zone.THE_ASHU_TALIF,              name = "Bubbly"}, -- Targeting the Captain (Assault)
    [28] = {zone = xi.zone.TALACCA_COVE,                name = "Imp_Bandsman"}, -- Call to Arms (ISNM)
    [29] = {zone = xi.zone.TALACCA_COVE,                name = "Angler_Orobon"}, -- Compliments to the Chef (ISNM)
    [30] = {zone = xi.zone.NAVUKGO_EXECUTION_CHAMBER,   name = "Watch_Wamoura"}, -- Tough Nut to Crack (ISNM)
    [31] = {zone = xi.zone.NAVUKGO_EXECUTION_CHAMBER,   name = "Two-Faced_Flan"}, -- Happy Caster (ISNM)
    [32] = {zone = xi.zone.JADE_SEPULCHER,              name = "Mocking_Colibri"}, -- Making a Mockery (ISNM)
    [33] = {zone = xi.zone.JADE_SEPULCHER,              name = "Phantom_Puk"}, -- Shadows of the Mind (ISNM)
    [34] = {zone = xi.zone.NYZUL_ISLE,                  name = "Adamantoise"}, -- (Floors 20, 40)
    [35] = {zone = xi.zone.NYZUL_ISLE,                  name = "Behemoth"}, -- (Floors 20, 40)
    [36] = {zone = xi.zone.NYZUL_ISLE,                  name = "Fafnir"}, -- (Floors 20, 40)
    [37] = {zone = xi.zone.NYZUL_ISLE,                  name = "Khimaira"}, -- (Floors 60, 80, 100)
    [38] = {zone = xi.zone.NYZUL_ISLE,                  name = "Cerberus"}, -- (Floors 60, 80, 100)
    [39] = {zone = xi.zone.NYZUL_ISLE,                  name = "Hydra"}, -- (Floors 60, 80, 100)
    [40] = {zone = xi.zone.ZHAYOLM_REMNANTS,            name = "Battleclad_Chariot"}, -- Zhayolm Remnants (Salvage)
    [41] = {zone = xi.zone.ZHAYOLM_REMNANTS,            name = "Jakko"}, -- (Salvage)
    [42] = {zone = xi.zone.ARRAPAGO_REMNANTS,           name = "Armored_Chariot"}, -- (Salvage)
    [43] = {zone = xi.zone.ARRAPAGO_REMNANTS,           name = "Princess_Pudding"}, -- (Salvage)
    [44] = {zone = xi.zone.BHAFLAU_REMNANTS,            name = "Long-Bowed_Chariot"}, -- (Salvage)
    [45] = {zone = xi.zone.BHAFLAU_REMNANTS,            name = "Demented_Jalaawa"}, -- (Salvage)
    [46] = {zone = xi.zone.SILVER_SEA_REMNANTS,         name = "Long-Armed_Chariot"}, -- (Salvage)
    [47] = {zone = xi.zone.SILVER_SEA_REMNANTS,         name = "Don_Poroggo"}, -- (Salvage)
    [48] = {zone = xi.zone.HAZHALM_TESTING_GROUNDS,     -- First Wing Bosses (Einherjar - one spawns at random)
            name = {"Hakenmann", "Hildesvini", "Himinrjot", "Hraesvelg", "Morbol_Emperor", "Nihhus"}},
    [49] = {zone = xi.zone.HAZHALM_TESTING_GROUNDS,     -- Second Wing Bosses (Einherjar - one spawns at random)
            name = {"Andhrimnir", "Ariri_Samariri", "Balrahn", "Hrungnir", "Mokkuralfi", "Tanngrisnir"}},
    [50] = {zone = xi.zone.HAZHALM_TESTING_GROUNDS,     -- Third Wing Bosses (Einherjar - one spawns at random)
            name =  {"Dendainsonne", "Freke", "Gorgimera", "Motsognir", "Stoorworm", "Vampyr_Jarl"}},
    [51] = {zone = xi.zone.HAZHALM_TESTING_GROUNDS, "Odin"}, -- Odin's Chamber (Einherjar)
    [52] = {zone = xi.zone.AL_ZAHBI,                    name = "Gulool_Ja_Ja"}, -- Al Zhabi (Besieged)
    [53] = {zone = xi.zone.AL_ZAHBI,                    name = "Gurfurlur_the_Menacing"}, -- Al Zhabi (Besieged)
    [54] = {zone = xi.zone.AL_ZAHBI,                    name = "Medusa"}
}

------------------------------------------------------------
---- Sanraku's Trophy Trades and Pop Items
------------------------------------------------------------
xi.znm.TROPHIES = { -- [mob_trophy] = seal_rewarded
    [xi.items.VULPANGUES_WING]          = xi.keyItem.MAROON_SEAL,
    [xi.items.CHAMROSHS_BEAK]           = xi.keyItem.MAROON_SEAL,
    [xi.items.GIGIROONS_CAPE]           = xi.keyItem.MAROON_SEAL,
    [xi.items.BRASS_BORERS_COCOON]      = xi.keyItem.CERISE_SEAL,
    [xi.items.GLOBULE_OF_CLARET]        = xi.keyItem.CERISE_SEAL,
    [xi.items.OBS_ARM]                  = xi.keyItem.CERISE_SEAL,
    [xi.items.VELIONIS_BONE]            = xi.keyItem.PINE_GREEN_SEAL,
    [xi.items.LIL_APKALLUS_EGG]         = xi.keyItem.PINE_GREEN_SEAL,
    [xi.items.CHIGRE]                   = xi.keyItem.PINE_GREEN_SEAL,
    [xi.items.IRIZ_IMAS_HIDE]           = xi.keyItem.APPLE_GREEN_SEAL,
    [xi.items.AMOOSHAHS_TENDRIL]        = xi.keyItem.APPLE_GREEN_SEAL,
    [xi.items.IRIRI_SAMARIRIS_HAT]      = xi.keyItem.APPLE_GREEN_SEAL,
    [xi.items.ANANTABOGAS_HEART]        = xi.keyItem.SALMON_COLORED_SEAL,
    [xi.items.PILE_OF_REACTONS_ASHES]   = xi.keyItem.SALMON_COLORED_SEAL,
    [xi.items.BLOB_OF_DEXTROSE_BLUBBER] = xi.keyItem.SALMON_COLORED_SEAL,
    [xi.items.ZAREEHKLS_NECKPIECE]      = xi.keyItem.AMBER_COLORED_SEAL,
    [xi.items.VERDELETS_WING]           = xi.keyItem.AMBER_COLORED_SEAL,
    [xi.items.WULGARUS_HEAD]            = xi.keyItem.AMBER_COLORED_SEAL,
    [xi.items.ARMED_GEARS_FRAGMENT]     = xi.keyItem.CHARCOAL_GREY_SEAL,
    [xi.items.GOTOH_ZHAS_NECKLACE]      = xi.keyItem.DEEP_PURPLE_SEAL,
    [xi.items.DEAS_HORN]                = xi.keyItem.CHESTNUT_COLORED_SEAL,
    [xi.items.NOSFERATUS_CLAW]          = xi.keyItem.PURPLISH_GREY_SEAL,
    [xi.items.BHURBORLORS_VAMBRACE]     = xi.keyItem.GOLD_COLORED_SEAL,
    [xi.items.ACHAMOTHS_ANTENNA]        = xi.keyItem.COPPER_COLORED_SEAL,
    [xi.items.MAHJLAEFS_STAFF]          = xi.keyItem.FALLOW_COLORED_SEAL,
    [xi.items.EXPERIMENTAL_LAMIAS_ARMBAND] = xi.keyItem.TAUPE_COLORED_SEAL,
    [xi.items.NUHNS_ESCA]               = xi.keyItem.SIENNA_COLORED_SEAL,
    [xi.items.TINNINS_FANG]             = xi.keyItem.LILAC_COLORED_SEAL,
    [xi.items.SARAMEYAS_HIDE]           = xi.keyItem.BRIGHT_BLUE_SEAL,
    [xi.items.TYGERS_TAIL]              = xi.keyItem.LAVENDER_COLORED_SEAL
}

xi.znm.POP_ITEMS = {
    -- Ordered to match the csid options
    -- { popitemID, ZNMtier (for pop price updating), seals_to_remove}
    {item = xi.items.HELLCAGE_BUTTERFLY,            tier = 1, seal = 0},                             -- Vulpangue
    {item = xi.items.JUG_OF_FLORAL_NECTAR,          tier = 1, seal = 0},                             -- Chamrosh
    {item = xi.items.WEDGE_OF_RODENT_CHEESE,        tier = 1, seal = 0},                             -- Cheese Hoarder Gigiroon
    {item = xi.items.BUNCH_OF_SENORITA_PAMAMAS,     tier = 2, seal = xi.keyItem.MAROON_SEAL},        -- Iriz Ima
    {item = xi.items.JAR_OF_OILY_BLOOD,             tier = 2, seal = xi.keyItem.MAROON_SEAL},        -- Lividroot Amooshah
    {item = xi.items.STRAND_OF_SAMARIRI_CORPSEHAIR, tier = 2, seal = xi.keyItem.MAROON_SEAL},        -- Iriri Samariri
    {item = xi.items.BAR_OF_FERRITE,                tier = 3, seal = xi.keyItem.APPLE_GREEN_SEAL},   -- Armed Gear
    {item = xi.items.BAGGED_SHEEP_BOTFLY,           tier = 3, seal = xi.keyItem.APPLE_GREEN_SEAL},   -- Gotoh Zha the Redolent
    {item = xi.items.OLZHIRYAN_CACTUS_PADDLE,       tier = 3, seal = xi.keyItem.APPLE_GREEN_SEAL},   -- Dea
    {item = xi.items.JUG_OF_MONKEY_WINE,            tier = 4, seal = {xi.keyItem.CHARCOAL_GREY_SEAL, -- Tinnin
                                                                 xi.keyItem.DEEP_PURPLE_SEAL,
                                                                 xi.keyItem.CHESTNUT_COLORED_SEAL}},
    {item = xi.items.CLUMP_OF_SHADELEAVES,          tier = 1, seal = 0},                             -- Brass Borer
    {item = xi.items.BEAKER_OF_PECTIN,              tier = 1, seal = 0},                             -- Claret
    {item = xi.items.FLASK_OF_COG_LUBRICANT,        tier = 1, seal = 0},                             -- Ob
    {item = xi.items.SLAB_OF_RAW_BUFFALO,           tier = 2, seal = xi.keyItem.CERISE_SEAL},        -- Anantaboga
    {item = xi.items.LUMP_OF_BONE_CHARCOAL,         tier = 2, seal = xi.keyItem.CERISE_SEAL},        -- Reacton
    {item = xi.items.PINCH_OF_GRANULATED_SUGAR,     tier = 2, seal = xi.keyItem.CERISE_SEAL},        -- Dextrose
    {item = xi.items.VIAL_OF_PURE_BLOOD,            tier = 3, seal = xi.keyItem.SALMON_COLORED_SEAL},-- Nosferatu
    {item = xi.items.VINEGAR_PIE,                   tier = 3, seal = xi.keyItem.SALMON_COLORED_SEAL},-- Khromasoul Bhurborlor
    {item = xi.items.JAR_OF_ROCK_JUICE,             tier = 3, seal = xi.keyItem.SALMON_COLORED_SEAL},-- Achamoth
    {item = xi.items.CHUNK_OF_BUFFALO_CORPSE,       tier = 4, seal = {xi.keyItem.COPPER_COLORED_SEAL,-- Sarameya
                                                                 xi.keyItem.GOLD_COLORED_SEAL,
                                                                 xi.keyItem.PURPLISH_GREY_SEAL}},
    {item = xi.items.PILE_OF_GOLDEN_TEETH,          tier = 1, seal = 0},                             -- Velionis
    {item = xi.items.GREENLING,                     tier = 1, seal = 0},                             -- Lil' Apkallu
    {item = xi.items.BOTTLE_OF_SPOILT_BLOOD,        tier = 1, seal = 0},                             -- Chigre
    {item = xi.items.OPALUS_GEM,                    tier = 2, seal = xi.keyItem.PINE_GREEN_SEAL},    -- Wulgaru
    {item = xi.items.MERROW_NO_11_MOLTING,          tier = 2, seal = xi.keyItem.PINE_GREEN_SEAL},    -- Zareehkl the Jubilant
    {item = xi.items.MINT_DROP,                     tier = 2, seal = xi.keyItem.PINE_GREEN_SEAL},    -- Verdelet
    {item = xi.items.BOUND_EXORCISM_TREATISE,       tier = 3, seal = xi.keyItem.AMBER_COLORED_SEAL}, -- Mahjlaef the Paintorn
    {item = xi.items.CLUMP_OF_MYRRH,                tier = 3, seal = xi.keyItem.AMBER_COLORED_SEAL}, -- Experimental Lamia
    {item = xi.items.WHOLE_ROSE_SCAMPI,             tier = 3, seal = xi.keyItem.AMBER_COLORED_SEAL}, -- Nuhn
    {item = xi.items.CHUNK_OF_SINGED_BUFFALO,       tier = 4, seal = {xi.keyItem.TAUPE_COLORED_SEAL, -- Tyger
                                                                 xi.keyItem.FALLOW_COLORED_SEAL,
                                                                 xi.keyItem.SIENNA_COLORED_SEAL}},
    {item = xi.items.PANDEMONIUM_KEY,               tier = 5, seal = {xi.keyItem.LILAC_COLORED_SEAL, -- Pandemonium Warden
                                                                 xi.keyItem.LAVENDER_COLORED_SEAL,
                                                                 xi.keyItem.BRIGHT_BLUE_SEAL}}
}

------------------------------------------------------------
---- Sanraku's ZNM Menu Options
---- ZNM bitmask order is the same as pop_items' order
------------------------------------------------------------
-- Default: Tier 1 ZNMs + "Don't Ask"
-- (if bit = 0: add ZNM to Sanraku's Menu)
xi.znm.DefaultMenu = 0x7F8FE3F8

-- Adjusts the bitmask based on owned seals
xi.znm.MENU_BITMASKS = {
    [0x38]          = xi.keyItem.MAROON_SEAL,               -- Tinnin T2 ZNMs
    [0x1C0]         = xi.keyItem.APPLE_GREEN_SEAL,          -- Tinnin T3 ZNMs
    [0xE000]        = xi.keyItem.CERISE_SEAL,               -- Sarameya T2 ZNMs
    [0x70000]       = xi.keyItem.SALMON_COLORED_SEAL,       -- Sarameya T3 ZNMs
    [0x3800000]     = xi.keyItem.PINE_GREEN_SEAL ,          -- Tyger T2 ZNMs
    [0x1C000000]    = xi.keyItem.AMBER_COLORED_SEAL,        -- Tyger T3 ZNMs
    [0x200]         = {xi.keyItem.CHARCOAL_GREY_SEAL,       -- Tinnin
                       xi.keyItem.DEEP_PURPLE_SEAL,
                       xi.keyItem.CHESTNUT_COLORED_SEAL},
    [0x80000]       = {xi.keyItem.PURPLISH_GREY_SEAL,       -- Sarameya
                       xi.keyItem.GOLD_COLORED_SEAL,
                       xi.keyItem.COPPER_COLORED_SEAL},
    [0x20000000]    = {xi.keyItem.TAUPE_COLORED_SEAL,       -- Tyger
                       xi.keyItem.FALLOW_COLORED_SEAL,
                       xi.keyItem.SIENNA_COLORED_SEAL},
    [0x40000000]    = {xi.keyItem.LILAC_COLORED_SEAL,       -- Pandemonium Warden
                       xi.keyItem.BRIGHT_BLUE_SEAL,
                       xi.keyItem.LAVENDER_COLORED_SEAL}
}