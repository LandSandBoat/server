-----------------------------------
-- Garrison Data
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}

-- Name is Determined by Nation and LevelCap
-- Names in order of xi.nation values (sandoria, bastok, windurst)
xi.garrison.allyNames =
{
    [20] = { "Patrician", "Recruit", "Candidate" },
    [30] = { "Trader", "Mariner", "Scholar" },
    -- TODO: Capture Windy npc. Shouldn't be TempleKnight.
    [40] = { "TempleKnight", "GoldMusketeer", "TempleKnight" },
    [50] = { "RoyalGuard", "GoldMusketeer", "Patriarch" },
    [75] = { "MilitaryAttache", "MilitaryAttache", "MilitaryAttache" },
}

-- Group Ids are different per cap due to min / max level requirements
-- They all use the same pool at the moment, but we could also change families
-- based on cap, which would change base stats
xi.garrison.allyGroupIds =
{
    [20] = 1,
    [30] = 2,
    [40] = 3,
    [50] = 4,
    [75] = 5,
}

-- This is used to replace blank weapons in ally looks.
-- TODO: Use proper npc looks for all models or at least find the right range
-- so we can purely generate these
xi.garrison.allyArsenal =
{
    "08",
    "83",
    "B8",
    "73",
    "62",
    "01",
    "19",
    "6B",
    "B5",
    "75",
    "6F",
    "BB",
    "3C",
    "56",
    "4E",
    "19",
    "5C",
    "61",
    "E6"
}

-- Look is Determined by Nation and LevelCap (Appears to be 4 for each outpost need more data though)
xi.garrison.allyLooks =
{
    -- Level 20 garrison looks
    -- The looks that have not been obtained from captures are commented
    -- with the npc that they are taken from
    -- Obtain new looks by finding a good looking npc and running the query:
    -- Select name, npcid, CONCAT("0x", HEX(look)) FROM npc_list WHERE name LIKE "Shato%"
    -- TODO: Get proper captures and remove any npcs that have a name associated to them
    -- https://github.com/AirSkyBoat/AirSkyBoat/issues/1636
    [20] =
    {
        {
            "0x01000C030010262000303A403A5008611B700000",
            "0x01000A040010262019303A40195008611C700000",
            -- Fouagine
            "0x010004041C106E20833080406850836083700000",
        },
        {
            -- Pavel
            "0x0100040100100520163005400550B86000700000",
            -- Caliburn
            "0x0100000100100620063006400650006000700000",
            -- Fariel
            "0x0100030100100520163005400550B86000700000",
        },
        {
            -- Puo_Rhen
            "0x0000E90000000000000000000000000000000000",
            -- Sheia_Pohrichamaha
            "0x0000EA0000000000000000000000000000000000",
            -- Mokyokyo
            "0x0100180618101820183018401850006000700000",
        },
    },
    --level 30 garrison looks
    [30] =
    {
        {
            "0x010006030010762076303A400650736000700000",
            "0x01000F0300101520153015401550006000700000",
            "0x010009040010762076303A400650736000700000",
            "0x01000E0400101520003015401550006000700000"
        },
        {
            -- Ferocious_Artisan
            "0x0100010814102720173015401550006000700000",
            -- Suzel
            "0x01000E020F100720003003400750006000700000",
            -- Guda (16883811)
            "0x010003011C100E20083068401F50626000700000"
        },
        {
            -- Shatoto
            "0x0100040600100120013001400150006000700000",
            -- Harara_WW
            "0x0100030601100120013001400150016001700000",
            -- AMAN_Reclaimer (17764605)
            "0x0100040777106720683066406850006000700000",
            -- Naih_Arihmepp
            "0x0100020700100220023002400250006000700000",
        },
    },
    --level 40 garrison looks
    [40] =
    {
        {   -- Ironclad_Gorilla
            "0x010009081C108A2008308A40085019611D700000",
            "0x01000E04191019201930194019506B601C700000",
            "0x01000903191019201930194019506B601C700000"
        },
        {
            "0x0100020260102420603060406050B56000700000",
            "0x010008083D1024203D3010401050756075700000",
            "0x01000008371024203730374037506F6018700000",
            "0x0100040105102420053005400550BB6000700000"
        },
        {
            -- Voidwatch officer (17752374)
            "0x01000C05141019200C3002400250006000700000",
            -- Taraihi-Perunhi
            "0x0100000500100220023002400250006000700000",
            -- Wetata
            "0x01000306461118205230B8408550006000700000"
        },
    },
    --level 50 garrison looks
    [50] =
    {
        {
            -- Ferchinne
            "0x01000A041C103C206C306C406C503C6000700000",
            -- Parelbriaux
            "0x01000D0323108A20803088408050056100700000",
            -- Petva
            "0x01000101141019200C3002400250056000700000",
        },
        {
            -- Masis (16883819)
            "0x01000C011C1073208330804068504E6000700000",
            -- Ironclad_Gorilla
            "0x010009081C108A2008308A40085019611D700000",
            -- Iron Eater (17748016)
            "0x01000D0801101620053019400C505C6000700000",
        },
        {
            "0x0100020600106320633063406350056122700000",
            "0x010004067C102D20193019401950506100700000",
            "0x0100080669106B206B306B406B50FE6000700000"
        },
    },
    --level 75 garrison looks
    --TODO: Era Module
    [75] =
    {
        {
            -- Morangeart
            "0x010009031A10812088303C408850CF6000700000",
            -- Quelveuiat
            "0x01000E0388108820883088408850186100700000",
            -- Jaucribaix
            "0x01000F0304102220093009400950006000700000",
        },
        {
            "0x010002071C1070201C301C401C50C46000700000",
            -- Merol
            "0x010008021C106A20733073406850006000700000",
        },
        {
            -- Fhelm_Jobeizat (17764603)
            "0x010003071310222064306E406450006000700000",
            -- Shivivi
            "0x0100080604102320093009400C50006000700000",
        },
    },
}

