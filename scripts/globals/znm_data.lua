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
xi.znm.SOULTRAPPER_SUCCESS      = 75  -- Base success rate (%)
xi.znm.SOULPLATE_HPP_MULT       = 3   -- Zeni multiplier for low hp %
xi.znm.SOULPLATE_INTEREST_MULT  = 3   -- Sanraku subject of interest multiplier
xi.znm.SOULPLATE_FAUNA_MULT     = 4   -- Sanraku recommended fauna multiplier
xi.znm.SOULPLATE_NM_MULT        = 2   -- Generic NM multiplier (won't stack with rec. fauna)
xi.znm.SOULPLATE_FACING_MULT    = 2   -- Soultrapper used while facing the target
xi.znm.SOULPLATE_HS_MULT        = 2   -- Using a High Speed soul plate
xi.znm.SOULPLATE_TRADE_LIMIT    = 10  -- The number of soul plates players can trade per day

-----------------------------------
---- ZNM Pop-Item Prices
-----------------------------------
-- Set to true if you want ZNM pop item prices to stay fixed
local ZNM_STATIC_POP_PRICES = false

local ZNM_POP_COSTS = {
    [1] = {minPrice = 1000, maxPrice = 2500, addedPrice = 100, decayPrice = 100},
    [2] = {minPrice = 2000, maxPrice = 5000, addedPrice = 200, decayPrice = 200},
    [3] = {minPrice = 3000, maxPrice = 7500, addedPrice = 300, decayPrice = 300},
    [4] = {minPrice = 4000, maxPrice = 9000, addedPrice = 400, decayPrice = 400},
    [5] = {minPrice = 5000, maxPrice = 12000, addedPrice = 500, decayPrice = 500}
}

xi.znm.getPopPrice = function(znm_tier)
    return GetServerVariable("[ZNM][T" .. znm_tier .. "]PopCost")
end

xi.znm.updatePopPrice = function(znm_tier)
    if not ZNM_STATIC_POP_PRICES then
        local price = math.min(GetServerVariable("[ZNM][T" .. znm_tier .. "]PopCost") + ZNM_POP_COSTS[znm_tier].addedPrice,
                ZNM_POP_COSTS[znm_tier].maxPrice)
        SetServerVariable("[ZNM][T" .. znm_tier .. "]PopCost", price )
    end
end

-- Prices decay over time (called every 2 hours)
xi.znm.ZNMPopPriceDecay = function()
    if not ZNM_STATIC_POP_PRICES then
        local price = 0
        for tier = 1,5 do
            price = math.max(GetServerVariable("[ZNM][T" .. tier .. "]PopCost") - ZNM_POP_COSTS[tier].decayPrice,
                    ZNM_POP_COSTS[tier].minPrice)
            SetServerVariable("[ZNM][T" .. tier .. "]PopCost", price)
        end
    end
end

--------------------------------------------------
---- Sanraku's Interest and Recommended Fauna
--------------------------------------------------
xi.znm.SANRAKUID = 16982568

-- Called during JstMidnight tick
xi.znm.UpdateSanrakusMobs = function()
    SetServerVariable('[ZNM][Sanraku]Interest', math.random(0,61))
    SetServerVariable('[ZNM][Sanraku]Fauna', math.random(0,54))
end

-- Get Sanraku's "Subject of Interest"
xi.znm.getSanrakusInterest = function()
    return GetServerVariable('[ZNM][Sanraku]Interest')
end

-- Get Sanraku's "Recommended Fauna"
xi.znm.getSanrakusFauna = function()
    return GetServerVariable('[ZNM][Sanraku]Fauna')
end

-- Does this mob fall under Sanraku's current "Subject of Interest"?
xi.znm.isCurrentInterest = function(superfamID, famID)
    local desiredFamily = xi.znm.getSanrakusInterest()
    local family_row = xi.znm.SANRAKUS_MOBS[desiredMob].interest
    -- Some families had multiple IDs (see Sea Monks), and some superIDs were too general (see elementals)
    -- Use of a single ID was for simplicity and minimizing errors/changes
    if not family_row[1] then  -- Check mob's family
        return family_row[2] == famID
    else                        -- Check mob's superfamily
        return family_row[2] == superfamID
    end
end

-- Does this mob fall under Sanraku's current "Recommended Fauna"?
xi.znm.isCurrentFauna = function(mobName, zoneID)
    local desiredMob = xi.znm.getSanrakusFauna()
    local fauna_row = xi.znm.SANRAKUS_MOBS[desiredMob].fauna
    if fauna_row[1] ~= zoneID then
        return false
    else
        for iter = 2, #fauna_row do
            if fauna_row[iter] == mobName then
                return true
            end
        end
    end
    return false
end

--- 54 total "Recommended Fauna" ('fauna')
--- 61 total "Subjects of Interest" ('family')
--------------------------------------
xi.znm.SANRAKUS_MOBS = {
    -- interest: {isSuperFamID?, (super)familyID}, fauna: {zoneID, name}
    [1] = {interest = {0,197}, -- Pugil
           fauna = {xi.zone.MOUNT_ZHAYOLM, "Cerberus"}}, -- Mount Zhayolm
    [2] = {interest = {1,129}, -- Sea Monk
           fauna = {xi.zone.WAJAOM_WOODLANDS, "Hydra"}}, -- Wajaom Woodlands
    [3] = {interest = {0,191}, -- Orobon
           fauna = {xi.zone.ILRUSI_ATOLL, "Cursed_Chest"}}, -- Golden Salvage (Assault)
    [4] = {interest = {0,258}, -- Worm
           fauna = {xi.zone.ILRUSI_ATOLL, "Imp"}}, -- Demolition Duty (Assault)
    [5] = {interest = {0,172}, -- Leech
           fauna = {xi.zone.ILRUSI_ATOLL, "Orobon"}}, -- Desperately Seeking Cephalopods (Assault)
    [6] = {interest = {1,42},-- Slime
           fauna = {xi.zone.ILRUSI_ATOLL, "Khimaira_14X"}}, -- Bellerophon's Bliss (Assault)
    [7] = {interest = {0,112}, -- Flan
           fauna = {xi.zone.ILRUSI_ATOLL, "Martial_Maestro_Megomak"}}, -- Bellerophon's Bliss (Assault)
    [8] = {interest = {0,56},  -- Bomb
           fauna = {xi.zone.PERIQIA, "Arrapago_Crab"}}, -- Seagull Grounded (Assault)
    [9] = {interest = {1,32},-- Cluster Bomb
           fauna = {xi.zone.PERIQIA, "Batteilant_Bhoot"}}, -- Requiem (Assault)
    [10] = {interest = {0,121}, -- Ghost
            fauna = {xi.zone.PERIQIA, "Black_Baron"}}, -- Shooting Down the Baron (Assault)
    [11] = {interest = {0,227}, -- Skeleton
            fauna = {xi.zone.PERIQIA, "Qiqirn_Miner"}}, -- Defuse the Threat (Assault)
    [12] = {interest = {0,86},  -- Doomed
            fauna = {xi.zone.PERIQIA, "King_Goldemar"}}, -- The Price is Right (Assault)
    [13] = {interest = {0,64},  -- Chigoe
            fauna = {xi.zone.LEBROS_CAVERN, "Dahak"}}, -- Evade and Escape (Assault)
    [14] = {interest = {0,235}, -- Spider
            fauna = {xi.zone.LEBROS_CAVERN, "Ranch_Wamoura"}}, -- Wamoura Farm Raid (Assault)
    [15] = {interest = {0,48},  -- Bee
            fauna = {xi.zone.LEBROS_CAVERN, "Black_Shuck"}}, -- Better Than One (Assault)
    [16] = {interest = {0,79},  -- Crawler
            fauna = {xi.zone.LEBROS_CAVERN, "Nocuous_Inferno"}}, -- Better Than One (Assault)
    [17] = {interest = {0,253}, -- Wamoura Larvae
            fauna = {xi.zone.MAMOOL_JA_TRAINING_GROUNDS, "Festive_Firedrake"}}, -- Blitzkrieg (Assault)
    [18] = {interest = {0,113}, -- Fly
            fauna = {xi.zone.MAMOOL_JA_TRAINING_GROUNDS, "Molted_Ziz"}}, -- Blitzkrieg (Assault)
    [19] = {interest = {0,81},  -- Diremite
            fauna = {xi.zone.MAMOOL_JA_TRAINING_GROUNDS, "Marid"}}, -- Marids in the Mist (Assault)
    [20] = {interest = {0,217}, -- Scorpion
            fauna = {xi.zone.MAMOOL_JA_TRAINING_GROUNDS, "Poroggo"}}, -- Azure Ailments (Assault)
    [21] = {interest = {0,254}, -- Wamoura
            fauna = {xi.zone.MAMOOL_JA_TRAINING_GROUNDS, "Qiqirn_Huckster"}}, -- Azure Ailments (Assault)
    [22] = {interest = {1,89},-- Imp
            fauna = {xi.zone.MAMOOL_JA_TRAINING_GROUNDS, "Leech"}}, -- Azure Ailments (Assault)
    [23] = {interest = {0,198}, -- Puk
            fauna = {xi.zone.MAMOOL_JA_TRAINING_GROUNDS, "Orochi"}}, -- The Susanoo Shuffle (Assault)
    [24] = {interest = {1,109},-- Wyvern
            fauna = {xi.zone.LEUJAOAM_SANCTUM, "Coney"}}, -- Shanarha Grass Conservation (Assault)
    [25] = {interest = {0,87},  -- Dragon
            fauna = {xi.zone.LEUJAOAM_SANCTUM, "Imp"}}, -- Supplies Recovery (Assault)
    [26] = {interest = {0,46},  -- Bat
            fauna = {xi.zone.LEUJAOAM_SANCTUM, "Count_Dracula"}}, -- Bloody Rondo (Assault)
    [27] = {interest = {0,47},  -- Bat Trio
            fauna = {xi.zone.THE_ASHU_TALIF, "Bubbly"}}, -- Targeting the Captain (Assault)
    [28] = {interest = {0,72},  -- Colibri
            fauna = {xi.zone.TALACCA_COVE, "Imp_Bandsman"}}, -- Call to Arms (ISNM)
    [29] = {interest = {0,55},  -- Bird
            fauna = {xi.zone.TALACCA_COVE, "Angler_Orobon"}}, -- Compliments to the Chef (ISNM)
    [30] = {interest = {0,27},  -- Apkallu
            fauna = {xi.zone.NAVUKGO_EXECUTION_CHAMBER, "Watch_Wamoura"}}, -- Tough Nut to Crack (ISNM)
    [31] = {interest = {0,70},  -- Cockatrice
            fauna = {xi.zone.NAVUKGO_EXECUTION_CHAMBER, "Two-Faced_Flan"}}, -- Happy Caster (ISNM)
    [32] = {interest = {0,226}, -- Sheep
            fauna = {xi.zone.JADE_SEPULCHER, "Mocking_Colibri"}}, -- Making a Mockery (ISNM)
    [33] = {interest = {0,242}, -- Tiger
            fauna = {xi.zone.JADE_SEPULCHER, "Phantom_Puk"}}, -- Shadows of the Mind (ISNM)
    [34] = {interest = {0,180}, -- Marid
            fauna = {xi.zone.NYZUL_ISLE, "Adamantoise"}}, -- (Floors 20, 40)
    [35] = {interest = {0,208}, -- Ram
            fauna = {xi.zone.NYZUL_ISLE, "Behemoth"}}, -- (Floors 20, 40)
    [36] = {interest = {0,216}, -- Sapling
            fauna = {xi.zone.NYZUL_ISLE, "Fafnir"}}, -- (Floors 20, 40)
    [37] = {interest = {0,114}, -- Flytrap
            fauna = {xi.zone.NYZUL_ISLE, "Khimaira"}}, -- (Floors 60, 80, 100)
    [38] = {interest = {0,116}, -- Funguar
            fauna = {xi.zone.NYZUL_ISLE, "Cerberus"}}, -- (Floors 60, 80, 100)
    [39] = {interest = {0,245}, -- Treant
            fauna = {xi.zone.NYZUL_ISLE, "Hydra"}}, -- (Floors 60, 80, 100)
    [40] = {interest = {0,186}, -- Morbol
            fauna = {xi.zone.ZHAYOLM_REMNANTS, "Battleclad_Chariot"}}, -- Zhayolm Remnants (Salvage)
    [41] = {interest = {0,174}, -- Lizard
            fauna = {xi.zone.ZHAYOLM_REMNANTS, "Jakko"}}, -- (Salvage)
    [42] = {interest = {0,210}, -- Raptor
            fauna = {xi.zone.ARRAPAGO_REMNANTS, "Armored_Chariot"}}, -- (Salvage)
    [43] = {interest = {0,58}, -- Bugard
            fauna = {xi.zone.ARRAPAGO_REMNANTS, "Princess_Pudding"}}, -- (Salvage)
    [44] = {interest = {0,257}, -- Wivre
            fauna = {xi.zone.BHAFLAU_REMNANTS, "Long-Bowed_Chariot"}}, -- (Salvage)
    [45] = {interest = {0,102}, -- Fire Elemental
            fauna = {xi.zone.BHAFLAU_REMNANTS, "Demented_Jalaawa"}}, -- (Salvage)
    [46] = {interest = {0,103}, -- Ice Elemental
            fauna = {xi.zone.SILVER_SEA_REMNANTS, "Long-Armed_Chariot"}}, -- (Salvage)
    [47] = {interest = {0,99},  -- Wind Elemental
            fauna = {xi.zone.SILVER_SEA_REMNANTS, "Don_Poroggo"}}, -- (Salvage)
    [48] = {interest = {0,101}, -- Earth Elemental
            fauna = {xi.zone.HAZHALM_TESTING_GROUNDS, -- First Wing Bosses (Einherjar - one spawns at random)
                     "Hakenmann", "Hildesvini", "Himinrjot", "Hraesvelg", "Morbol_Emperor", "Nihhus"}},
    [49] = {interest = {0,105}, -- Thunder Elemental
            fauna = {xi.zone.HAZHALM_TESTING_GROUNDS, -- Second Wing Bosses (Einherjar - one spawns at random)
                     "Andhrimnir", "Ariri_Samariri", "Balrahn", "Hrungnir", "Mokkuralfi", "Tanngrisnir"}},
    [50] = {interest = {0,106}, -- Water Elemental
            fauna = {xi.zone.HAZHALM_TESTING_GROUNDS, -- Third Wing Bosses (Einherjar - one spawns at random)
                     "Dendainsonne", "Freke", "Gorgimera", "Motsognir", "Stoorworm", "Vampyr_Jarl"}},
    [51] = {interest = {0,100}, -- Dark Elemental
            fauna = {xi.zone.HAZHALM_TESTING_GROUNDS, "Odin"}}, -- Odin's Chamber (Einherjar)
    [52] = {interest = {0,184}, -- Moblin
            fauna = {xi.zone.AL_ZAHBI, "Gulool_Ja_Ja"}}, -- Al Zhabi (Besieged)
    [53] = {interest = {0,196}, -- Poroggo
            fauna = {xi.zone.AL_ZAHBI, "Gurfurlur_the_Menacing"}}, -- Al Zhabi (Besieged)
    [54] = {interest = {0,213}, -- Sahagin
            fauna = {xi.zone.AL_ZAHBI, "Medusa"}}, -- Al Zhabi (Besieged)
    [55] = {interest = {0,176}, fauna = 0},           -- Mamool Ja
    [56] = {interest = {0,171}, fauna = 0},           -- Lamiae
    [57] = {interest = {0,182}, fauna = 0},           -- Merrow
    [58] = {interest = {0,199}, fauna = 0},           -- Qiqirn
    [59] = {interest = {0,246}, fauna = 0},           -- Troll
    [60] = {interest = {1,117}, fauna = 0},           -- Qutrub
    [61] = {interest = {0,233}, fauna = 0},           -- Soulflayer
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