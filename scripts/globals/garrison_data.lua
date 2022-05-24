-----------------------------------
-- Garrison Data
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
xi = xi or {}
xi.garrison = xi.garrison or {}

-- Alliance/Party Size determines how many Mobs spawn per wave.
xi.garrison.waveSize =
{
    -- One Party player count > 1
    [1] =
    {
        [1] =
            {
            size = 2
            },
        [2] =
            {
            size = 4
            },
        [3] =
            {
            size = 6
            },
        [4] =
            {
            size = 6
            },
    },
    -- Two Parties player count > 6
    [2] =
    {
        [1] =
            {
            size = 4
            },
        [2] =
            {
            size = 6
            },
        [3] =
            {
            size = 8
            },
        [4] =
            {
            size = 8
            },
    },
    -- Three Parties player count > 12
    [3] =
    {
        [1] =
            {
            size = 6
            },
        [2] =
            {
            size = 8
            },
        [3] =
            {
            size = 8 -- is supposed to be 10 Too Many Mobs need to add mini wave logic
            },
        [4] =
            {
            size = 8 -- is supposed to be 10 Too Many Mobs need to add mini wave logic
            },
    }

}
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


xi.garrison.data =
{
    [xi.zone.WEST_RONFAURE] =
    {
        itemReq = 1528, -- Red Cryptex
        levelCap = 20,
        npcs = 17188899,
        mobs = 17187274 -- all mobs have spawn info
    },
    [xi.zone.NORTH_GUSTABERG] =
    {
        itemReq = 1529, -- Darksteel Engraving
        levelCap = 20,
        npcs = 17201183, -- need npc
        mobs = 17211849
                --17211853, --'Brass_Quadav','Brass Quadav',37,0,0,0,0);
                --17211854, --'Brass_Quadav','Brass Quadav',37,0,0,0,0);
                --17211855, --'Sapphirine_Quadav','Sapphirine Quadav',38,0,0,0,0);
                --17211856, --'Sapphirine_Quadav','Sapphirine Quadav',38,0,0,0,0);
                --17211857, --'Lead_Quadav','Lead Quadav',39,0,0,0,0);
    },
    [xi.zone.WEST_SARUTABARUTA] =
    {
        itemReq = 1530, -- Seven-Knot Quipu
        levelCap = 20,
        npcs = 17201183, -- need npc
        mobs = 17248598 -- all mobs have spawn info
    },
    [xi.zone.VALKURM_DUNES] =
    {
        itemReq = 1531, -- Galka Fang Sack
        levelCap = 30,
        npcs = 17201183,
        mobs = 17199593 -- all mobs have spawn info
    },
    [xi.zone.JUGNER_FOREST] =
    {
        itemReq = 1532, -- Silver Engraving
        levelCap = 30,
        npcs = 17201183, -- need npc
        mobs = 17203668
                --17203668, --'Orcish_Fighter','Orcish Fighter',65,0,0,0,0);
                --17203669, --'Orcish_Fighter','Orcish Fighter',65,0,0,0,0);
                --17203670, --'Orcish_Chasseur','Orcish Chasseur',66,0,0,0,0);
                --17203671, --'Orcish_Chasseur','Orcish Chasseur',66,0,0,0,0);
                --17203672, --'Orcish_Serjeant','Orcish Serjeant',67,0,0,0,0);
                --17203673, --'Orcish_Serjeant','Orcish Serjeant',67,0,0,0,0);
                --17203674, --'Orcish_Cursemaker','Orcish Cursemaker',68,0,0,0,0);
                --17203675, --'Orcish_Cursemaker','Orcish Cursemaker',68,0,0,0,0);
                --17203676, --'Orcish_Colonel','Orcish Colonel',69,0,0,0,0);
    },
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        itemReq = 1533, -- Silver Engraving
        levelCap = 30,
        npcs = 17201183, -- need npc
        mobs = 17224152
                --17224152, --'Old_Quadav','Old Quadav',58,0,0,0,0);
                --17224153, --'Old_Quadav','Old Quadav',58,0,0,0,0);
                --17224154, --'Heliodor_Quadav','Heliodor Quadav',59,0,0,0,0);
                --17224155, --'Heliodor_Quadav','Heliodor Quadav',59,0,0,0,0);
                --17224156, --'Brass_Quadav','Brass Quadav',60,0,0,0,0);
                --17224157, --'Brass_Quadav','Brass Quadav',60,0,0,0,0);
                --17224158, --'Sapphirine_Quadav','Sapphirine Quadav',61,0,0,0,0);
                --17224159, --'Sapphirine_Quadav','Sapphirine Quadav',61,0,0,0,0);
                --17224160, --'Cobalt_Quadav','Cobalt Quadav',62,0,0,0,0);
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        itemReq = 1534, -- Mithra Fang Sack
        levelCap = 30,
        npcs = 17201183, -- need npc
        mobs = 17261026
                --17261026, --'Goblin_Swordmaker','Goblin Swordmaker',46,0,0,0,0);
                --17261027, --'Goblin_Swordmaker','Goblin Swordmaker',46,0,0,0,0);
                --17261028, --'Goblin_Thespian','Goblin Thespian',47,0,0,0,0);
                --17261029, --'Goblin_Thespian','Goblin Thespian',47,0,0,0,0);
                --17261030, --'Goblin_Furrier','Goblin Furrier',48,0,0,0,0);
                --17261031, --'Goblin_Furrier','Goblin Furrier',48,0,0,0,0);
                --17261032, --'Goblin_Shaman','Goblin Shaman',49,0,0,0,0);
                --17261033, --'Goblin_Shaman','Goblin Shaman',49,0,0,0,0);
                --17261034, --'Goblin_Guide','Goblin Guide',50,0,0,0,0);
    },
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        itemReq = 1535, -- Thirteen-Knot Quipus
        levelCap = 30,
        npcs = 17201183, -- need npc
        mobs = 17265103
                --17265103, --'Yagudo_Votary','Yagudo Votary',57,0,0,0,0);
                --17265104, --'Yagudo_Votary','Yagudo Votary',57,0,0,0,0);
                --17265105, --'Yagudo_Theologist','Yagudo Theologist',58,0,0,0,0);
                --17265106, --'Yagudo_Theologist','Yagudo Theologist',58,0,0,0,0);
                --17265107, --'Yagudo_Follower','Yagudo Follower',59,0,0,0,0);
                --17265108, --'Yagudo_Follower','Yagudo Follower',59,0,0,0,0);
                --17265109, --'Yagudo_Priest','Yagudo Priest',60,0,0,0,0);
                --17265110, --'Yagudo_Priest','Yagudo Priest',60,0,0,0,0);
                --17265111, --'Yagudo_Missionary','Yagudo Missionary',61,0,0,0,0);
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        itemReq = 1538, -- Ram Leather Missive
        levelCap = 30,
        npcs = 17201183, -- need npc
        mobs = 17293631
                --17293631, --'Giant_Ranger','Giant Ranger',44,0,0,0,0);
                --17293632, --'Giant_Ranger','Giant Ranger',44,0,0,0,0);
                --17293633, --'Giant_Hunter','Giant Hunter',45,0,0,0,0);
                --17293634, --'Giant_Hunter','Giant Hunter',45,0,0,0,0);
                --17293635, --'Giant_Ranger','Giant Ranger',44,0,0,0,0);
                --17293636, --'Giant_Ranger','Giant Ranger',44,0,0,0,0);
                --17293637, --'Giant_Hunter','Giant Hunter',45,0,0,0,0);
                --17293638, --'Giant_Hunter','Giant Hunter',45,0,0,0,0);
                --17293639, --'Hunting_Chief','Hunting Chief',46,0,0,0,0);
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        itemReq = 1536, -- Tiger Leather Missive
        levelCap = 40,
        npcs = 17201183, -- need npc
        mobs = 17232138
                --17232138, --'Gigas_Hillrazer','Gigas Hillrazer',48,0,0,0,0);
                --17232139, --'Gigas_Hillrazer','Gigas Hillrazer',48,0,0,0,0);
                --17232140, --'Gigas_Clearcutter','Gigas Clearcutter',49,0,0,0,0);
                --17232141, --'Gigas_Clearcutter','Gigas Clearcutter',49,0,0,0,0);
                --17232142, --'Gigas_Hillrazer','Gigas Hillrazer',48,0,0,0,0);
                --17232143, --'Gigas_Hillrazer','Gigas Hillrazer',48,0,0,0,0);
                --17232144, --'Gigas_Clearcutter','Gigas Clearcutter',49,0,0,0,0);
                --17232145, --'Gigas_Clearcutter','Gigas Clearcutter',49,0,0,0,0);
                --17232146, --'Gigas_Overseer','Gigas Overseer',50,0,0,0,0);
    },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        itemReq = 1539, -- Hound Fang Sack
        levelCap = 40,
        npcs = 17201183, -- need npc
        mobs = 17273296
                --17273296, --'Goblin_Enchanter','Goblin Enchanter',48,0,0,0,0);
                --17273297, --'Goblin_Enchanter','Goblin Enchanter',48,0,0,0,0);
                --17273298, --'Goblin_Poacher','Goblin Poacher',49,0,0,0,0);
                --17273299, --'Goblin_Poacher','Goblin Poacher',49,0,0,0,0);
                --17273300, --'Goblin_Bouncer','Goblin Bouncer',50,0,0,0,0);
                --17273301, --'Goblin_Bouncer','Goblin Bouncer',50,0,0,0,0);
                --17273302, --'Goblin_Reaper','Goblin Reaper',51,0,0,0,0);
                --17273303, --'Goblin_Reaper','Goblin Reaper',51,0,0,0,0);
                --17273304, --'Goblin_Doyen','Goblin Doyen',52,0,0,0,0);
    },
    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        itemReq = 1542, -- Sheep Leather Missive
        levelCap = 40,
        npcs = 17201183, -- need npc
        mobs = 17281482
                --17281482, --'Brook_Sahagin','Brook Sahagin',47,0,0,0,0);
                --17281483, --'Brook_Sahagin','Brook Sahagin',47,0,0,0,0);
                --17281484, --'Rivulet_Sahagin','Rivulet Sahagin',48,0,0,0,0);
                --17281485, --'Rivulet_Sahagin','Rivulet Sahagin',48,0,0,0,0);
                --17281486, --'Lake_Sahagin','Lake Sahagin',49,0,0,0,0);
                --17281487, --'Lake_Sahagin','Lake Sahagin',49,0,0,0,0);
                --17281488, --'Brook_Sahagin','Brook Sahagin',47,0,0,0,0);
                --17281489, --'Brook_Sahagin','Brook Sahagin',47,0,0,0,0);
                --17281490, --'Sahagin_Patriarch','Sahagin Patriarch',50,0,0,0,0);
    },
    [xi.zone.XARCABARD] =
    {
        itemReq = 1537, -- Behemoth Leather Missive
        levelCap = 50,
        npcs = 17201183, -- need npc
        mobs = 17236220
                --17236220, --'Demon_Wizard','Demon Wizard',44,0,0,0,0);
                --17236221, --'Demon_Wizard','Demon Wizard',44,0,0,0,0);
                --17236222, --'Demon_Knight','Demon Knight',45,0,0,0,0);
                --17236223, --'Demon_Knight','Demon Knight',45,0,0,0,0);
                --17236224, --'Demon_Wizard','Demon Wizard',44,0,0,0,0);
                --17236225, --'Demon_Wizard','Demon Wizard',44,0,0,0,0);
                --17236226, --'Demon_Knight','Demon Knight',45,0,0,0,0);
                --17236227, --'Demon_Knight','Demon Knight',45,0,0,0,0);
                --17236228, --'Demon_Aristocrat','Demon Aristocrat',46,0,0,0,0);
    },
    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        itemReq = 1540, -- Dhalmel Leather Missive
        levelCap = 50,
        npcs = 17201183, -- need npc
        mobs = 17244540
                --17244544, --'Hastatus_XIII-XXV','Hastatus XIII-XXV',57,0,0,0,0);
                --17244545, --'Hastatus_XIII-CXXVIII','Hastatus XIII-CXXVIII',58,0,0,0,0);
                --17244546, --'Triarius_XIII-LIX','Triarius XIII-LIX',59,0,0,0,0);
                --17244547, --'Decurio_XIII-LV','Decurio XIII-LV',60,0,0,0,0);
                --17244548, --'Centurio_XIII-V','Centurio XIII-V',61,0,0,0,0);
    },
    [xi.zone.YHOATOR_JUNGLE] =
    {
        itemReq = 1543, -- Coeurl Leather Missive
        levelCap = 50,
        npcs = 17201183, -- need npc
        mobs = 17285562
                --17285562, --'Tonberry_Creeper','Tonberry Creeper',59,0,0,0,0);
                --17285563, --'Tonberry_Creeper','Tonberry Creeper',59,0,0,0,0);
                --17285564, --'Tonberry_Hexer','Tonberry Hexer',60,0,0,0,0);
                --17285565, --'Tonberry_Hexer','Tonberry Hexer',60,0,0,0,0);
                --17285566, --'Tonberry_Creeper','Tonberry Creeper',59,0,0,0,0);
                --17285567, --'Tonberry_Creeper','Tonberry Creeper',59,0,0,0,0);
                --17285568, --'Tonberry_Hexer','Tonberry Hexer',60,0,0,0,0);
                --17285569, --'Tonberry_Hexer','Tonberry Hexer',60,0,0,0,0);
                --17285570, --'Tonberry_Decimator','Tonberry Decimator',61,0,0,0,0);
    },
    [xi.zone.CAPE_TERIGGAN] =
    {
        itemReq = 1541, -- Bunny Fang Sack
        levelCap = 75,
        npcs = 17201183, -- need npc
        mobs = 17240425
                --17240425, --'Goblin_Pirate','Goblin Pirate',39,0,0,0,0);
                --17240426, --'Goblin_Pirate','Goblin Pirate',39,0,0,0,0);
                --17240427, --'Goblin_Duelist','Goblin Duelist',40,0,0,0,0);
                --17240428, --'Goblin_Duelist','Goblin Duelist',40,0,0,0,0);
                --17240429, --'Goblin_Doctor','Goblin Doctor',41,0,0,0,0);
                --17240430, --'Goblin_Doctor','Goblin Doctor',41,0,0,0,0);
                --17240431, --'Goblin_Professor','Goblin Professor',42,0,0,0,0);
                --17240432, --'Goblin_Professor','Goblin Professor',42,0,0,0,0);
                --17240433, --'Goblin_Boss','Goblin Boss',43,0,0,0,0);
    },
}