-- Loot is determined by LevelCap
xi.garrison.loot =
{
    --level 20 garrison loot
    [20] =
    {
        { itemid = xi.items.DRAGON_CHRONICLES, droprate = 1000 },
        { itemid = xi.items.GARRISON_TUNICA, droprate = 350 },
        { itemid = xi.items.GARRISON_BOOTS, droprate = 350 },
        { itemid = xi.items.GARRISON_HOSE, droprate = 350 },
        { itemid = xi.items.GARRISON_GLOVES, droprate = 350 },
        { itemid = xi.items.GARRISON_SALLET, droprate = 350 },
    },
    --level 30 garrison loot
    [30] =
    {
        { itemid = xi.items.DRAGON_CHRONICLES, droprate = 1000 },
        { itemid = xi.items.MILITARY_GUN, droprate = 350 },
        { itemid = xi.items.MILITARY_POLE, droprate = 350 },
        { itemid = xi.items.MILITARY_HARP, droprate = 350 },
        { itemid = xi.items.MILITARY_PICK, droprate = 350 },
        { itemid = xi.items.MILITARY_SPEAR, droprate = 350 },
        { itemid = xi.items.MILITARY_AXE, droprate = 350 },
    },
    --level 40 garrison loot
    [40] =
    {
        { itemid = xi.items.DRAGON_CHRONICLES, droprate = 1000 },
        { itemid = xi.items.VARIABLE_MANTLE, droprate = 350 },
        { itemid = xi.items.VARIABLE_CAPE, droprate = 350 },
        { itemid = xi.items.PROTEAN_RING, droprate = 350 },
        { itemid = xi.items.VARIABLE_RING, droprate = 350 },
        { itemid = xi.items.MECURIAL_EARRING, droprate = 350 },
    },
    --level 50 garrison loot
    [50] =
    {
        { itemid = xi.items.DRAGON_CHRONICLES, droprate = 1000 },
        { itemid = xi.items.UNDEAD_EARRING, droprate = 350 },
        { itemid = xi.items.ARCANA_EARRING, droprate = 350 },
        { itemid = xi.items.VERMIN_EARRING, droprate = 350 },
        { itemid = xi.items.BIRD_EARRING, droprate = 350 },
        { itemid = xi.items.AMORPH_EARRING, droprate = 350 },
        { itemid = xi.items.LIZARD_EARRING, droprate = 350 },
        { itemid = xi.items.AQUAN_EARRING, droprate = 350 },
        { itemid = xi.items.PLANTOID_EARRING, droprate = 350 },
        { itemid = xi.items.BEAST_EARRING, droprate = 350 },
        { itemid = xi.items.DEMON_EARRING, droprate = 350 },
        { itemid = xi.items.DRAGON_EARRING, droprate = 350 },
        { itemid = xi.items.REFRESH_EARRING, droprate = 350 },
        { itemid = xi.items.ACCURATE_EARRING, droprate = 350 },
    },
    --level 75 garrison loot
    --TODO: 75 era module
    [75] =
    {
        { itemid = xi.items.MIRATETES_MEMOIRS, droprate = 1000 },
        { itemid = xi.items.MIGHTY_BOW, droprate = 350 },
        { itemid = xi.items.MIGHTY_CUDGEL, droprate = 350 },
        { itemid = xi.items.MIGHTY_POLE, droprate = 350 },
        { itemid = xi.items.MIGHTY_TALWAR, droprate = 350 },
        { itemid = xi.items.RAI_KUNIMITSU, droprate = 350 },
        { itemid = xi.items.NUKEMARU, droprate = 350 },
        { itemid = xi.items.MIGHTY_PICK, droprate = 350 },
        { itemid = xi.items.MIGHTY_KNIFE, droprate = 350 },
        { itemid = xi.items.MIGHTY_ZAGHNAL, droprate = 350 },
        { itemid = xi.items.MIGHTY_LANCE, droprate = 350 },
        { itemid = xi.items.MIGHTY_AXE, droprate = 350 },
        { itemid = xi.items.MIGHTY_PATAS, droprate = 350 },
        { itemid = xi.items.MIGHTY_SWORD, droprate = 350 },
    },
}

