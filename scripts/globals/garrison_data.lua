-----------------------------------
-- Garrison Data
-----------------------------------
require("scripts/globals/zone")
require("scripts/globals/items")
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}

-- Name is Determined by Nation and LevelCap
xi.garrison.names =
{
    --level 20 garrison names
    [20] =
    {
        [0] =
        {
            npcName = "Patrician"
        },
        [1] =
        {
            npcName = "Recruit"
        },
        [2] =
        {
            npcName = "Candidate"
        },
    },
    --level 30 garrison names
    [30] =
    {
        [0] =
        {
            npcName = "Trader"
        },
        [1] =
        {
            npcName = "Mariner"
        },
        [2] =
        {
            npcName = "Scholar"
        },
    },
    --level 40 garrison names
    [40] =
    {
        [0] =
        {
            npcName = "TempleKnight"
        },
        [1] =
        {
            npcName = "UNKNOWN"
        },
        [2] =
        {
            npcName = "UNKNOWN"
        },
    },
    --level 50 garrison names
    [50] =
    {
        [0] =
        {
            npcName = "UNKNOWN"
        },
        [1] =
        {
            npcName = "GoldMusketeer"
        },
        [2] =
        {
            npcName = "Patriarch"
        },
    },
    --level 99 garrison names
    [99] =
    {
        [0] =
        {
            npcName = "MilitaryAttache"
        },
        [1] =
        {
            npcName = "MilitaryAttache"
        },
        [2] =
        {
            npcName = "MilitaryAttache"
        },
    },
}
-- Look is Determined by Nation and LevelCap (Appears to be 4 for each outpost need more data though)
xi.garrison.looks =
{
    --level 20 garrison looks
    [20] =
    {
        [0] =
        {
            804,
            805
            -- "0x01000C030010262000303A403A5008611B700000",
            -- "0x01000A040010262019303A40195008611C700000"
        },
        [1] =
        {
            804,
            805
        },
        [2] =
        {
            804,
            805
        },
    },
    --level 30 garrison looks
    [30] =
    {
        [0] =
        {
            804,
            805
            -- "0x010006030010762076303A400650736000700000",
            -- "0x01000F0300101520153015401550006000700000",
            -- "0x010009040010762076303A400650736000700000",
            -- "0x01000E0400101520003015401550006000700000"
        },
        [1] =
        {
            804,
            805
        },
        [2] =
        {
            804,
            805
        },
    },
    --level 40 garrison looks
    [40] =
    {
        [0] =
        {
            804,
            805
            -- "0x01000E04191019201930194019506B601C700000",
            -- "0x01000903191019201930194019506B601C700000"
        },
        [1] =
        {
            804,
            805
        },
        [2] =
        {
            804,
            805
        },
    },
    --level 50 garrison looks
    [50] =
    {
        [0] =
        {
            804,
            805
        },
        [1] =
        {
            804,
            805
        },
        [2] =
        {
            804,
            805
            -- "0x0100020600106320633063406350056122700000",
            -- "0x010004067C102D20193019401950506100700000",
            -- "0x0100080669106B206B306B406B50FE6000700000"
        },
    },
    --level 99 garrison looks
    [99] =
    {
        [0] =
        {
            804,
            805
        },
        [1] =
        {
            804,
            805
            -- "0x010002071C1070201C301C401C50C46000700000"
        },
        [2] =
        {
            804,
            805
        },
    },
}
-- Loot is determined by LevelCap
xi.garrison.loot =
{
    --level 20 garrison loot
    [20] =
    {
        {itemId = xi.items.DRAGON_CHRONICLES, dropRate = 1000},
        {itemId = xi.items.GARRISON_TUNICA, dropRate = 350},
        {itemId = xi.items.GARRISON_BOOTS, dropRate = 350},
        {itemId = xi.items.GARRISON_HOSE, dropRate = 350},
        {itemId = xi.items.GARRISON_GLOVES, dropRate = 350},
        {itemId = xi.items.GARRISON_SALLET, dropRate = 350},
    },
    --level 30 garrison loot
    [30] =
    {
        {itemId = xi.items.DRAGON_CHRONICLES, dropRate = 1000},
        {itemId = xi.items.MILITARY_GUN, dropRate = 350},
        {itemId = xi.items.MILITARY_POLE, dropRate = 350},
        {itemId = xi.items.MILITARY_HARP, dropRate = 350},
        {itemId = xi.items.MILITARY_PICK, dropRate = 350},
        {itemId = xi.items.MILITARY_SPEAR, dropRate = 350},
        {itemId = xi.items.MILITARY_AXE, dropRate = 350},
    },
    --level 40 garrison loot
    [40] =
    {
        {itemId = xi.items.DRAGON_CHRONICLES, dropRate = 1000},
        {itemId = xi.items.VARIABLE_MANTLE, dropRate = 350},
        {itemId = xi.items.VARIABLE_CAPE, dropRate = 350},
        {itemId = xi.items.PROTEAN_RING, dropRate = 350},
        {itemId = xi.items.VARIABLE_RING, dropRate = 350},
        {itemId = xi.items.MECURIAL_EARRING, dropRate = 350},
    },
    --level 50 garrison loot
    [50] =
    {
        {itemId = xi.items.DRAGON_CHRONICLES, dropRate = 1000},
        {itemId = xi.items.UNDEAD_EARRING, dropRate = 350},
        {itemId = xi.items.ARCANA_EARRING, dropRate = 350},
        {itemId = xi.items.VERMIN_EARRING, dropRate = 350},
        {itemId = xi.items.BIRD_EARRING, dropRate = 350},
        {itemId = xi.items.AMORPH_EARRING, dropRate = 350},
        {itemId = xi.items.LIZARD_EARRING, dropRate = 350},
        {itemId = xi.items.AQUAN_EARRING, dropRate = 350},
        {itemId = xi.items.PLANTOID_EARRING, dropRate = 350},
        {itemId = xi.items.BEAST_EARRING, dropRate = 350},
        {itemId = xi.items.DEMON_EARRING, dropRate = 350},
        {itemId = xi.items.DRAGON_EARRING, dropRate = 350},
        {itemId = xi.items.REFRESH_EARRING, dropRate = 350},
        {itemId = xi.items.ACCURATE_EARRING, dropRate = 350},
    },
    --level 99 garrison loot
    [99] =
    {
        {itemId = xi.items.MIRATETES_MEMOIRS, dropRate = 1000},
        {itemId = xi.items.MIGHTY_BOW, dropRate = 350},
        {itemId = xi.items.MIGHTY_CUDGEL, dropRate = 350},
        {itemId = xi.items.MIGHTY_POLE, dropRate = 350},
        {itemId = xi.items.MIGHTY_TALWAR, dropRate = 350},
        {itemId = xi.items.RAI_KUNIMITSU, dropRate = 350},
        {itemId = xi.items.NUKEMARU, dropRate = 350},
        {itemId = xi.items.MIGHTY_PICK, dropRate = 350},
        {itemId = xi.items.MIGHTY_KNIFE, dropRate = 350},
        {itemId = xi.items.MIGHTY_ZAGHNAL, dropRate = 350},
        {itemId = xi.items.MIGHTY_LANCE, dropRate = 350},
        {itemId = xi.items.MIGHTY_AXE, dropRate = 350},
        {itemId = xi.items.MIGHTY_PATAS, dropRate = 350},
        {itemId = xi.items.MIGHTY_SWORD, dropRate = 350},
    },
}
--Zone Data
xi.garrison.data =
{
    [xi.zone.WEST_RONFAURE] =
    {
        itemReq = xi.items.RED_CRYPTEX,
        textRegion = 0,
        levelCap = 20,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Orcish_Fighterchief",
        xPos = -436,
        yPos = -20,
        zPos = -217,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
            [1] =
            {
                4, -- Orcish Fighter
                3  -- Orcish Fighter
            },
            [2] =
            {
                4, -- Orcish Fighter
                3, -- Orcish Fighter
                2, -- Orcish Chasseur
                1  -- Orcish Chasseur
            },
            [3] =
            {
                6, -- Orcish Serjeant
                5, -- Orcish Serjeant
                4, -- Orcish Fighter
                3, -- Orcish Fighter
                2, -- Orcish Chasseur
                1  -- Orcish Chasseur
            },
            [4] =
            {
                8, -- Orcish_Cursemaker
                7, -- Orcish_Cursemaker
                6, -- Orcish Serjeant
                5, -- Orcish Serjeant
                4, -- Orcish Fighter
                3, -- Orcish Fighter
                2, -- Orcish Chasseur
                1  -- Orcish Chasseur
            },
        },
    },
    [xi.zone.NORTH_GUSTABERG] =
    {
        itemReq = xi.items.DARKSTEEL_ENGRAVING,
        textRegion = 1,
        levelCap = 20,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Lead_Quadav",
        xPos = -580, --needs adjusting
        yPos = 40,
        zPos = 69,
        xChange = 1,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 106,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.WEST_SARUTABARUTA] =
    {
        itemReq = xi.items.SEVEN_KNOT_QUIPU,
        textRegion = 2,
        levelCap = 20,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Yagudo_Condottiere",
        xPos = -20, -- needs adjusting
        yPos = -12,
        zPos = 325,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 115,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.VALKURM_DUNES] =
    {
        itemReq = xi.items.GALKA_FANG_SACK,
        textRegion = 3,
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Goblin_Swindler",
        xPos = 141, -- needs adjusting
        yPos = -8,
        zPos = 87,
        xChange = -2,
        zChange = -2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 32,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.JUGNER_FOREST] =
    {
        itemReq = xi.items.JADE_CRYPTEX,
        textRegion = 4,
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Orcish_Colonel",
        xPos = 54, -- needs adjusting
        yPos = 1,
        zPos = -1,
        xChange = -2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine = 0,
        zThirdLine = 4,
        rot = 210,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        itemReq = xi.items.SILVER_ENGRAVING,
        textRegion = 5,
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Cobalt_Quadav",
        xPos = 458, -- needs adjusting
        yPos = 24,
        zPos = 421,
        xChange = -2,
        zChange = -2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 130,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        itemReq = xi.items.MITHRA_FANG_SACK,
        textRegion = 6,
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Goblin_Guide",
        xPos = -485, -- needs adjusting
        yPos = -29,
        zPos = 58,
        xChange = -2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = -2,
        xThirdLine = 0,
        zThirdLine = -4,
        rot = 0,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        itemReq = xi.items.THIRTEEN_KNOT_QUIPU,
        textRegion = 7,
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Yagudo_Missionary",
        xPos = -299, -- needs adjusting
        yPos = 17,
        zPos = 411,
        xChange = 2,
        zChange = -2,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine = 0,
        zThirdLine = 4,
        rot = 30,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        itemReq = xi.items.RAM_LEATHER_MISSIVE,
        textRegion = 10,
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Hunting_Chief",
        xPos = -247, -- needs adjusting
        yPos = -19,
        zPos = 310,
        xChange = -2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = -2,
        xThirdLine = 0,
        zThirdLine = -4,
        rot = 0,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        itemReq = xi.items.TIGER_LEATHER_MISSIVE,
        textRegion = 8,
        levelCap = 40,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Gigas_Overseer",
        xPos = -25, -- needs adjusting
        yPos = -60,
        zPos = -110,
        xChange = -2,
        zChange = -1,
        xSecondLine = 0,
        zSecondLine = -1,
        xThirdLine = 0,
        zThirdLine = -2,
        rot = 220,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        itemReq = xi.items.HOUND_FANG_SACK,
        textRegion = 11,
        levelCap = 40,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Goblin_Doyen",
        xPos = -43,
        yPos = 1,
        zPos = -140,
        xChange = -2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine = 0,
        zThirdLine = 4,
        rot = 180,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
            [1] =
            {
                8, -- Goblin Enchanter
                7  -- Goblin Enchanter
            },
            [2] =
            {
                8, -- Goblin Enchanter
                7, -- Goblin Enchanter
                6, -- Goblin Poacher
                5  -- Goblin Poacher
            },
            [3] =
            {
                8, -- Goblin Enchanter
                7, -- Goblin Enchanter
                6, -- Goblin Poacher
                5, -- Goblin Poacher
                4, -- Goblin Bouncer
                3  -- Goblin Bouncer
            },
            [4] =
            {
                8, -- Goblin Enchanter
                7, -- Goblin Enchanter
                6, -- Goblin Poacher
                5, -- Goblin Poacher
                4, -- Goblin Bouncer
                3, -- Goblin Bouncer
                2, -- Goblin Reaper
                1  -- Goblin Reaper
            },
        },
    },
    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        itemReq = xi.items.SHEEP_LEATHER_MISSIVE,
        textRegion = 14,
        levelCap = 40,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Sahagin_Patriarch",
        xPos = -248,
        yPos = 1,
        zPos = -392,
        xChange = -2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine = 0,
        zThirdLine = 4,
        rot = 180,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.XARCABARD] =
    {
        itemReq = xi.items.BEHEMOTH_LEATHER_MISSIVE,
        textRegion = 9,
        levelCap = 50,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Demon_Aristocrat",
        xPos = 216, -- needs adjusting
        yPos = -22,
        zPos = -208,
        xChange = 2,
        zChange = 0,
        xSecondLine = 0,
        zSecondLine = 2,
        xThirdLine = 0,
        zThirdLine = 4,
        rot = 90,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        itemReq = xi.items.DHALMEL_LEATHER_MISSIVE,
        textRegion = 12,
        levelCap = 50,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Centurio_XIII-V",
        xPos = -245,
        yPos = -9,
        zPos = -249,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
        -- TODO Capture Correct Wave Order
            [1] =
            {
                8,
                7
            },
            [2] =
            {
                8,
                7,
                6,
                5
            },
            [3] =
            {
                8,
                7,
                6,
                5,
                4,
                3
            },
            [4] =
            {
                8,
                7,
                6,
                5,
                4,
                3,
                2,
                1
            },
        },
    },
    [xi.zone.YHOATOR_JUNGLE] =
    {
        itemReq = xi.items.COEURL_LEATHER_MISSIVE,
        textRegion = 15,
        levelCap = 50,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Tonberry_Decimator",
        xPos = 214,
        yPos = 1,
        zPos = -80,
        xChange = 1,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = -1,
        xThirdLine = 4,
        zThirdLine = -2,
        rot = 0,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
            [1] =
            {
                8, -- Tonberry Creeper
                7  -- Tonberry Creeper
            },
            [2] =
            {
                8, -- Tonberry Creeper
                7, -- Tonberry Creeper
                6, -- Tonberry Hexer
                5  -- Tonberry Hexer
            },
            [3] =
            {
                8, -- Tonberry Creeper
                7, -- Tonberry Creeper
                6, -- Tonberry Hexer
                5, -- Tonberry Hexer
                4, -- Tonberry Creeper
                3  -- Tonberry Creeper
            },
            [4] =
            {
                8, -- Tonberry Creeper
                7, -- Tonberry Creeper
                6, -- Tonberry Hexer
                5, -- Tonberry Hexer
                4, -- Tonberry Creeper
                3, -- Tonberry Creeper
                2, -- Tonberry Hexer
                1  -- Tonberry Hexer
            },
        },
    },
    [xi.zone.CAPE_TERIGGAN] =
    {
        itemReq = xi.items.BUNNY_FANG_SACK,
        textRegion = 13,
        levelCap = 99, -- Level_Restriction 99
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobBoss = "Goblin_Boss",
        xPos = -174,
        yPos = 8,
        zPos = -61,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        waveOrder =
        {
        -- # Represents the negative offset from boss to spawn
            [1] =
            {
                8, -- Goblin Pirate
                7  -- Goblin Pirate
            },
            [2] =
            {
                8, -- Goblin Pirate
                7, -- Goblin Pirate
                6, -- Goblin Duelist
                5  -- Goblin Duelist
            },
            [3] =
            {
                8, -- Goblin Pirate
                7, -- Goblin Pirate
                6, -- Goblin Duelist
                5, -- Goblin Duelist
                4, -- Goblin Doctor
                3  -- Goblin Doctor
            },
            [4] =
            {
                8, -- Goblin Pirate
                7, -- Goblin Pirate
                6, -- Goblin Duelist
                5, -- Goblin Duelist
                4, -- Goblin Doctor
                3, -- Goblin Doctor
                2, -- Goblin Professor
                1  -- Goblin Professor
            },
        },
    },
}
