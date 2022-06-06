-----------------------------------
-- Garrison Data
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}

-- Loot is determined by LevelCap
xi.garrison.loot =
{
    --level 20 garrison loot
    [20] =
    {
        {itemId = 4198, dropRate = 1000}, -- Dragon Chronicles
        {itemId = 13818, dropRate = 300}, -- Garrison Tunica
        {itemId = 14206, dropRate = 300}, -- Garrison Boots
        {itemId = 14314, dropRate = 300}, -- Garrison Hose
        {itemId = 14841, dropRate = 300}, -- Garrison Gloves
        {itemId = 15147, dropRate = 300}, -- Garrison Sallet
    },
    --level 30 garrison loot
    [30] =
    {
        {itemId = 4198, dropRate = 1000}, -- Dragon Chronicles
        {itemId = 17272, dropRate = 300}, -- Military Gun
        {itemId = 17580, dropRate = 300}, -- Military Pole
        {itemId = 17839, dropRate = 300}, -- Military Harp
        {itemId = 17940, dropRate = 300}, -- Military Pick
        {itemId = 18090, dropRate = 300}, -- Military Spear
        {itemId = 18212, dropRate = 300}, -- Military Axe
    },
    --level 40 garrison loot
    [40] =
    {
        {itemId = 4198, dropRate = 1000}, -- Dragon Chronicles
        {itemId = 13680, dropRate = 300}, -- Variable Mantle
        {itemId = 13681, dropRate = 300}, -- Variable Cape
        {itemId = 14652, dropRate = 300}, -- Protean Ring
        {itemId = 14653, dropRate = 300}, -- Variable Ring
        {itemId = 14757, dropRate = 300}, -- Mecurial Earring
    },
    --level 50 garrison loot
    [50] =
    {
        {itemId = 4198, dropRate = 1000}, -- Dragon Chronicles
        {itemId = 14744, dropRate = 300}, -- Undead Earring
        {itemId = 14745, dropRate = 300}, -- Arcana Earring
        {itemId = 14746, dropRate = 300}, -- Vermin Earring
        {itemId = 14747, dropRate = 300}, -- Bird Earring
        {itemId = 14748, dropRate = 300}, -- Amorph Earring
        {itemId = 14749, dropRate = 300}, -- Lizard Earring
        {itemId = 14750, dropRate = 300}, -- Aquan Earring
        {itemId = 14751, dropRate = 300}, -- Plantoid Earring
        {itemId = 14752, dropRate = 300}, -- Beast Earring
        {itemId = 14753, dropRate = 300}, -- Demon Earring
        {itemId = 14754, dropRate = 300}, -- Dragon Earring
        {itemId = 14755, dropRate = 300}, -- Refresh Earring
        {itemId = 14756, dropRate = 300}, -- Accurate Earring
    },
    --level 75 garrison loot
    [75] =
    {
        {itemId = 4247, dropRate = 1000}, -- Miratete's Memoirs
        {itemId = 17204, dropRate = 300}, -- Mighty Bow
        {itemId = 17465, dropRate = 300}, -- Mighty Cudgel
        {itemId = 17581, dropRate = 300}, -- Mighty Pole
        {itemId = 17697, dropRate = 300}, -- Mighty Talwar
        {itemId = 17791, dropRate = 300}, -- Rai Kunimitsu
        {itemId = 17824, dropRate = 300}, -- Nukemaru
        {itemId = 17941, dropRate = 300}, -- Mighty Pick
        {itemId = 18000, dropRate = 300}, -- Mighty Knife
        {itemId = 18049, dropRate = 300}, -- Mighty Zaghnal
        {itemId = 18091, dropRate = 300}, -- Mighty Lance
        {itemId = 18213, dropRate = 300}, -- Mighty Axe
        {itemId = 18352, dropRate = 300}, -- Mighty Patas
        {itemId = 18374, dropRate = 300}, -- Mighty Sword
    },

}
--Zone Data
xi.garrison.data =
{
    [xi.zone.WEST_RONFAURE] =
    {
        itemReq = 1528, -- Red Cryptex
        levelCap = 20,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17187274,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17187278, -- Orcish Fighter
                17187279 -- Orcish Fighter
            },
            [2] =
            {
                17187278, -- Orcish Fighter
                17187279, -- Orcish Fighter
                17187280, -- Orcish Chasseur
                17187281 -- Orcish Chasseur
            },
            [3] =
            {
                17187276, -- Orcish Serjeant
                17187277, -- Orcish Serjeant
                17187278, -- Orcish Fighter
                17187279, -- Orcish Fighter
                17187280, -- Orcish Chasseur
                17187281 -- Orcish Chasseur
            },
            [4] =
            {
                17187274, -- Orcish_Cursemaker
                17187275, -- Orcish_Cursemaker
                17187276, -- Orcish Serjeant
                17187277, -- Orcish Serjeant
                17187278, -- Orcish Fighter
                17187279, -- Orcish Fighter
                17187280, -- Orcish Chasseur
                17187281 -- Orcish Chasseur
            },
            [5] =
            {
                17187274, -- Orcish_Cursemaker
                17187275, -- Orcish_Cursemaker
                17187276, -- Orcish Serjeant
                17187277, -- Orcish Serjeant
                17187278, -- Orcish Fighter
                17187279, -- Orcish Fighter
                17187280, -- Orcish Chasseur
                17187281 -- Orcish Chasseur
            },
            [6] =
            {
                17187274, -- Orcish_Cursemaker
                17187275, -- Orcish_Cursemaker
                17187276, -- Orcish Serjeant
                17187277, -- Orcish Serjeant
                17187278, -- Orcish Fighter
                17187279, -- Orcish Fighter
                17187280, -- Orcish Chasseur
                17187281 -- Orcish Chasseur
            },
        },
    },
    [xi.zone.NORTH_GUSTABERG] =
    {
        itemReq = 1529, -- Darksteel Engraving
        levelCap = 20,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17211849,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- TODO Get Correct Wave Order enter pos data for all mobs
            [1] =
            {
                17211849,
                17211850
            },
            [2] =
            {
                17211849,
                17211850,
                17211851,
                17211852
            },
            [3] =
            {
                17211849,
                17211850,
                17211851,
                17211852,
                17211853,
                17211854
            },
            [4] =
            {
                17211849,
                17211850,
                17211851,
                17211852,
                17211853,
                17211854,
                17211855,
                17211856
            },
            [5] =
            {
                17211849,
                17211850,
                17211851,
                17211852,
                17211853,
                17211854,
                17211855,
                17211856
            },
            [6] =
            {
                17211849,
                17211850,
                17211851,
                17211852,
                17211853,
                17211854,
                17211855,
                17211856
            },
        },
    },
    [xi.zone.WEST_SARUTABARUTA] =
    {
        itemReq = 1530, -- Seven-Knot Quipu
        levelCap = 20,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17248598,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- TODO Get Correct Wave Order
            [1] =
            {
                17248598,
                17248599
            },
            [2] =
            {
                17248598,
                17248599,
                17248600,
                17248601
            },
            [3] =
            {
                17248598,
                17248599,
                17248600,
                17248601,
                17248602,
                17248603
            },
            [4] =
            {
                17248598,
                17248599,
                17248600,
                17248601,
                17248602,
                17248603,
                17248604,
                17248605
            },
            [5] =
            {
                17248598,
                17248599,
                17248600,
                17248601,
                17248602,
                17248603,
                17248604,
                17248605
            },
            [6] =
            {
                17248598,
                17248599,
                17248600,
                17248601,
                17248602,
                17248603,
                17248604,
                17248605
            },
        },
    },
    [xi.zone.VALKURM_DUNES] =
    {
        itemReq = 1531, -- Galka Fang Sack
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17199593,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17199593, -- Goblin Swordmaker
                17199594 -- Goblin Swordmaker
            },
            [2] =
            {
                17199593, -- Goblin Swordmaker
                17199594, -- Goblin Swordmaker
                17199595, -- Goblin Leecher
                17199596 -- Goblin Leecher
            },
            [3] =
            {
                17199593, -- Goblin Swordmaker
                17199594, -- Goblin Swordmaker
                17199595, -- Goblin Leecher
                17199596, -- Goblin Leecher
                17199597, -- Goblin Gaoler
                17199598 -- Goblin Gaoler
            },
            [4] =
            {
                17199593, -- Goblin Swordmaker
                17199594, -- Goblin Swordmaker
                17199595, -- Goblin Leecher
                17199596, -- Goblin Leecher
                17199597, -- Goblin Gaoler
                17199598, -- Goblin Gaoler
                17199599, -- Goblin Gambler
                17199600 -- Goblin Gambler
            },
            [5] =
            {
                17199593, -- Goblin Swordmaker
                17199594, -- Goblin Swordmaker
                17199595, -- Goblin Leecher
                17199596, -- Goblin Leecher
                17199597, -- Goblin Gaoler
                17199598, -- Goblin Gaoler
                17199599, -- Goblin Gambler
                17199600 -- Goblin Gambler
            },
            [6] =
            {
                17199593, -- Goblin Swordmaker
                17199594, -- Goblin Swordmaker
                17199595, -- Goblin Leecher
                17199596, -- Goblin Leecher
                17199597, -- Goblin Gaoler
                17199598, -- Goblin Gaoler
                17199599, -- Goblin Gambler
                17199600 -- Goblin Gambler
            },
        },
    },
    [xi.zone.JUGNER_FOREST] =
    {
        itemReq = 1532, -- Silver Engraving
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17203668,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        {
        -- Wave + Number of Parties
            [1] =
            {
                17203668,
                17203669
            },
            [2] =
            {
                17203668,
                17203669,
                17203670,
                17203671
            },
            [3] =
            {
                17203668,
                17203669,
                17203670,
                17203671,
                17203672,
                17203673
            },
            [4] =
            {
                17203668,
                17203669,
                17203670,
                17203671,
                17203672,
                17203673,
                17203674,
                17203675
            },
            [5] =
            {
                17203668,
                17203669,
                17203670,
                17203671,
                17203672,
                17203673,
                17203674,
                17203675
            },
            [6] =
            {
                17203668,
                17203669,
                17203670,
                17203671,
                17203672,
                17203673,
                17203674,
                17203675
            },
        },
    },
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        itemReq = 1533, -- Silver Engraving
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17224152,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17224152,
                17224153
            },
            [2] =
            {
                17224152,
                17224153,
                17224154,
                17224155
            },
            [3] =
            {
                17224152,
                17224153,
                17224154,
                17224155,
                17224156,
                17224157
            },
            [4] =
            {
                17224152,
                17224153,
                17224154,
                17224155,
                17224156,
                17224157,
                17224158,
                17224159
            },
            [5] =
            {
                17224152,
                17224153,
                17224154,
                17224155,
                17224156,
                17224157,
                17224158,
                17224159
            },
            [6] =
            {
                17224152,
                17224153,
                17224154,
                17224155,
                17224156,
                17224157,
                17224158,
                17224159
            },
        },
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        itemReq = 1534, -- Mithra Fang Sack
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17261026,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17261026,
                17261027
            },
            [2] =
            {
                17261026,
                17261027,
                17261028,
                17261029
            },
            [3] =
            {
                17261026,
                17261027,
                17261028,
                17261029,
                17261030,
                17261031
            },
            [4] =
            {
                17261026,
                17261027,
                17261028,
                17261029,
                17261030,
                17261031,
                17261032,
                17261033
            },
            [5] =
            {
                17261026,
                17261027,
                17261028,
                17261029,
                17261030,
                17261031,
                17261032,
                17261033
            },
            [6] =
            {
                17261026,
                17261027,
                17261028,
                17261029,
                17261030,
                17261031,
                17261032,
                17261033
            },
        },
    },
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        itemReq = 1535, -- Thirteen-Knot Quipus
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17265103,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17265103,
                17265104
            },
            [2] =
            {
                17265103,
                17265104,
                17265105,
                17265106
            },
            [3] =
            {
                17265103,
                17265104,
                17265105,
                17265106,
                17265107,
                17265108
            },
            [4] =
            {
                17265103,
                17265104,
                17265105,
                17265106,
                17265107,
                17265108,
                17265109,
                17265110
            },
            [5] =
            {
                17265103,
                17265104,
                17265105,
                17265106,
                17265107,
                17265108,
                17265109,
                17265110
            },
            [6] =
            {
                17265103,
                17265104,
                17265105,
                17265106,
                17265107,
                17265108,
                17265109,
                17265110
            },
        },
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        itemReq = 1538, -- Ram Leather Missive
        levelCap = 30,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17293631,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17293631,
                17293632
            },
            [2] =
            {
                17293631,
                17293632,
                17293633,
                17293634
            },
            [3] =
            {
                17293631,
                17293632,
                17293633,
                17293634,
                17293635,
                17293636
            },
            [4] =
            {
                17293631,
                17293632,
                17293633,
                17293634,
                17293635,
                17293636,
                17293637,
                17293638
            },
            [5] =
            {
                17293631,
                17293632,
                17293633,
                17293634,
                17293635,
                17293636,
                17293637,
                17293638
            },
            [6] =
            {
                17293631,
                17293632,
                17293633,
                17293634,
                17293635,
                17293636,
                17293637,
                17293638
            },
        },
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        itemReq = 1536, -- Tiger Leather Missive
        levelCap = 40,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17232138,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17232138,
                17232139
            },
            [2] =
            {
                17232138,
                17232139,
                17232140,
                17232141
            },
            [3] =
            {
                17232138,
                17232139,
                17232140,
                17232141,
                17232142,
                17232143
            },
            [4] =
            {
                17232138,
                17232139,
                17232140,
                17232141,
                17232142,
                17232143,
                17232144,
                17232145
            },
            [5] =
            {
                17232138,
                17232139,
                17232140,
                17232141,
                17232142,
                17232143,
                17232144,
                17232145
            },
            [6] =
            {
                17232138,
                17232139,
                17232140,
                17232141,
                17232142,
                17232143,
                17232144,
                17232145
            },
        },
    },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        itemReq = 1539, -- Hound Fang Sack
        levelCap = 40,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17273296,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17273296,
                17273297
            },
            [2] =
            {
                17273296,
                17273297,
                17273298,
                17273299
            },
            [3] =
            {
                17273296,
                17273297,
                17273298,
                17273299,
                17273300,
                17273301
            },
            [4] =
            {
                17273296,
                17273297,
                17273298,
                17273299,
                17273300,
                17273301,
                17273302,
                17273303
            },
            [5] =
            {
                17273296,
                17273297,
                17273298,
                17273299,
                17273300,
                17273301,
                17273302,
                17273303
            },
            [6] =
            {
                17273296,
                17273297,
                17273298,
                17273299,
                17273300,
                17273301,
                17273302,
                17273303
            },
        },
    },
    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        itemReq = 1542, -- Sheep Leather Missive
        levelCap = 40,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17281482,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17281482,
                17281483
            },
            [2] =
            {
                17281482,
                17281483,
                17281484,
                17281485
            },
            [3] =
            {
                17281482,
                17281483,
                17281484,
                17281485,
                17281486,
                17281487
            },
            [4] =
            {
                17281482,
                17281483,
                17281484,
                17281485,
                17281486,
                17281487,
                17281488,
                17281489
            },
            [5] =
            {
                17281482,
                17281483,
                17281484,
                17281485,
                17281486,
                17281487,
                17281488,
                17281489
            },
            [6] =
            {
                17281482,
                17281483,
                17281484,
                17281485,
                17281486,
                17281487,
                17281488,
                17281489
            },
        },
    },
    [xi.zone.XARCABARD] =
    {
        itemReq = 1537, -- Behemoth Leather Missive
        levelCap = 50,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17236220,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17236220,
                17236221
            },
            [2] =
            {
                17236220,
                17236221,
                17236222,
                17236223
            },
            [3] =
            {
                17236220,
                17236221,
                17236222,
                17236223,
                17236224,
                17236225
            },
            [4] =
            {
                17236220,
                17236221,
                17236222,
                17236223,
                17236224,
                17236225,
                17236226,
                17236227
            },
            [5] =
            {
                17236220,
                17236221,
                17236222,
                17236223,
                17236224,
                17236225,
                17236226,
                17236227
            },
            [6] =
            {
                17236220,
                17236221,
                17236222,
                17236223,
                17236224,
                17236225,
                17236226,
                17236227
            },
        },
    },
    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        itemReq = 1540, -- Dhalmel Leather Missive
        levelCap = 50,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17244540,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17244540,
                17244541
            },
            [2] =
            {
                17244540,
                17244541,
                17244542,
                17244543
            },
            [3] =
            {
                17244540,
                17244541,
                17244542,
                17244543,
                17244544,
                17244545
            },
            [4] =
            {
                17244540,
                17244541,
                17244542,
                17244543,
                17244544,
                17244545,
                17244546,
                17244547
            },
            [5] =
            {
                17244540,
                17244541,
                17244542,
                17244543,
                17244544,
                17244545,
                17244546,
                17244547
            },
            [6] =
            {
                17244540,
                17244541,
                17244542,
                17244543,
                17244544,
                17244545,
                17244546,
                17244547
            },
        },
    },
    [xi.zone.YHOATOR_JUNGLE] =
    {
        itemReq = 1543, -- Coeurl Leather Missive
        levelCap = 50,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17285562,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17285562,
                17285563
            },
            [2] =
            {
                17285562,
                17285563,
                17285564,
                17285565
            },
            [3] =
            {
                17285562,
                17285563,
                17285564,
                17285565,
                17285566,
                17285567
            },
            [4] =
            {
                17285562,
                17285563,
                17285564,
                17285565,
                17285566,
                17285567,
                17285568,
                17285569
            },
            [5] =
            {
                17285562,
                17285563,
                17285564,
                17285565,
                17285566,
                17285567,
                17285568,
                17285569
            },
            [6] =
            {
                17285562,
                17285563,
                17285564,
                17285565,
                17285566,
                17285567,
                17285568,
                17285569
            },
        },
    },
    [xi.zone.CAPE_TERIGGAN] =
    {
        itemReq = 1541, -- Bunny Fang Sack
        levelCap = 75,
        npcs =
        {
        -- empty filled with dynamic entries
        },
        mobs = 17240425,
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
        name = "NPC", -- needs correct names
        look = 42, -- needs correct looks
        waveSize =
        {
        -- Wave + Number of Parties
            [1] =
            {
                17240425,
                17240426
            },
            [2] =
            {
                17240425,
                17240426,
                17240427,
                17240428
            },
            [3] =
            {
                17240425,
                17240426,
                17240427,
                17240428,
                17240429,
                17240430
            },
            [4] =
            {
                17240425,
                17240426,
                17240427,
                17240428,
                17240429,
                17240430,
                17240431,
                17240432
            },
            [5] =
            {
                17240425,
                17240426,
                17240427,
                17240428,
                17240429,
                17240430,
                17240431,
                17240432
            },
            [6] =
            {
                17240425,
                17240426,
                17240427,
                17240428,
                17240429,
                17240430,
                17240431,
                17240432
            },
        },
    },
}