xi.garrison.waves =
{
    -- Each wave consists of different 'mini waves' or spawn groups,
    -- which are separated from each other by a certain interval of time.
    --
    -- Flow:
    -- * After all groups in a wave are killed, the wave ends.
    -- * After delayBetweenGroups, the next wave begins.
    -- * When all groups in the last wave have been killed, boss spawns after delayBetweenGroups.
    --
    -- Constraints: A wave can only spawn 8 mobs at a time at most. This is due to the assumption
    -- That the boss is always 8 IDs after the mobs spawning in each wave.
    spawnSchedule =
    {
        -- 1 Party
        [1] =
        {
            -- Wave 1
            -- 2 Mobs at once
            [1] =
            {
                2
            },
            -- Wave 2
            -- 2 Mobs every `delayBetweenGroups`
            -- 4 total
            [2] =
            {
                2,
                2
            },
            -- Wave 3
            -- 2 Mobs every `delayBetweenGroups`
            -- 6 total
            [3] =
            {
                2,
                2,
                2
            },
            -- Wave 4
            -- 2 Mobs every `delayBetweenGroups`
            -- 8 total
            -- Boss spawns after all 8 are killed
            [4] =
            {
                2,
                2,
                2,
                2
            }
        },
        -- 2 Parties
        [2] =
        {
            -- Wave 1
            -- 4 Mobs at once
            [1] =
            {
                4
            },
            -- Wave 2
            -- 4 Mobs
            -- 2 Mobs after `delayBetweenGroups`
            [2] =
            {
                4,
                2
            },
            -- Wave 3
            -- 4 Mobs
            -- 2 Mobs after `delayBetweenGroups`
            -- 2 Mobs after 2 * `delayBetweenGroups`
            [3] =
            {
                4,
                2,
                2
            },
            -- Wave 4
            -- 4 Mobs
            -- 2 Mobs after `delayBetweenGroups`
            -- 2 Mobs after 2 * `delayBetweenGroups`
            -- Boss after all 8 mobs are killed
            [4] =
            {
                4,
                2,
                2,
            }
        },
        -- 3 Parties
        -- Only 3 waves with 3 parties.
        -- I don't understand the thinking behind this, but this matches the two videos
        -- I found showing garrison gameplay with 3 parties.
        [3] =
        {
            -- Wave 1
            -- 4 Mobs at once
            [1] =
            {
                4,
                2
            },
            -- Wave 2
            -- 6 Mobs
            -- 2 Mobs after `delayBetweenGroups`
            [2] =
            {
                6,
                2
            },
            -- Wave 3
            -- 4 Mobs
            -- 2 Mobs after `delayBetweenGroups`
            -- 2 Mobs after 2 * `delayBetweenGroups`
            -- Boss after all 8 mobs are killed
            [3] =
            {
                4,
                2,
                2
            },
        },
    },
    -- How many seconds before each group spawns
    delayBetweenGroups = 15,
}

