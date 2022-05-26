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
        {itemId = 13818, dropRate = 200}, -- Garrison Tunica
        {itemId = 14206, dropRate = 200}, -- Garrison Boots
        {itemId = 14314, dropRate = 200}, -- Garrison Hose
        {itemId = 14841, dropRate = 200}, -- Garrison Gloves
        {itemId = 15147, dropRate = 200}, -- Garrison Sallet
    },
    --level 30 garrison loot
    [30] =
    {
        {itemId = 4198, dropRate = 1000}, -- Dragon Chronicles
        {itemId = 17272, dropRate = 200}, -- Military Gun
        {itemId = 17580, dropRate = 200}, -- Military Pole
        {itemId = 17839, dropRate = 200}, -- Military Harp
        {itemId = 17940, dropRate = 200}, -- Military Pick
        {itemId = 18090, dropRate = 200}, -- Military Spear
        {itemId = 18212, dropRate = 200}, -- Military Axe
    },
    --level 40 garrison loot
    [40] =
    {
        {itemId = 4198, dropRate = 1000}, -- Dragon Chronicles
        {itemId = 13680, dropRate = 200}, -- Variable Mantle
        {itemId = 13681, dropRate = 200}, -- Variable Cape
        {itemId = 14652, dropRate = 200}, -- Protean Ring
        {itemId = 14653, dropRate = 200}, -- Variable Ring
        {itemId = 14757, dropRate = 200}, -- Mecurial Earring
    },
    --level 50 garrison loot
    [50] =
    {
        {itemId = 4198, dropRate = 1000}, -- Dragon Chronicles
        {itemId = 14744, dropRate = 200}, -- Undead Earring
        {itemId = 14745, dropRate = 200}, -- Arcana Earring
        {itemId = 14746, dropRate = 200}, -- Vermin Earring
        {itemId = 14747, dropRate = 200}, -- Bird Earring
        {itemId = 14748, dropRate = 200}, -- Amorph Earring
        {itemId = 14749, dropRate = 200}, -- Lizard Earring
        {itemId = 14750, dropRate = 200}, -- Aquan Earring
        {itemId = 14751, dropRate = 200}, -- Plantoid Earring
        {itemId = 14752, dropRate = 200}, -- Beast Earring
        {itemId = 14753, dropRate = 200}, -- Demon Earring
        {itemId = 14754, dropRate = 200}, -- Dragon Earring
        {itemId = 14755, dropRate = 200}, -- Refresh Earring
        {itemId = 14756, dropRate = 200}, -- Accurate Earring
    },
    --level 75 garrison loot
    [75] =
    {
        {itemId = 4247, dropRate = 1000}, -- Miratete's Memoirs
        {itemId = 17204, dropRate = 200}, -- Mighty Bow
        {itemId = 17465, dropRate = 200}, -- Mighty Cudgel
        {itemId = 17581, dropRate = 200}, -- Mighty Pole
        {itemId = 17697, dropRate = 200}, -- Mighty Talwar
        {itemId = 17791, dropRate = 200}, -- Rai Kunimitsu
        {itemId = 17824, dropRate = 200}, -- Nukemaru
        {itemId = 17941, dropRate = 200}, -- Mighty Pick
        {itemId = 18000, dropRate = 200}, -- Mighty Knife
        {itemId = 18049, dropRate = 200}, -- Mighty Zaghnal
        {itemId = 18091, dropRate = 200}, -- Mighty Lance
        {itemId = 18213, dropRate = 200}, -- Mighty Axe
        {itemId = 18352, dropRate = 200}, -- Mighty Patas
        {itemId = 18374, dropRate = 200}, -- Mighty Sword
    },

}
--Zone Data
xi.garrison.data =
{
    [xi.zone.WEST_RONFAURE] =
    {
        itemReq = 1528, -- Red Cryptex
        levelCap = 20,
        npcs = {
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
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
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
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17211849,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)waveSize = {
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.WEST_SARUTABARUTA] =
    {
        itemReq = 1530, -- Seven-Knot Quipu
        levelCap = 20,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17248598,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)waveSize = {
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.VALKURM_DUNES] = 
    {
        itemReq = 1531, -- Galka Fang Sack
        levelCap = 30,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17199593,
        xPos = 151,
        yPos = -8,
        zPos = 96,
        xChange = -2, --isnt right but works?
        zChange = -2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 32,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
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
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17203668,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        itemReq = 1533, -- Silver Engraving
        levelCap = 30,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17224152,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        itemReq = 1534, -- Mithra Fang Sack
        levelCap = 30,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17261026,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        itemReq = 1535, -- Thirteen-Knot Quipus
        levelCap = 30,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17265103,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        itemReq = 1538, -- Ram Leather Missive
        levelCap = 30,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17293631,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        itemReq = 1536, -- Tiger Leather Missive
        levelCap = 40,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17232138,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        itemReq = 1539, -- Hound Fang Sack
        levelCap = 40,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17273296,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        itemReq = 1542, -- Sheep Leather Missive
        levelCap = 40,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17281482,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.XARCABARD] =
    {
        itemReq = 1537, -- Behemoth Leather Missive
        levelCap = 50,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17236220,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        itemReq = 1540, -- Dhalmel Leather Missive
        levelCap = 50,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17244540,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.YHOATOR_JUNGLE] =
    {
        itemReq = 1543, -- Coeurl Leather Missive
        levelCap = 50,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17285562,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
    [xi.zone.CAPE_TERIGGAN] =
    {
        itemReq = 1541, -- Bunny Fang Sack
        levelCap = 75,
        npcs = {
        -- empty filled with dynamic entries
        },
        mobs = 17240425,
        xPos = -0,
        yPos = -0,
        zPos = -0,
        xChange = 0,
        zChange = 2,
        xSecondLine = 2,
        zSecondLine = 0,
        xThirdLine = 4,
        zThirdLine = 0,
        rot = 0,
        name = "676e7063C", -- gnpc text to hex (rename with proper names later)
        waveSize = {
        -- Wave + Number of Parties
            [1] =
            {
            },
            [2] =
            {
            },
            [3] =
            {
            },
            [4] =
            {
            },
            [5] =
            {
            },
            [6] =
            {
            },
        },
    },
}