--Zone Data
xi.garrison.zoneData =
{
    [xi.zone.WEST_RONFAURE] =
    {
        itemReq = xi.items.RED_CRYPTEX,
        textRegion = 0,
        levelCap = 20,
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
    },
    [xi.zone.NORTH_GUSTABERG] =
    {
        itemReq = xi.items.DARKSTEEL_ENGRAVING,
        textRegion = 1,
        levelCap = 20,
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
    },
    [xi.zone.WEST_SARUTABARUTA] =
    {
        itemReq = xi.items.SEVEN_KNOT_QUIPU,
        textRegion = 2,
        levelCap = 20,
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
    },
    [xi.zone.VALKURM_DUNES] =
    {
        itemReq = xi.items.GALKA_FANG_SACK,
        textRegion = 3,
        levelCap = 30,
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
    },
    [xi.zone.JUGNER_FOREST] =
    {
        itemReq = xi.items.JADE_CRYPTEX,
        textRegion = 4,
        levelCap = 30,
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
    },
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        itemReq = xi.items.SILVER_ENGRAVING,
        textRegion = 5,
        levelCap = 30,
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
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        itemReq = xi.items.MITHRA_FANG_SACK,
        textRegion = 6,
        levelCap = 30,
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
    },
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        itemReq = xi.items.THIRTEEN_KNOT_QUIPU,
        textRegion = 7,
        levelCap = 30,
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
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        itemReq = xi.items.RAM_LEATHER_MISSIVE,
        textRegion = 10,
        levelCap = 30,
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
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        itemReq = xi.items.TIGER_LEATHER_MISSIVE,
        textRegion = 8,
        levelCap = 40,
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
    },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        itemReq = xi.items.HOUND_FANG_SACK,
        textRegion = 11,
        levelCap = 40,
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
    },
    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        itemReq = xi.items.SHEEP_LEATHER_MISSIVE,
        textRegion = 14,
        levelCap = 40,
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
    },
    [xi.zone.XARCABARD] =
    {
        itemReq = xi.items.BEHEMOTH_LEATHER_MISSIVE,
        textRegion = 9,
        levelCap = 50,
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
    },
    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        itemReq = xi.items.DHALMEL_LEATHER_MISSIVE,
        textRegion = 12,
        levelCap = 50,
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
    },
    [xi.zone.YHOATOR_JUNGLE] =
    {
        itemReq = xi.items.COEURL_LEATHER_MISSIVE,
        textRegion = 15,
        levelCap = 50,
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
    },
    [xi.zone.CAPE_TERIGGAN] =
    {
        itemReq = xi.items.BUNNY_FANG_SACK,
        textRegion = 13,
        levelCap = 75, -- 75 Mobs/NPCs Is uncapped
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
    },
}
