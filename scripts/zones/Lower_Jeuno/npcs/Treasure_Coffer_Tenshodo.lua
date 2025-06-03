-----------------------------------
-- Area: Lower Jeuno
--  NPC: Treasure Coffer
-- Type: Add-on NPC
-- !pos 41.169 3.899 -51.005 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

local optionToKI =
{
    [ 1] = xi.ki.CRIMSON_KEY,
    [ 2] = xi.ki.VIRIDIAN_KEY,
    [ 3] = xi.ki.AMBER_KEY,
    [ 4] = xi.ki.AZURE_KEY,
    [ 5] = xi.ki.IVORY_KEY,
    [ 6] = xi.ki.EBON_KEY,
    [ 8] = xi.ki.WHITE_CORAL_KEY,
    [ 9] = xi.ki.BLUE_CORAL_KEY,
    [10] = xi.ki.PEACH_CORAL_KEY,
    [11] = xi.ki.BLACK_CORAL_KEY,
    [12] = xi.ki.RED_CORAL_KEY,
    [13] = xi.ki.ANGEL_SKIN_KEY,
    [15] = xi.ki.MOOGLE_KEY,
    [16] = xi.ki.BIRD_KEY,
    [17] = xi.ki.CACTUAR_KEY,
    [18] = xi.ki.BOMB_KEY,
    [19] = xi.ki.CHOCOBO_KEY,
    [20] = xi.ki.TONBERRY_KEY,
}

-- No good data on augments.  Just pulled from each key on: https://ffxiclopedia.fandom.com/wiki/Treasure_Coffer_(Tenshodo)
-- and cross referenced the individual item's page to find discrepancies
-- Order of augments is kept the same as the wiki, for ease of checking
-- augments that span negative and positive range are grouped into a single array of augments (not to pollute the pool of augments)
local keyitems =
{
    [xi.ki.CRIMSON_KEY] =
    {
        expansion = xi.mission.log_id.ACP,
        mission = xi.mission.id.acp.THE_ECHO_AWAKENS,
        repeatable = true,
        prizes =
        {
            {
                cutoff =   70,
                itemId = xi.item.GOLD_OBI,
                augments =
                {
                    { 516, 0, 1 }, -- INT+1-2
                    { 517, 0, 1 }, -- MND+1-2
                    { 518, 0, 1 }, -- CHR+1-2
                    {   9, 0, 5 }, -- MP+1-6
                    {  32, 0, 1 }, -- Evasion-1--2
                    {  96, 0, 1 }, -- Pet: Accuracy and Ranged Accuracy+1-2
                }
            },
            {
                cutoff =   80,
                itemId = xi.item.GOLD_RING,
                augments =
                {
                    {   9, 0, 8 }, -- MP+0-9
                    { 516, 0, 1 }, -- INT+0-2
                    { 517, 0, 1 }, -- MND+0-2
                    { 518, 0, 2 }, -- CHR+0-3
                    {  39, 0, 1 }, -- Enmity+0-2
                    {  35, 0, 2 }, -- Magic Accuracy+0-3
                }
            },
            {
                cutoff =  186,
                itemId = xi.item.MYTHRIL_RING,
                augments =
                {
                    {   1, 0, 15 }, -- HP+0-16
                    {  13, 0,  2 }, -- MP-0-3
                    {  25, 0,  5 }, -- Attack+0-6
                    {  31, 0,  1 }, -- Evasion+0-2
                    { 195, 0,  1 }, -- Subtle Blow+0-2
                    {  35, 0,  1 }, -- Magic Accuracy+0-2
                }
            },
            {
                cutoff =  276,
                itemId = xi.item.SARCENET_CAPE,
                augments =
                {
                    {   9, 0, 5 }, -- MP+0-6
                    { 516, 0, 1 }, -- INT+0-2
                    { 517, 0, 1 }, -- MND+0-2
                    { 518, 0, 1 }, -- CHR+0-2
                    { 100, 0, 1 }, -- Pet: Magic Accuracy+0-2
                    {  39, 0, 1 }, -- Enmity+0-2
                }
            },
            {
                cutoff =  351,
                itemId = xi.item.SILVER_BELT,
                augments =
                {
                    {   1, 0, 5 }, -- HP+0-6
                    {  23, 0, 1 }, -- Accuracy+0-2
                    {  27, 0, 1 }, -- Ranged Accuracy+0-2
                    { 515, 0, 1 }, -- AGI+0-2
                    { 512, 0, 1 }, -- STR+0-2
                    { 520, 0, 1 }, -- DEX-0-2
                }
            },
            {
                cutoff =  460,
                itemId = xi.item.WOLF_MANTLE,
                augments =
                {
                    {   1, 0, 5 }, -- HP+0-6
                    {  25, 0, 3 }, -- Attack+0-4
                    {  29, 0, 3 }, -- Ranged Attack+0-4
                    { 512, 0, 0 }, -- STR+0-1
                    { 769, 0, 2 }, -- Ice+0-3
                    {  32, 0, 2 }, -- Evasion-0-3
                }
            },
            { cutoff =  468, itemId = xi.item.CHESTNUT_LOG },
            { cutoff =  471, itemId = xi.item.CORAL_FRAGMENT },
            { cutoff =  476, itemId = xi.item.DARK_SPIRIT_PACT },
            { cutoff =  479, itemId = xi.item.DARKSTEEL_INGOT },
            { cutoff =  500, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
            { cutoff =  523, itemId = xi.item.SCROLL_OF_DISPEL },
            { cutoff =  619, itemId = xi.item.ELIXIR },
            { cutoff =  668, itemId = xi.item.ELM_LOG },
            { cutoff =  699, itemId = xi.item.SCROLL_OF_ERASE },
            { cutoff =  702, itemId = xi.item.HI_POTION },
            { cutoff =  723, itemId = xi.item.IRON_INGOT },
            { cutoff =  775, itemId = xi.item.CHUNK_OF_IRON_ORE },
            { cutoff =  785, itemId = xi.item.LIGHT_SPIRIT_PACT },
            { cutoff =  821, itemId = xi.item.SCROLL_OF_MAGIC_FINALE },
            { cutoff =  824, itemId = xi.item.MAPLE_LOG },
            { cutoff =  858, itemId = xi.item.MYTHRIL_INGOT },
            { cutoff =  879, itemId = xi.item.CHUNK_OF_MYTHRIL_ORE },
            { cutoff =  884, itemId = xi.item.POTION_P1 },
            { cutoff =  923, itemId = xi.item.SILVER_INGOT },
            { cutoff =  949, itemId = xi.item.CHUNK_OF_SILVER_ORE },
            { cutoff =  993, itemId = xi.item.STEEL_INGOT },
            { cutoff = 1003, itemId = xi.item.SCROLL_OF_UTSUSEMI_NI },
        },
    },
    [xi.ki.VIRIDIAN_KEY] =
    {
        expansion = xi.mission.log_id.ACP,
        mission = xi.mission.id.acp.GATHERER_OF_LIGHT_I,
        repeatable = true,
        prizes =
        {
            {
                cutoff =   65,
                itemId = xi.item.AURORA_MANTLE,
                augments =
                {
                    {   9, 0, 19 }, -- MP+0-20
                    {   1, 0, 19 }, -- HP+0-20
                    {  40, 0,  1 }, -- Enmity-0-2
                    { 771, 0,  6 }, -- Earth+0-7
                    { 768, 0,  6 }, -- Fire+0-7
                    {  34, 2,  3 }, -- DEF-3-4
                }
            },
            {
                cutoff =  142,
                itemId = xi.item.CORSETTE,
                augments =
                {
                    { 23, 0,  2 }, -- Accuracy+0-3
                    { 31, 0,  1 }, -- Evasion+0-2
                    {  9, 0, 13 }, -- MP+0-14
                    { 26, 0,  1 }, -- Attack-0-2
                    {  1, 0, 12 }, -- HP+0-13
                    { 49, 0,  2 }, -- Haste+0-3
                }
            },
            {
                cutoff =  237,
                itemId = xi.item.NYMPH_SHIELD,
                augments =
                {
                    {   9, 0, 9 }, -- MP+0-10
                    { 517, 0, 0 }, -- MND+0-1
                    { 516, 0, 0 }, -- INT+0-1
                    { 512, 0, 0 }, -- STR+0-1
                    { 518, 0, 0 }, -- CHR+0-1
                    {  35, 0, 1 }, -- Magic Accuracy+0-2
                }
            },
            {
                cutoff =  356,
                itemId = xi.item.RAM_MANTLE,
                augments =
                {
                    {   5, 0,  5 }, -- HP-0-6
                    {  13, 0, 10 }, -- MP-0-11
                    { 515, 0,  0 }, -- AGI+0-1
                    { 513, 0,  0 }, -- DEX+0-1
                    {  23, 0,  3 }, -- Accuracy+0-4
                    {  27, 0,  3 }, -- Ranged Accuracy+0-4
                }
            },
            {
                cutoff =  457,
                itemId = xi.item.SWORDBELT,
                augments =
                {
                    {   1, 0, 4 }, -- HP+0-5
                    { 512, 0, 1 }, -- STR+0-2
                    { 513, 0, 1 }, -- DEX+0-2
                    { 514, 0, 0 }, -- VIT+0-1
                    {  24, 0, 2 }, -- Accuracy-0-3
                    {  29, 0, 3 }, -- Ranged Attack+0-4
                    {  52, 1, 1 },-- MP Recovered While Healing
                }
            },
            { cutoff =  469, itemId = xi.item.BLACK_PEARL },
            { cutoff =  497, itemId = xi.item.BLACK_ROCK },
            { cutoff =  515, itemId = xi.item.BLUE_ROCK },
            { cutoff =  616, itemId = xi.item.ELIXIR },
            { cutoff =  670, itemId = xi.item.ETHER_P1 },
            { cutoff =  676, itemId = xi.item.GARNET },
            { cutoff =  672, itemId = xi.item.GOSHENITE },
            { cutoff =  684, itemId = xi.item.GREEN_ROCK },
            { cutoff =  775, itemId = xi.item.OAK_LOG },
            { cutoff =  811, itemId = xi.item.PEARL },
            { cutoff =  829, itemId = xi.item.PERIDOT },
            { cutoff =  835, itemId = xi.item.CHUNK_OF_PLATINUM_ORE },
            { cutoff =  871, itemId = xi.item.POTION_P1 },
            { cutoff =  877, itemId = xi.item.PURPLE_ROCK },
            { cutoff =  901, itemId = xi.item.RED_ROCK },
            { cutoff =  984, itemId = xi.item.ROSEWOOD_LOG },
            { cutoff = 1008, itemId = xi.item.SPHENE },
            { cutoff = 1020, itemId = xi.item.TRANSLUCENT_ROCK },
            { cutoff = 1032, itemId = xi.item.WHITE_ROCK },
            { cutoff = 1044, itemId = xi.item.YELLOW_ROCK },
            { cutoff = 1056, itemId = xi.item.TURQUOISE },
        },
    },
    [xi.ki.AMBER_KEY] =
    {
        expansion = xi.mission.log_id.ACP,
        mission = xi.mission.id.acp.GATHERER_OF_LIGHT_II,
        repeatable = true,
        prizes =
        {
            {
                cutoff = 111,
                itemId = xi.item.BEAK_NECKLACE,
                augments =
                {
                    {   9, 0, 12 }, -- MP+0-13
                    {  35, 0,  1 }, -- Magic Accuracy+0-2
                    { 516, 0,  1 }, -- INT+0-2
                    { 518, 0,  1 }, -- CHR+0-2
                    { 517, 0,  1 }, -- MND+0-2
                    {  97, 0,  4 }, -- Pet: Attack and Ranged Attack+0-5
                    {  39, 0,  1 }, -- Enmity+0-2
                }
            },
            {
                cutoff = 219,
                itemId = xi.item.BROCADE_OBI,
                augments =
                {
                    {   1, 0, 11 }, -- HP+0-12
                    {   9, 0, 11 }, -- MP+0-12
                    {  35, 0,  2 }, -- Magic Accuracy+0-3
                    { 290, 0,  2 }, -- Enhancing Magic Skill+0-3
                    {  50, 0,  0 }, -- Slow+0-1
                    { 100, 0,  2 }, -- Pet: Magic Accuracy+0-3
                }
            },
            {
                cutoff = 334,
                itemId = xi.item.CARAPACE_GORGET,
                augments =
                {
                    { 513, 0,  0 }, -- DEX+0-1
                    { 512, 0,  2 }, -- STR+0-3
                    {  25, 0,  6 }, -- Attack+0-7
                    {  29, 0,  6 }, -- Ranged Attack+0-7
                    { 142, 0,  1 }, -- Store TP+0-2
                    {  24, 0,  3 }, -- Accuracy-0-4
                    { 773, 0,  5 }, -- Water+0-6
                }
            },
            {
                cutoff = 436,
                itemId = xi.item.GOLD_RING,
                augments =
                {
                    {   9, 0, 13 }, -- MP+0-14
                    { 516, 0,  1 }, -- INT+0-2
                    { 517, 0,  1 }, -- MND+0-2
                    { 518, 0,  1 }, -- CHR+0-2
                    {  39, 0,  1 }, -- Enmity+0-2
                    {  35, 0,  2 }, -- Magic Accuracy+0-3
                }
            },
            {
                cutoff = 561,
                itemId = xi.item.RAPTOR_MANTLE,
                augments =
                {
                    {   1, 0, 29 }, -- HP+0-30
                    { { 520, 0,  1 }, { 513, 0, 1 }, }, -- DEX-2-+2 (split into two augments)
                    { 515, 0,  2 }, -- AGI+0-3
                    { 514, 0,  2 }, -- VIT+0-3
                    {  39, 0,  1 }, -- Enmity+0-2
                    { 774, 0,  5 }, -- Light resist +0-6
                }
            },
            { cutoff = 564, itemId = xi.item.CORAL_FRAGMENT },
            { cutoff = 576, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
            { cutoff = 599, itemId = xi.item.DEMON_HORN },
            { cutoff = 616, itemId = xi.item.EBONY_LOG },
            { cutoff = 625, itemId = xi.item.CHUNK_OF_GOLD_ORE },
            { cutoff = 683, itemId = xi.item.HI_ELIXIR },
            { cutoff = 730, itemId = xi.item.HI_ETHER },
            { cutoff = 771, itemId = xi.item.HI_POTION },
            { cutoff = 788, itemId = xi.item.MAHOGANY_LOG },
            { cutoff = 805, itemId = xi.item.MANTICORE_HIDE },
            { cutoff = 807, itemId = xi.item.PETRIFIED_LOG },
            { cutoff = 809, itemId = xi.item.CHUNK_OF_PLATINUM_ORE },
            { cutoff = 818, itemId = xi.item.CHUNK_OF_MYTHRIL_ORE },
            { cutoff = 835, itemId = xi.item.RAM_HORN },
            { cutoff = 876, itemId = xi.item.RAM_SKIN },
            { cutoff = 885, itemId = xi.item.SCROLL_OF_RAISE_II },
            { cutoff = 920, itemId = xi.item.SCROLL_OF_REGEN_III },
            { cutoff = 946, itemId = xi.item.HANDFUL_OF_WYVERN_SCALES },
            { cutoff = 961, itemId = xi.item.WYVERN_SKIN },
        },
    },
    [xi.ki.AZURE_KEY] =
    {
        expansion = xi.mission.log_id.ACP,
        mission = xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II,
        repeatable = true,
        prizes =
        {
            {
                cutoff = 106,
                itemId = xi.item.BEAK_MANTLE,
                augments =
                {
                    { 512, 0,  1 }, -- STR+0-2
                    { 513, 0,  1 }, -- DEX+0-2
                    {  26, 0,  5 }, -- Attack-0-6
                    {  23, 0,  6 }, -- Accuracy+0-7
                    {  31, 0,  6 }, -- Evasion+0-7
                    { 195, 0,  1 }, -- Subtle Blow+0-2
                }
            },
            {
                cutoff = 203,
                itemId = xi.item.COEURL_GORGET,
                augments =
                {
                    { 515, 0,  3 }, -- AGI+0-4
                    {  23, 0,  7 }, -- Accuracy+0-8
                    {  27, 0,  7 }, -- Ranged Accuracy+0-8
                    {  30, 0,  3 }, -- Ranged Attack-0-4
                    { 195, 0,  1 }, -- Subtle Blow+0-2
                    { 771, 0,  3 }, -- Earth+0-4
                }
            },
            {
                cutoff = 305,
                itemId = xi.item.PLATINUM_RING,
                augments =
                {
                    {   1, 0,  9 }, -- HP+0-10
                    { 512, 0,  1 }, -- STR+0-2
                    { 513, 0,  1 }, -- DEX+0-2
                    { 514, 0,  1 }, -- VIT+0-2
                    {  26, 0,  2 }, -- Attack-0-3
                    {  23, 0,  2 }, -- Accuracy+0-3
                }
            },
            {
                cutoff = 386,
                itemId = xi.item.RAINBOW_OBI,
                augments =
                {
                    {   9, 0, 19 }, -- MP+0-20
                    { 516, 0,  4 }, -- INT+0-5
                    { 517, 0,  4 }, -- MND+0-5
                    { 518, 0,  4 }, -- CHR+0-5
                    {  36, 0,  2 }, -- Magic Accuracy-0-3
                    {  52, 0,  2 }, -- MP Recovered While Healing+1-3
                }
            },
            {
                cutoff = 490,
                itemId = xi.item.TORQUE,
                augments =
                {
                    {   5, 0, 13 }, -- HP-0-14
                    {   9, 0, 12 }, -- MP+0-13
                    { 515, 0,  2 }, -- AGI+0-3
                    { 516, 0,  1 }, -- INT+0-2
                    { 517, 0,  1 }, -- MND+0-2
                    { 518, 0,  1 }, -- CHR+0-2
                }
            },
            { cutoff = 498, itemId = xi.item.AQUAMARINE },
            { cutoff = 502, itemId = xi.item.CHRYSOBERYL },
            { cutoff = 536, itemId = xi.item.DARKSTEEL_INGOT },
            { cutoff = 612, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
            { cutoff = 659, itemId = xi.item.EBONY_LOG },
            { cutoff = 693, itemId = xi.item.GOLD_INGOT },
            { cutoff = 786, itemId = xi.item.HI_ELIXIR },
            { cutoff = 789, itemId = xi.item.HI_ETHER_P1 },
            { cutoff = 831, itemId = xi.item.HI_POTION_P1 },
            { cutoff = 835, itemId = xi.item.JADEITE },
            { cutoff = 856, itemId = xi.item.MAHOGANY_LOG },
            { cutoff = 907, itemId = xi.item.MYTHRIL_INGOT },
            { cutoff = 911, itemId = xi.item.RAM_HORN },
            { cutoff = 915, itemId = xi.item.SCROLL_OF_REGEN_III },
            { cutoff = 948, itemId = xi.item.STEEL_INGOT },
            { cutoff = 956, itemId = xi.item.SUNSTONE },
            { cutoff = 960, itemId = xi.item.HANDFUL_OF_WYVERN_SCALES },
        },
    },
    [xi.ki.IVORY_KEY] =
    {
        expansion = xi.mission.log_id.ACP,
        mission = xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III,
        repeatable = true,
        prizes =
        {
            {
                cutoff =   62,
                itemId = xi.item.ANGELS_EARRING,
                augments =
                {
                    { 518, 0, 1 }, -- CHR+1-2
                    {  40, 0, 1 }, -- Enmity-2--1
                    {   1, 0, 9 }, -- HP+1-10
                    {   9, 0, 9 }, -- MP+1-10
                    { 105, 0, 1 }, -- Pet: Enmity-2--1
                    { 106, 0, 0 }, -- Pet: Accuracy and Ranged Accuracy+0-1
                    {  34, 0, 3 }, -- Def-4--1
                }
            },
            {
                cutoff =   70,
                itemId = xi.item.DEATH_EARRING,
                augments =
                {
                    {  33, 0, 3 }, -- Defense+1-4
                    {  39, 0, 1 }, -- Enmity+1-2
                    {   1, 0, 9 }, -- HP+1-10
                    {   9, 0, 9 }, -- MP+1-10
                    { 104, 0, 1 }, -- Pet: Enmity+1-2
                    { 521, 0, 1 }, -- VIT-2--1
                }
            },
            {
                cutoff =  113,
                itemId = xi.item.DIAMOND_EARRING,
                augments =
                {
                    { 516, 0, 1 }, -- INT+1-2
                    { 515, 0, 0 }, -- AGI+1
                    { 133, 0, 1 }, -- Magic Attack Bonus+1-2
                    {   9, 0, 5 }, -- MP+1-6
                    {  36, 0, 0 }, -- Magic Accuracy-1
                    { 101, 0, 1 }, -- Pet: Magic Attack Bonus+1-2
                }
            },
            {
                cutoff =  196,
                itemId = xi.item.EMERALD_EARRING,
                augments =
                {
                    { 515, 0, 1 }, -- AGI+1-2
                    {  31, 0, 4 }, -- Evasion+1-5
                    {  98, 0, 4 }, -- Pet: Evasion+1-5
                    {  27, 0, 2 }, -- Ranged Accuracy+1-3
                    { 514, 0, 0 }, -- VIT+1
                    {  30, 0, 1 }, -- Ranged Attack-2--1
                }
            },
            {
                cutoff =  301,
                itemId = xi.item.RUBY_EARRING,
                augments =
                {
                    {  25, 0, 4 }, -- Attack+1-5
                    { 516, 0, 0 }, -- INT+1
                    {  97, 0, 4 }, -- Pet: Attack and Ranged Attack+1-5
                    {  29, 0, 4 }, -- Ranged Attack+1-5
                    { 512, 0, 1 }, -- STR+1-2
                    {  24, 0, 2 }, -- Accuracy-3--1
                }
            },
            {
                cutoff =  392,
                itemId = xi.item.SAPPHIRE_EARRING,
                augments =
                {
                    {  35, 0, 1 }, -- Magic Accuracy+1-2
                    { 517, 0, 1 }, -- MND+1-2
                    {   9, 0, 5 }, -- MP+1-6
                    { 100, 0, 1 }, -- Pet: Magic Accuracy+1-2
                    { 512, 0, 1 }, -- STR+1-2
                    {   5, 0, 6 }, -- HP-7--1
                }
            },
            {
                cutoff =  478,
                itemId = xi.item.SPINEL_EARRING,
                augments =
                {
                    {  23, 0, 2 }, -- Accuracy+1-3
                    { 513, 0, 1 }, -- DEX+1-2
                    { 517, 0, 0 }, -- MND+1
                    {  96, 0, 2 }, -- Pet: Accuracy and Ranged Accuracy+1-3
                    { 142, 0, 0 }, -- Store TP+1
                    { 195, 0, 1 }, -- Subtle Blow+1-2
                    {  26, 0, 4 }, -- Attack-5--1
                }
            },
            {
                cutoff =  497,
                itemId = xi.item.TOPAZ_EARRING,
                augments =
                {
                    {  33, 0,  4 }, -- DEF+1-5
                    { 513, 0,  1 }, -- DEX+1-2
                    {   1, 0, 19 }, -- HP+1-20
                    {  99, 0,  4 }, -- PET: DEF+1-5
                    { 514, 0,  1 }, -- VIT+1-2
                    {  32, 0,  2 }, -- Evasion-3--1
                }
            },
            { cutoff =  546, itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD },
            { cutoff =  602, itemId = xi.item.SPOOL_OF_GOLD_THREAD },
            { cutoff =  627, itemId = xi.item.SLAB_OF_GRANITE },
            { cutoff =  658, itemId = xi.item.HI_ETHER_P2 },
            { cutoff =  901, itemId = xi.item.HI_POTION_P2 },
            { cutoff =  963, itemId = xi.item.SPOOL_OF_MALBORO_FIBER },
            { cutoff =  982, itemId = xi.item.PHILOSOPHERS_STONE },
            { cutoff = 1019, itemId = xi.item.PHOENIX_FEATHER },
            { cutoff = 1062, itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH },
            { cutoff = 1124, itemId = xi.item.SQUARE_OF_RAXA },
            { cutoff = 1172, itemId = xi.item.VILE_ELIXIR },
        },
    },
    [xi.ki.EBON_KEY] =
    {
        expansion = xi.mission.log_id.ACP,
        mission = xi.mission.id.acp.ODE_OF_LIFE_BESTOWING,
        repeatable = true,
        prizes =
        {
            {
                cutoff =  31,
                itemId = xi.item.ANGELS_RING,
                augments =
                {
                    -- https://ffxiclopedia.fandom.com/wiki/Ebon_Key?oldid=934097 doesn't list -acc and -def, but this had -dark resist before the restructure
                    -- and that seems to fit the theme of the other rewards
                    {  40, 0,  1 }, -- Enmity-0-2
                    {   1, 0, 19 }, -- HP+0-20
                    { 518, 0,  0 }, -- CHR+1
                    {  23, 1,  5 }, -- Accuracy+2-6
                    {  96, 0,  3 }, -- Pet: Accuracy and Ranged Accuracy+1-4
                    { 783, 0, 29 },-- dark resist -0-30
                }
            },
            {
                cutoff =  82,
                itemId = xi.item.DEATH_RING,
                augments =
                {
                    { 782, 0, 29 }, -- Light-0-30
                    { 525, 0,  2 }, -- CHR-0-3
                    {   9, 0, 19 }, -- MP+0-20
                    {  33, 0,  6 }, -- Defense+0-7
                    {  31, 0,  4 }, -- Evasion+0-5
                    {  39, 0,  0 }, -- Enmity+1
                }
            },
            {
                cutoff = 174,
                itemId = xi.item.DIAMOND_RING,
                augments =
                {
                    { 776, 0, 29 }, -- Fire-0-30
                    { 519, 0,  4 }, -- STR-0-5
                    {   9, 0,  9 }, -- MP+0-10
                    { 515, 0,  2 }, -- AGI+0-3
                    { 516, 0,  0 }, -- INT+1
                    { 517, 0,  1 }, -- MND+0-2
                }
            },
            {
                cutoff = 225,
                itemId = xi.item.EMERALD_RING,
                augments =
                {
                    { 777, 0, 29 }, -- ice -0-30 (wiki is conflicting, might be water?)
                    { 523, 0,  4 }, -- INT-0-5
                    {   1, 0,  8 }, -- HP+0-9
                    { 512, 0,  1 }, -- STR+0-2
                    { 514, 0,  2 }, -- VIT+0-3
                    { 515, 0,  0 }, -- AGI+1
                }
            },
            {
                cutoff = 296,
                itemId = xi.item.RUBY_RING,
                augments =
                {
                    { 781, 0, 29 }, -- Water-0-30
                    { 524, 0,  1 }, -- MND-0-2
                    {   1, 0,  9 }, -- HP+0-10
                    { 512, 0,  0 }, -- STR+1
                    { 513, 0,  1 }, -- DEX+0-2
                    { 516, 0,  2 }, -- INT+0-3
                }
            },
            {
                cutoff = 357,
                itemId = xi.item.SAPPHIRE_RING,
                augments =
                {
                    { 780, 0, 29 }, -- Lightning-0-30
                    {   9, 0,  9 }, -- MP+0-10
                    { { 519, 0,  0 }, { 512, 0, 2 }, }, -- STR-1-+3 (split into two augments)
                    { 520, 0,  3 }, -- DEX-1-4
                    { 517, 0,  0 }, -- MND+1
                    { 518, 0,  2 }, -- CHR+0-3
                }
            },
            {
                cutoff = 459,
                itemId = xi.item.SPINEL_RING,
                augments =
                {
                    { 779, 0, 29 }, -- Earth-0-30
                    {   1, 0,  9 }, -- HP+0-10
                    { 513, 0,  0 }, -- DEX+1
                    { 521, 0,  0 }, -- VIT-0-1
                    { 515, 0,  1 }, -- AGI+0-2
                    { 517, 0,  2 }, -- MND+0-3
                    {  23, 0,  0 }, -- Accuracy+1
                    { 195, 0,  1 }, -- Subtle Blow+0-2
                    {  96, 0,  1 }, -- Pet: Accuracy and Ranged Accuracy+0-2
                }
            },
            {
                cutoff = 500,
                itemId = xi.item.TOPAZ_RING,
                augments =
                {
                    { 778, 0, 29 }, -- Wind-0-30
                    { 522, 0,  5 }, -- AGI-0-6
                    { 771, 0,  8 }, -- Earth+0-9
                    {   1, 0,  9 }, -- HP+0-10
                    { 513, 0,  1 }, -- DEX+0-2
                    { 514, 0,  0 }, -- VIT+1
                    { 516, 0,  2 }, -- INT+0-3
                }
            },
            { cutoff = 510, itemId = xi.item.ADAMAN_INGOT },
            { cutoff = 541, itemId = xi.item.ANGELSTONE },
            { cutoff = 561, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
            { cutoff = 592, itemId = xi.item.DEATHSTONE },
            { cutoff = 633, itemId = xi.item.DIAMOND },
            { cutoff = 643, itemId = xi.item.EMERALD },
            { cutoff = 714, itemId = xi.item.HI_ETHER_P3 },
            { cutoff = 785, itemId = xi.item.HI_POTION_P3 },
            { cutoff = 805, itemId = xi.item.CHUNK_OF_ORICHALCUM_ORE },
            { cutoff = 815, itemId = xi.item.CHUNK_OF_PLATINUM_ORE },
            { cutoff = 835, itemId = xi.item.RUBY },
            { cutoff = 855, itemId = xi.item.SAPPHIRE },
            { cutoff = 896, itemId = xi.item.SCROLL_OF_CURE_V },
            { cutoff = 916, itemId = xi.item.SCROLL_OF_SHELL_IV },
            { cutoff = 936, itemId = xi.item.SCROLL_OF_THUNDER_III },
            { cutoff = 987, itemId = xi.item.VILE_ELIXIR },
            { cutoff = 997, itemId = xi.item.SCROLL_OF_RAISE_III },
        },
    },
    [xi.ki.PRISMATIC_KEY] =
    {
        expansion = xi.mission.log_id.ACP,
        mission = xi.mission.id.acp.ODE_OF_LIFE_BESTOWING,
        repeatable = false,
    },
    [xi.ki.WHITE_CORAL_KEY] =
    {
        expansion = xi.mission.log_id.AMK,
        mission = xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP,
        repeatable = true,
        prizes =
        {
            {
                cutoff =   31,
                itemId = xi.item.BRASS_MASK,
                augments =
                {
                    {   1, 0, 1 }, -- HP +1-2
                    {   9, 0, 2 }, -- MP +1-3
                    { 514, 0, 0 }, -- VIT +1
                    {  24, 0, 2 }, -- Accuracy -1-3
                    { 142, 0, 0 }, -- Store TP +1
                    { 177, 0, 0 }, -- Resist Poison +1
                },
            },
            {
                cutoff =  109,
                itemId = xi.item.CHESTNUT_SABOTS,
                augments =
                {
                    {  13, 5, 5 }, -- MP -6
                    { 517, 0, 1 }, -- MND +1-2
                    { 100, 1, 1 }, -- Pet: Magic Accuracy +2
                    {  40, 1, 1 }, -- Enmity -2
                    { 773, 1, 2 }, -- Water Resist +2-3
                    {  53, 2, 2 }, -- Spell Interruption Rate down 3%
                },
            },
            {
                cutoff =  218,
                itemId = xi.item.COTTON_GLOVES,
                augments =
                {
                    {  23, 0, 1 }, -- Accuracy +1-2
                    { 768, 0, 1 }, -- Fire resist +1-2
                    { 769, 0, 0 }, -- Ice resist +1
                    { 513, 0, 0 }, -- DEX +1
                    { 515, 0, 0 }, -- AGI +1
                },
            },
            {
                cutoff =  296,
                itemId = xi.item.STUDDED_TROUSERS,
                augments =
                {
                    {  29, 0, 1 }, -- Ranged Attack +1-2
                    {  25, 0, 2 }, -- Attack +1-3
                    { 195, 1, 1 }, -- Subtle Blow +2
                    {  99, 0, 1 }, -- Pet: Defense +1-2
                    { 179, 0, 3 }, -- Resist Blind +1-4
                },
            },
            {
                cutoff =  437,
                itemId = xi.item.WOOL_ROBE,
                augments =
                {
                    { 771, 0, 4 }, -- Earth resist +1-5
                    { 515, 0, 1 }, -- AGI +1-2
                    {  29, 0, 0 }, -- Ranged Attack +1
                    {  27, 0, 3 }, -- Ranged Accuracy +1-4
                    {  40, 0, 0 }, -- Enmity -1
                    { 519, 0, 1 }, -- STR -1-2
                },
            },
            { cutoff =  468, itemId = xi.item.CHESTNUT_LOG },
            { cutoff =  499, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
            { cutoff =  624, itemId = xi.item.ELIXIR },
            { cutoff =  655, itemId = xi.item.ELM_LOG },
            { cutoff =  686, itemId = xi.item.CHUNK_OF_IRON_ORE },
            { cutoff =  717, itemId = xi.item.IRON_INGOT },
            { cutoff =  764, itemId = xi.item.MYTHRIL_INGOT },
            { cutoff =  780, itemId = xi.item.CHUNK_OF_MYTHRIL_ORE },
            { cutoff =  843, itemId = xi.item.SILVER_INGOT },
            { cutoff =  874, itemId = xi.item.CHUNK_OF_SILVER_ORE },
            { cutoff =  937, itemId = xi.item.STEEL_INGOT },
            { cutoff =  968, itemId = xi.item.SCROLL_OF_DISPEL },
            { cutoff =  999, itemId = xi.item.SCROLL_OF_MAGIC_FINALE },
            { cutoff = 1015, itemId = xi.item.SCROLL_OF_UTSUSEMI_NI },
            { cutoff = 1031, itemId = xi.item.SCROLL_OF_ERASE },
        },
    },
    [xi.ki.BLUE_CORAL_KEY] =
    {
        expansion = xi.mission.log_id.AMK,
        mission = xi.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE,
        repeatable = true,
        prizes =
        {
            {
                cutoff =   42,
                itemId = xi.item.CUIR_BOUILLI,
                augments =
                {
                    {   1, 3, 3 }, -- HP+4
                    { 291, 1, 1 }, -- Enfeebling Magic+2
                    {  52, 1, 1 }, -- MP Recovered While Healing+2
                    { 187, 0, 2 }, -- Resist Stun+1-3
                    { 322, 0, 0 }, -- Song Spellcasting Time-1%
                    {  39, 0, 0 }, -- Enmity+1
                },
            },
            {
                cutoff =  250,
                itemId = xi.item.IRON_GREAVES,
                augments =
                {
                    {   1, 1, 1 }, -- HP +2
                    { 512, 0, 0 }, -- STR +1
                    { 518, 0, 1 }, -- CHR +1-2
                    { 133, 0, 1 }, -- Magic Attack Bonus +1-2
                    { 774, 0, 5 }, -- Light resist +1-6
                },
            },
            {
                cutoff =  292,
                itemId = xi.item.LINEN_SLACKS,
                augments =
                {
                    {   9, 6, 6 }, -- MP +7
                    { 524, 1, 1 }, -- MND -2
                    { 141, 1, 1 }, -- Conserve MP +2
                    {  53, 0, 3 }, -- Spell Interruption Rate -1-4%
                    {  35, 0, 1 }, -- Magic Accuracy +1-2
                },
            },
            {
                cutoff =  375,
                itemId = xi.item.PADDED_CAP,
                augments =
                {
                    { 513, 1, 1 }, -- DEX +2
                    { 515, 0, 0 }, -- AGI +1
                    {  25, 0, 1 }, -- Attack +1-2
                    { 772, 0, 0 }, -- Lightning resist +1
                },
            },
            {
                cutoff =  458,
                itemId = xi.item.VELVET_CUFFS,
                augments =
                {
                    {   5, 0, 0 }, -- HP -1
                    {  96, 0, 0 }, -- Pet: Accuracy +1 Ranged Accuracy +1
                    { 176, 0, 1 }, -- Resist Sleep +1-2
                    {  31, 2, 2 }, -- Evasion +3
                },
            },
            { cutoff =  500, itemId = xi.item.BLACK_PEARL },
            { cutoff =  583, itemId = xi.item.ELIXIR },
            { cutoff =  625, itemId = xi.item.ETHER_P1 },
            { cutoff =  667, itemId = xi.item.GARNET },
            { cutoff =  709, itemId = xi.item.PERIDOT },
            { cutoff =  751, itemId = xi.item.POTION_P1 },
            { cutoff =  876, itemId = xi.item.OAK_LOG },
            { cutoff =  918, itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH },
            { cutoff =  960, itemId = xi.item.RED_ROCK },
            { cutoff = 1002, itemId = xi.item.TURQUOISE },
        },
    },
    [xi.ki.PEACH_CORAL_KEY] =
    {
        expansion = xi.mission.log_id.AMK,
        mission = xi.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE,
        repeatable = true,
        prizes =
        {
            {
                cutoff =   66,
                itemId = xi.item.CARAPACE_HARNESS,
                augments =
                {
                    {  23, 0, 5 }, -- Accuracy +1-6
                    {  25, 0, 3 }, -- Attack +1-4
                    {  31, 0, 5 }, -- Evasion +1-6
                    { 195, 0, 3 }, -- Subtle Blow +1-4
                    { 178, 0, 2 }, -- Resist Paralyze +1-3
                    {  50, 0, 1 }, -- Slow +1-2
                },
            },
            {
                cutoff =  198,
                itemId = xi.item.RAPTOR_LEDELSENS,
                augments =
                {
                    {   1, 0,  5 }, -- HP +1-6
                    {   9, 3, 11 }, -- MP +4-12
                    { 514, 0,  2 }, -- VIT +1-3
                    {  99, 0,  3 }, -- Pet: DEF +1-4
                    {  36, 0,  1 }, -- Magic Accuracy -1-2
                },
            },
            {
                cutoff =  303,
                itemId = xi.item.SILK_HAT,
                augments =
                {
                    {  13, 1, 1 }, -- MP-2
                    { 289, 0, 2 }, -- Healing Magic Skill +1-3
                    { 291, 0, 2 }, -- Enfeebling Magic Skill +1-3
                    { 100, 0, 1 }, -- Pet: Magic Accuracy +1-2
                    { 293, 0, 2 }, -- Dark Magic Skill +1-3
                },
            },
            {
                cutoff =  395,
                itemId = xi.item.STEEL_FINGER_GAUNTLETS,
                augments =
                {
                    {  68, 0, 2 }, -- Accuracy +1-3 Attack +1-3
                    {  49, 0, 0 }, -- Haste +1
                    { 186, 0, 2 }, -- Resist Slow +1-3
                    { 770, 0, 2 }, -- Wind resist +1-3
                },
            },
            {
                cutoff =  487,
                itemId = xi.item.WHITE_SLACKS,
                augments =
                {
                    { 516, 0, 3 }, -- INT+1-4
                    { 517, 0, 3 },-- MND+1-4
                    { 518, 0, 3 },-- CHR+1-4
                    { 320, 0, 2 }, -- Blood Pact Ability Delay -1-3
                    {  53, 0, 3 }, -- Spell Interruption Rate down 1-4%
                    {  39, 0, 2 }, -- Enmity +1-3
                },
            },
            { cutoff =  500, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
            { cutoff =  526, itemId = xi.item.DEMON_HORN },
            { cutoff =  565, itemId = xi.item.EBONY_LOG },
            { cutoff =  591, itemId = xi.item.CHUNK_OF_GOLD_ORE },
            { cutoff =  696, itemId = xi.item.HI_ELIXIR },
            { cutoff =  747, itemId = xi.item.HI_ETHER },
            { cutoff =  773, itemId = xi.item.HI_POTION },
            { cutoff =  786, itemId = xi.item.MAHOGANY_LOG },
            { cutoff =  839, itemId = xi.item.MANTICORE_HIDE },
            { cutoff =  852, itemId = xi.item.CHUNK_OF_MYTHRIL_ORE },
            { cutoff =  891, itemId = xi.item.PETRIFIED_LOG },
            { cutoff =  930, itemId = xi.item.SCROLL_OF_RAISE_II },
            { cutoff =  969, itemId = xi.item.CHUNK_OF_PLATINUM_ORE },
            { cutoff = 1008, itemId = xi.item.RAM_HORN },
            { cutoff = 1021, itemId = xi.item.RAM_SKIN },
            { cutoff = 1074, itemId = xi.item.SCROLL_OF_REGEN_III },
            { cutoff = 1087, itemId = xi.item.HANDFUL_OF_WYVERN_SCALES },
            { cutoff = 1103, itemId = xi.item.WYVERN_SKIN },
        },
    },
    [xi.ki.BLACK_CORAL_KEY] =
    {
        expansion = xi.mission.log_id.AMK,
        mission = xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY,
        repeatable = true,
        prizes =
        {
            {
                cutoff =   90,
                itemId = xi.item.BEAK_HELM,
                augments =
                {
                    {  9, 0, 5 }, -- MP +1-6
                    { 25, 0, 3 }, -- Attack +1-4
                    { 23, 0, 5 }, -- Accuracy +1-6
                    { 31, 0, 4 }, -- Evasion +1-5
                    { 27, 0, 5 }, -- Ranged Accuracy +1-6
                },
            },
            {
                cutoff =  194,
                itemId = xi.item.PIGACHES,
                augments =
                {
                    {   1, 1, 11 }, -- HP +2-12
                    {  29, 0,  2 }, -- Ranged Attack +1-3
                    {  27, 0,  1 }, -- Ranged Accuracy +1-2
                    {  51, 0,  1 }, -- HP Recovered While Healing +1-2
                    { 513, 0,  1 }, -- DEX +1-2
                    { 522, 0,  1 }, -- AGI -1-2
                },
            },
            {
                cutoff =  224,
                itemId = xi.item.DARKSTEEL_BREECHES,
                augments =
                {
                    { 770, 1, 4 }, -- Wind resist +2-5
                    { 515, 1, 2 }, -- Agility +2-3
                    {  31, 2, 2 }, -- Evasion +3
                    { 180, 0, 2 }, -- Resist Silence +1-3
                },
            },
            {
                cutoff =  433,
                itemId = xi.item.SCORPION_MITTENS,
                augments =
                {
                    { 512, 0,  3 }, -- STR +1-4
                    { 514, 0,  1 }, -- VIT +1-2
                    { 518, 0,  2 }, -- CHR +1-3
                    {  97, 0,  2 }, -- Pet: Attack and Ranged Attack +1-3
                    {   1, 4, 11 }, -- MP +5-12
                    {  26, 0,  3 }, -- Attack -1--4
                },
            },
            {
                cutoff =  552,
                itemId = xi.item.SILK_COAT,
                augments =
                {
                    { 516, 0,  3 }, -- INT +1-4
                    { 517, 0,  2 }, -- CHR +1-3
                    { 518, 0,  3 }, -- MND +1-4
                    {  52, 0,  3 }, -- MP Recovered While Healing +1-4
                    {  13, 1, 12 }, -- MP -2--13
                    { { 36, 0, 2 }, { 35, 0, 0 }, }, -- Magic Accuracy -3 - +1 (split into two augments)
                    { 293, 0,  4 }, -- Dark +1-5
                },
            },
            { cutoff =  597, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
            { cutoff =  612, itemId = xi.item.DARKSTEEL_INGOT },
            { cutoff =  642, itemId = xi.item.GOLD_INGOT },
            { cutoff =  776, itemId = xi.item.HI_ELIXIR },
            { cutoff =  821, itemId = xi.item.HI_ETHER_P1 },
            { cutoff =  851, itemId = xi.item.HI_POTION_P1 },
            { cutoff =  866, itemId = xi.item.MAHOGANY_LOG },
            { cutoff =  881, itemId = xi.item.MYTHRIL_INGOT },
            { cutoff =  896, itemId = xi.item.PAINITE },
            { cutoff = 1000, itemId = xi.item.STEEL_INGOT },
            { cutoff = 1015, itemId = xi.item.ZIRCON },
        },
    },
    [xi.ki.RED_CORAL_KEY] =
    {
        expansion = xi.mission.log_id.AMK,
        mission = xi.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS,
        repeatable = true,
        prizes =
        {
            {
                cutoff =  109,
                itemId = xi.item.ALLOY_TORQUE,
                augments =
                {
                    {  51, 0, 1 }, -- HP Recovered while Healing +1-2
                    {  35, 0, 2 }, -- Magic Accuracy +1-3
                    { 298, 0, 4 }, -- Wind Instrument Skill +1-5
                    { 291, 0, 4 }, -- Enfeebling Magic Skill +1-5
                    { 292, 0, 4 }, -- Elemental Magic Skill +1-5
                },
            },
            {
                cutoff =  200,
                itemId = xi.item.AUREATE_NECKLACE,
                augments =
                {
                    { 768, 2, 3 }, -- Fire resist +3-4
                    { 512, 0, 1 }, -- STR +1-2
                    { 513, 0, 4 }, -- DEX +1-5
                    { 142, 0, 2 }, -- Store TP +1-3
                    { 102, 0, 2 }, -- Pet: Critical Hit Rate +1-3
                    {  24, 0, 3 }, -- Accuracy -1--4
                },
            },
            {
                cutoff =  273,
                itemId = xi.item.BURLY_GORGET,
                augments =
                {
                    { 516, 0, 2 }, -- INT +1-3
                    { 517, 0, 2 }, -- CHR +1-3
                    { 518, 0, 2 }, -- MND +1-3
                    {  40, 0, 0 }, -- Enmity -1
                    {  53, 0, 3 }, -- Spell Interruption Rate down 1-4%
                    {  36, 1, 1 }, -- Magic Accuracy -2
                },
            },
            {
                cutoff =  382,
                itemId = xi.item.NITID_CHOKER,
                augments =
                {
                    {   5, 0, 8 }, -- HP -1-9
                    { 513, 0, 1 }, -- DEX +1-2
                    {  23, 0, 7 }, -- Accuracy +1-8
                    {  25, 0, 3 }, -- Attack +1-4
                    {  96, 0, 3 }, -- Pet: Accuracy and Ranged Accuracy +1-4
                    { 772, 0, 2 }, -- Lightning resist +1-3
                },
            },
            {
                cutoff =  473,
                itemId = xi.item.PNEUMA_COLLAR,
                augments =
                {
                    {  34, 2, 2 }, -- Defense -3
                    { 512, 0, 1 }, -- STR +1-2
                    {  27, 0, 1 }, -- Ranged Accuracy +1-2
                    {  29, 0, 6 }, -- Ranged Attack +1-7
                    { 185, 0, 1 }, -- Resist Gravity +1-2
                    {  98, 0, 2 }, -- Pet: Evasion +1-3
                },
            },
            { cutoff =  528, itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD },
            { cutoff =  619, itemId = xi.item.SPOOL_OF_GOLD_THREAD },
            { cutoff =  692, itemId = xi.item.SLAB_OF_GRANITE },
            { cutoff =  728, itemId = xi.item.HI_ETHER_P2 },
            { cutoff =  764, itemId = xi.item.SPOOL_OF_MALBORO_FIBER },
            { cutoff =  782, itemId = xi.item.PHILOSOPHERS_STONE },
            { cutoff =  800, itemId = xi.item.PHOENIX_FEATHER },
            { cutoff =  836, itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH },
            { cutoff =  872, itemId = xi.item.SQUARE_OF_RAXA },
            { cutoff =  999, itemId = xi.item.VILE_ELIXIR },
            { cutoff = 1017, itemId = xi.item.SERVING_OF_YELLOW_CURRY },
        },
    },
    [xi.ki.ANGEL_SKIN_KEY] =
    {
        expansion = xi.mission.log_id.AMK,
        mission = xi.mission.id.amk.SMASH_A_MALEVOLENT_MENACE,
        repeatable = true,
        prizes =
        {
            {
                cutoff =   65,
                itemId = xi.item.ALTIUS_MANTLE,
                augments =
                {
                    { 782, 0, 19 }, -- Light resist -1--20
                    { 180, 0,  1 }, -- Resist Silence +1-2
                    { 101, 0,  1 }, -- Pet: Magic Attack Bonus +1-2
                    { 518, 0,  3 }, -- CHR +1-4
                    { 320, 0,  1 }, -- Blood Pact Ability Delay -1--2
                    {   5, 0,  4 }, -- HP -1-5
                },
            },
            {
                cutoff =  162,
                itemId = xi.item.CHIFFON_CAPE,
                augments =
                {
                    {   1, 17, 29 }, -- HP +18-30
                    {   9, 16, 28 }, -- MP +17-29
                    {  54,  1,  2 }, -- Physical Damage Taken -2--3%
                    {  50,  0,  0 }, -- Slow +1
                    {  51,  0,  1 }, -- HP Recovered While Healing +1-2
                    { 777, 14, 22 }, -- Ice resist -15--23
                },
            },
            {
                cutoff =  243,
                itemId = xi.item.CORTEGE_CAPE,
                augments =
                {
                    {  52, 0, 1 }, -- MP Recovered While Healing +1-2
                    { 178, 0, 2 }, -- Resist Paralyze +1-3
                    { 517, 0, 3 }, -- MND +1-4
                    {  53, 0, 3 }, -- Spell Interruption Rate Down 1-4%
                    {  36, 1, 1 }, -- Magic Accuracy -2
                    { 292, 0, 3 }, -- Elemental Magic Skill +1-4
                },
            },
            {
                cutoff =  356,
                itemId = xi.item.RESILIENT_MANTLE,
                augments =
                {
                    {  23, 0,  2 }, -- Accuracy +1-3 (from item page, assumed typo in key item page since not colored red)
                    {  25, 0, 17 }, -- Attack +1-18
                    { 512, 0,  2 }, -- STR +1-3
                    { 195, 0,  2 }, -- Subtle Blow +1-3
                    {  32, 0,  2 }, -- Evasion -1-3
                },
            },
            {
                cutoff =  437,
                itemId = xi.item.RUGGED_MANTLE,
                augments =
                {
                    {  13, 1, 3 }, -- MP -2-4
                    { 141, 0, 2 }, -- Conserve MP +1-3
                    {  40, 0, 1 }, -- Enmity -1-2
                    { 516, 0, 3 }, -- INT +1-4
                    { 107, 0, 2 }, -- Pet:Attack and Ranged Attack +1-3
                    { 323, 0, 3 }, -- Cure casting time -1--4%
                },
            },
            { cutoff =  469, itemId = xi.item.CHUNK_OF_ADAMAN_ORE },
            { cutoff =  501, itemId = xi.item.ANGELSTONE },
            { cutoff =  517, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
            { cutoff =  582, itemId = xi.item.DEATHSTONE },
            { cutoff =  614, itemId = xi.item.DIAMOND },
            { cutoff =  646, itemId = xi.item.EMERALD },
            { cutoff =  662, itemId = xi.item.HI_ETHER_P3 },
            { cutoff =  694, itemId = xi.item.HI_POTION_P3 },
            { cutoff =  742, itemId = xi.item.CHUNK_OF_ORICHALCUM_ORE },
            { cutoff =  790, itemId = xi.item.RUBY },
            { cutoff =  822, itemId = xi.item.SCROLL_OF_CURE_V },
            { cutoff =  855, itemId = xi.item.SCROLL_OF_SHELL_IV },
            { cutoff =  888, itemId = xi.item.SPINEL },
            { cutoff = 1021, itemId = xi.item.VILE_ELIXIR },
            { cutoff = 1037, itemId = xi.item.SCROLL_OF_THUNDER_III },
            { cutoff = 1047, itemId = xi.item.SCROLL_OF_RAISE_III },
        },
    },
    [xi.ki.OXBLOOD_KEY] =
    {
        expansion = xi.mission.log_id.AMK,
        mission = xi.mission.id.amk.SMASH_A_MALEVOLENT_MENACE,
        repeatable = false,
    },
    [xi.ki.MOOGLE_KEY] =
    {
        expansion = xi.mission.log_id.ASA,
        mission = xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD,
        repeatable = true,
        prizes =
        {
            {
                cutoff =  167,
                itemId = xi.item.STUDDED_BANDANA,
                augments =
                {
                    {  23, 0, 0 }, -- Accuracy+1
                    { 769, 0, 1 }, -- Ice+2
                }
            },
            {
                cutoff =  374,
                itemId = xi.item.CHAIN_BELT,
                augments =
                {
                    { 770, 0, 0 }, -- Wind+1
                    { 514, 0, 0 }, -- VIT+1
                    {   9, 0, 3 }, -- MP+4
                }
            },
            {
                cutoff =  707,
                itemId = xi.item.CHAIN_CHOKER,
                augments =
                {
                    {   9, 0, 11 }, -- MP+12
                    { 775, 0,  2 }, -- Dark+3
                    {  40, 0,  0 }, -- Enmity-1
                    {  53, 0,  0 }, -- Spell Interruption Rate-1%
                }
            },
            { cutoff =  874, itemId = xi.item.SCROLL_OF_ERASE },
            { cutoff = 1041, itemId = xi.item.MYTHRIL_INGOT },
            { cutoff = 1100, itemId = xi.item.SILVER_INGOT },
        }
    },
    [xi.ki.BIRD_KEY] =
    {
        expansion = xi.mission.log_id.ASA,
        mission = xi.mission.id.asa.SUGAR_COATED_DIRECTIVE,
        repeatable = true,
        prizes =
        {
            {
                cutoff = 143,
                itemId = xi.item.EBONY_SABOTS,
                augments =
                {
                    { 774, 0, 2 }, -- Light+0-3
                    {  39, 0, 3 }, -- Enmity+0-3
                    {  53, 0, 2 }, -- Spell Interruption Rate-0-3%
                    {  35, 0, 0 }, -- Magic Accuracy+0-1
                    {   9, 0, 5 }, -- MP+0-6
                    { 518, 0, 0 }, -- CHR+0-1
                }
            },
            {
                cutoff = 393,
                itemId = xi.item.IRON_SCALE_MAIL,
                augments =
                {
                    {   1, 0, 9 }, -- HP+0-10
                    {  51, 0, 2 }, -- HP Recovered While Healing+0-3
                    { 512, 0, 1 }, -- STR+0-2
                    { 520, 0, 3 }, -- DEX-0-4
                    {  25, 0, 5 }, -- Attack+0-6
                    {  97, 0, 2 }, -- Pet: Attack and Ranged Attack+0-3
                }
            },
            {
                cutoff = 536,
                itemId = xi.item.OAK_SHIELD,
                augments =
                {
                    { 768, 0, 3 }, -- Fire+0-4
                    {  35, 0, 0 }, -- Magic Accuracy+0-1
                    { 329, 0, 0 }, -- Cure potency+0-1%
                    {   9, 0, 3 }, -- MP+0-4
                    {  96, 0, 2 }, -- Pet: Accuracy and Ranged Accuracy+0-3
                    { 521, 0, 0 }, -- VIT-0-1
                }
            },
            {
                cutoff = 653,
                itemId = xi.item.WAISTBELT,
                augments =
                {
                    { 188, 0, 1 }, -- Resist Charm+0-2
                    { 185, 0, 0 }, -- Resist Gravity+0-1
                    { 512, 0, 0 }, -- STR+0-1
                    {  25, 0, 3 }, -- Attack+1-4
                    {  32, 0, 5 }, -- Evasion-0-6
                }
            },
            { cutoff = 663, itemId = xi.item.BLACK_PEARL },
            { cutoff = 678, itemId = xi.item.BLUE_ROCK },
            { cutoff = 770, itemId = xi.item.ELIXIR },
            { cutoff = 801, itemId = xi.item.ETHER_P1 },
            { cutoff = 816, itemId = xi.item.GOSHENITE },
            { cutoff = 847, itemId = xi.item.OAK_LOG },
            { cutoff = 852, itemId = xi.item.PEARL },
            { cutoff = 862, itemId = xi.item.PERIDOT },
            { cutoff = 871, itemId = xi.item.POTION_P1 },
            { cutoff = 922, itemId = xi.item.ROSEWOOD_LOG },
            { cutoff = 927, itemId = xi.item.SPHENE },
            { cutoff = 947, itemId = xi.item.TRANSLUCENT_ROCK },
            { cutoff = 957, itemId = xi.item.WHITE_ROCK },
            { cutoff = 967, itemId = xi.item.YELLOW_ROCK },
            { cutoff = 972, itemId = xi.item.PURPLE_ROCK },
        }
    },
    [xi.ki.CACTUAR_KEY] =
    {
        expansion = xi.mission.log_id.ASA,
        mission = xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_II,
        repeatable = true,
        prizes =
        {
            {
                cutoff = 109,
                itemId = xi.item.NODOWA,
                augments =
                {
                    { 512, 0, 1 }, -- STR+1-2
                    { 513, 0, 1 }, -- DEX+1-2
                    {  50, 0, 3 }, -- Slow+4
                    {   1, 0, 4 }, -- HP+1-5
                    { 115, 0, 1 }, -- Store TP+1-2
                    { 773, 1, 1 }, -- Water+2
                }
            },
            {
                cutoff = 196,
                itemId = xi.item.SILK_COAT,
                augments =
                {
                    { 516, 0, 3 }, -- INT+1-4
                    { 517, 0, 3 }, -- MND+1-4
                    { 518, 0, 3 }, -- CHR+1-4
                    { 137, 0, 0 }, -- Regen+1
                    { 179, 0, 1 }, -- Resist Blind+1-2
                    {  36, 0, 2 }, -- Magic Accuracy-1--3
                }
            },
            {
                cutoff = 305,
                itemId = xi.item.TURTLE_BANGLES,
                augments =
                {
                    { 518, 0, 1 }, -- CHR+1-2
                    { 520, 0, 2 }, -- DEX-3
                    {  25, 0, 2 }, -- Attack+1-3
                    {  23, 0, 1 }, -- Accuracy+1-2
                    { 178, 0, 1 }, -- Resist Paralyze+1-2
                    { 187, 0, 0 }, -- Resist Stun+1
                }
            },
            {
                cutoff = 370,
                itemId = xi.item.CARAPACE_MASK,
                augments =
                {
                    { 517, 0, 1 }, -- MND+1-2
                    {   1, 4, 5 }, -- HP+5-6
                    { { 28, 0, 0 }, { 27, 0, 4 }, }, -- Ranged Accuracy-1-+5
                    {  30, 0, 3 }, -- Ranged Attack-4
                    { 770, 0, 4 }, -- Wind+1-5
                }
            },
            { cutoff = 435, itemId = xi.item.HI_ETHER },
            { cutoff = 544, itemId = xi.item.HI_ELIXIR },
            { cutoff = 609, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
            { cutoff = 631, itemId = xi.item.CHUNK_OF_GOLD_ORE },
            { cutoff = 674, itemId = xi.item.SCROLL_OF_REGEN_III },
            { cutoff = 696, itemId = xi.item.SCROLL_OF_RAISE_II },
            { cutoff = 718, itemId = xi.item.CHUNK_OF_PLATINUM_ORE },
            { cutoff = 761, itemId = xi.item.HANDFUL_OF_WYVERN_SCALES },
            { cutoff = 804, itemId = xi.item.EBONY_LOG },
            { cutoff = 847, itemId = xi.item.DEMON_HORN },
            { cutoff = 869, itemId = xi.item.PETRIFIED_LOG },
            { cutoff = 891, itemId = xi.item.MANTICORE_HIDE },
            { cutoff = 913, itemId = xi.item.RAM_HORN },
            { cutoff = 935, itemId = xi.item.RAM_SKIN },
        }
    },
    [xi.ki.BOMB_KEY] =
    {
        expansion = xi.mission.log_id.ASA,
        mission = xi.mission.id.asa.SHANTOTTO_IN_CHAINS,
        repeatable = true,
        prizes =
        {
            {
                cutoff = 308,
                itemId = xi.item.BATTLE_BOOTS,
                augments =
                {
                    {  34, 1,  5 }, -- DEF-6--2
                    {   9, 5, 10 }, -- MP+6-11
                    { 141, 0,  2 }, -- Conserve MP+1-3
                    {  40, 0,  1 }, -- Enmity-1-2
                    { 104, 0,  1 }, -- Pet: Enmity+1-2
                }
            },
            {
                cutoff = 462,
                itemId = xi.item.SILK_SLOPS,
                augments =
                {
                    {   9, 2, 2 }, -- MP+3
                    { 515, 0, 0 }, -- AGI+1
                    { 517, 0, 1 }, -- MND+1-2
                    {  29, 0, 2 }, -- Ranged Attack+3
                    {  98, 0, 0 }, -- Pet: Evasion+1
                }
            },
            {
                cutoff = 616,
                itemId = xi.item.TIGER_MANTLE,
                augments =
                {
                    {   1, 1, 4 }, -- HP+2-5
                    { 515, 0, 0 }, -- AGI+1
                    {  31, 0, 0 }, -- Evasion+1
                    { 769, 1, 1 }, -- Ice resist +2
                    {  55, 0, 0 }, -- Magic Damage Taken-1%
                }
            },
            {
                cutoff = 693,
                itemId = xi.item.BASCINET,
                augments =
                {
                    {  49, 1, 2 }, -- Haste+3
                    {  24, 0, 0 }, -- Accuracy-1
                    { 180, 0, 0 }, -- Resist Silence+1
                    { 100, 0, 0 }, -- Pet: Magic Accuracy+1
                }
            },
            { cutoff = 747, itemId = xi.item.HI_ELIXIR },
            { cutoff = 824, itemId = xi.item.DARKSTEEL_INGOT },
            { cutoff = 901, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
        },
    },
    [xi.ki.CHOCOBO_KEY] =
    {
        expansion = xi.mission.log_id.ASA,
        mission = xi.mission.id.asa.BATTARU_ROYALE,
        repeatable = true,
        prizes =
        {
            {
                cutoff =  190,
                itemId = xi.item.APTUS_EARRING,
                augments =
                {
                    -- assumed magic skill caps are all the same
                    { 133, 0,  1 }, -- Magic Attack Bonus+1-2
                    {  35, 0,  1 }, -- Magic Accuracy+1-2
                    { 141, 0,  2 }, -- Conserve MP+1-3
                    {  53, 0,  4 }, -- Spell Interruption Rate-1-5%
                    { 294, 0,  2 }, -- Summoning Magic Skill+1
                    { 293, 0,  2 }, -- Dark Magic Skill+2
                    { 291, 0,  2 }, -- Enfeebling Magic Skill+1-2
                    { 295, 0,  2 }, -- Ninjutsu Skill+1
                    { 290, 0,  2 }, -- Enhancing Magic Skill+2
                    { 299, 0,  2 }, -- Blue Magic Skill+1-2
                    {  13, 6, 25 }, -- MP-7--26
                    { 296, 0,  2 }, -- Singing Skill+1-2
                    { 298, 0,  2 }, -- Wind Instrument Skill+3
                    { 292, 0,  2 }, -- Elemental Magic Skill+1
                }
            },
            {
                cutoff =  285,
                itemId = xi.item.STEARC_SUBLIGAR,
                augments =
                {
                    {  44, 0, 2 }, -- Subtle Blow+1-3
                    { 188, 0, 3 }, -- Resist Charm+1-4
                    {  51, 0, 0 }, -- HP Recovered While Healing+1
                    {   1, 7, 7 }, -- HP+8
                    { 774, 0, 6 }, -- Light+1-7
                    { 783, 5, 5 }, -- Dark-6
                }
            },
            {
                cutoff =  571,
                itemId = xi.item.VARIUS_TORQUE,
                augments =
                {
                    -- assumed combat skill caps are all the same
                    {  23,  0,  4 }, -- Accuracy+1-5
                    {  25,  0,  4 }, -- Attack+1-5
                    {  27,  0,  3 }, -- Ranged Accuracy+1-4
                    {  29,  0,  3 }, -- Ranged Attack+1-4
                    { 259,  0,  4 }, -- Sword Skill+1
                    { 267,  0,  4 }, -- Club Skill+3
                    { 262,  0,  4 }, -- Great Axe Skill+1
                    { 260,  0,  4 }, -- Great Sword Skill+1
                    { 264,  0,  4 }, -- Polearm Skill+1-5
                    { 266,  0,  4 }, -- Great Katana Skill+1
                    { 282,  0,  4 }, -- Marksmanship Skill+1-3
                    { 281,  0,  4 }, -- Archery Skill+1-5
                    { 257,  0,  4 }, -- Hand-to-Hand Skill+1-5
                    {   5, 15, 24 }, -- HP-16-25
                }
            },
            { cutoff =  595, itemId = xi.item.SPOOL_OF_GOLD_THREAD },
            { cutoff =  643, itemId = xi.item.HI_ETHER_P2 },
            { cutoff =  714, itemId = xi.item.HI_POTION_P2 },
            { cutoff =  785, itemId = xi.item.SPOOL_OF_MALBORO_FIBER },
            { cutoff =  856, itemId = xi.item.VIAL_OF_BLACK_BEETLE_BLOOD },
            { cutoff =  927, itemId = xi.item.PHILOSOPHERS_STONE },
            { cutoff =  995, itemId = xi.item.SQUARE_OF_RAINBOW_CLOTH },
            { cutoff = 1043, itemId = xi.item.SQUARE_OF_RAXA },
            { cutoff = 1067, itemId = xi.item.SLAB_OF_GRANITE },
            { cutoff = 1115, itemId = xi.item.VILE_ELIXIR },
            { cutoff = 1186, itemId = xi.item.PHOENIX_FEATHER },
        },
    },
    [xi.ki.TONBERRY_KEY] =
    {
        expansion = xi.mission.log_id.ASA,
        mission = xi.mission.id.asa.PROJECT_SHANTOTTOFICATION,
        repeatable = true,
        prizes =
        {
            {
                cutoff =  291,
                itemId = xi.item.ESPRIT_BELT,
                augments =
                {
                    { 516, 0, 5 }, -- INT+1-6
                    { 517, 0, 4 }, -- MND+1-5
                    { 518, 0, 4 }, -- CHR+1-5
                    {  35, 0, 3 }, -- Magic Accuracy+1-4
                    {  39, 0, 2 }, -- Enmity+0-3
                    {  53, 0, 2 }, -- Spell Interruption Rate-1-3%
                }
            },
            {
                cutoff =  600,
                itemId = xi.item.FETTLE_BELT,
                augments =
                {
                    {  49, 0, 4 }, -- Haste+1-5
                    { 512, 0, 2 }, -- STR+1-3
                    { 513, 0, 2 }, -- DEX+1-3
                    { 195, 0, 4 }, -- Subtle Blow+1-5
                    {  31, 0, 4 }, -- Evasion+1-5
                    {  24, 0, 9 }, -- Accuracy-10--1
                }
            },
            { cutoff =  636, itemId = xi.item.ANGELSTONE },
            { cutoff =  654, itemId = xi.item.DEATHSTONE },
            { cutoff =  690, itemId = xi.item.CHUNK_OF_DARKSTEEL_ORE },
            { cutoff =  708, itemId = xi.item.DIAMOND },
            { cutoff =  744, itemId = xi.item.EMERALD },
            { cutoff =  780, itemId = xi.item.SPOOL_OF_GOLD_THREAD },
            { cutoff =  798, itemId = xi.item.HI_POTION_P3 },
            { cutoff =  816, itemId = xi.item.CHUNK_OF_PLATINUM_ORE },
            { cutoff =  834, itemId = xi.item.CHUNK_OF_ORICHALCUM_ORE },
            { cutoff =  870, itemId = xi.item.RUBY },
            { cutoff =  883, itemId = xi.item.SAPPHIRE },
            { cutoff =  901, itemId = xi.item.SCROLL_OF_CURE_V },
            { cutoff =  919, itemId = xi.item.SCROLL_OF_RAISE_III },
            { cutoff =  937, itemId = xi.item.SCROLL_OF_THUNDER_III },
            { cutoff =  955, itemId = xi.item.SPINEL },
            { cutoff =  973, itemId = xi.item.TOPAZ },
            { cutoff = 1082, itemId = xi.item.VILE_ELIXIR },
        },
    },
    [xi.ki.BEHEMOTH_KEY] =
    {
        expansion = xi.mission.log_id.ASA,
        mission = xi.mission.id.asa.AN_UNEASY_PEACE,
        repeatable = false,
    },
}

local optionToGear =
{
    [1] = { addon = 1, itemId = xi.item.NUEVO_COSELETE },
    [2] = { addon = 1, itemId = xi.item.MIRKE_WARDECORS },
    [3] = { addon = 1, itemId = xi.item.ROYAL_REDINGOTE },
    [4] = { addon = 2, itemId = xi.item.CHAMPIONS_GALEA },
    [5] = { addon = 2, itemId = xi.item.ANWIG_SALADE },
    [6] = { addon = 2, itemId = xi.item.SELENIAN_CAP },
    [7] = { addon = 3, itemId = xi.item.BLITZER_POLEYN },
    [8] = { addon = 3, itemId = xi.item.DESULTOR_TASSETS },
    [9] = { addon = 3, itemId = xi.item.TATSUMAKI_SITAGOROMO },
}

local optionToAugment =
{
    [1] = -- ACP
    {
        { { augment =  23, power =  9 } }, -- Accuracy+10
        { { augment =  25, power =  9 } }, -- Attack+10
        { { augment =  27, power =  9 } }, -- Ranged Accuracy+10
        { { augment =  29, power =  9 } }, -- Ranged Attack+10
        { { augment =  31, power =  9 } }, -- Evasion+10
        { { augment =  35, power =  3 } }, -- Magic Accuracy+4
        { { augment = 133, power =  3 } }, -- "Magic Atk, Bonus"+4
        { { augment = 143, power =  1 } }, -- "Double Attack"+2
        { { augment =  41, power =  2 } }, -- Critical hit rate +3
        { { augment =  44, power =  3 } }, -- Store TP"+4 "Subtle Blow"+4
        { { augment =  39, power =  4 } }, -- Enmity+5
        { { augment =  40, power =  4 } }, -- Enmity-5
        { { augment = 140, power =  4 } }, -- Enhances "Fast Cast" effect +5
        { { augment = 324, power = 14 } }, -- "Call Beast" ability delay -15
        { { augment = 211, power =  4 } }, -- "Snapshot"+5
        { { augment = 146, power =  2 } }, -- Enhances "Dual Wield" effect +3
        { { augment = 320, power =  3 } }, -- "Blood Pact" ability delay -4
        { { augment = 321, power =  1 } }, -- Avatar perpetuation cost -2
        { { augment = 325, power =  4 } }, -- Quick Draw" ability delay -5
        { { augment =  96, power = 14 } }, -- Pet: Accuracy+15 Ranged Accuracy+15
        { { augment =  97, power = 14 } }, -- Pet: Attack+15 Ranged Attack+15
        { { augment = 108, power =  6 } }, -- Pet: Magic Acc.+7 "Magic Atk. Bonus"+7
        { { augment = 109, power =  1 } }, -- Pet: "Double Attack"+2 Crit. hit rate +2
    },
    [2] = -- AMK
    {
        { { augment =  49, power = 2 }, { augment = 211, power =  2 } }, -- Haste+3% Enhances "Snapshot" effect (+3%)
        { { augment = 512, power = 3 }, { augment = 326, power = 14 } }, -- STR+4 Weapon Skill Accuracy +15
        { { augment = 513, power = 3 }, { augment = 328, power =  1 } }, -- DEX+4 Increases Critical Hit Damage (+2%)
        { { augment = 514, power = 3 }, { augment = 286, power =  4 } }, -- VIT+4 Shield Skill +5
        { { augment = 515, power = 3 }, { augment = 327, power =  1 } }, -- AGI+4 Increases weapon skill damage (+2%)
        { { augment = 516, power = 3 }, { augment =  35, power =  1 } }, -- INT+4 Magic Accuracy+2
        { { augment = 517, power = 3 }, { augment = 329, power =  2 } }, -- MND+4 "Cure" potency +3%
        { { augment = 518, power = 3 }, { augment = 331, power =  1 } }, -- CHR+4 "Waltz" ability delay -2
        { { augment =  23, power = 9 }, { augment =  25, power =  4 } }, -- Accuracy+10 Attack+5
        { { augment =  27, power = 9 }, { augment =  29, power =  4 } }, -- Ranged Accuracy+10 Ranged Attack+5
        { { augment =  31, power = 9 }, { augment = 142, power =  3 } }, -- Evasion+10 Store TP +4
        { { augment =  35, power = 2 }, { augment =  52, power =  2 } }, -- Magic Accuracy+3 MP recovered while healing +3
        { { augment = 133, power = 1 }, { augment =  51, power =  2 } }, -- "Magic Attack Bonus"+2 HP recovered while healing +3
        { { augment =  55, power = 1 }, { augment =  39, power =  3 } }, -- Magic damage taken -2% Enmity+4
        { { augment =  57, power = 9 }, { augment =  40, power =  3 } }, -- Magic critical hit rate +10% Enmity-4
        { { augment = 140, power = 2 }, { augment = 320, power =  2 } }, -- Enhances "Fast Cast" effect (+3%) "Blood Pact" ability delay -3
        { { augment = 512, power = 1 }, { augment =  49, power =  1 } }, -- STR+2 Haste +2%
        { { augment = 513, power = 1 }, { augment =  49, power =  1 } }, -- DEX+2 Haste +2%
        { { augment = 514, power = 1 }, { augment =  49, power =  1 } }, -- VIT+2 Haste +2%
        { { augment = 515, power = 1 }, { augment =  49, power =  1 } }, -- AGI+2 Haste +2%
        { { augment = 516, power = 1 }, { augment = 140, power =  1 } }, -- INT+2 Enhances "Fast Cast" effect (+2%)
        { { augment = 517, power = 1 }, { augment = 140, power =  1 } }, -- MND+2 Enhances "Fast Cast" effect (+2%)
        { { augment = 518, power = 1 }, { augment = 140, power =  1 } }, -- CHR+2 Enhances "Fast Cast" effect (+2%)
        { { augment =  23, power = 2 }, { augment = 111, power =  4 } }, -- Accuracy+3 Pet: Haste +5%
        { { augment =  23, power = 2 }, { augment = 102, power =  2 } }, -- Accuracy+3 Pet: Critical Hit Rate +3%
        { { augment =  25, power = 2 }, { augment = 110, power =  0 } }, -- Attack+3 Pet: Adds "Regen" effect
        { { augment =  25, power = 2 }, { augment = 112, power =  9 } }, -- Attack+3 Pet: Damage taken -10%
    },
    [3] = -- ASA
    {
        { { augment =    1, power = 24 }, { augment = 39, power =  3 } }, -- HP+25 Enmity+4
        { { augment =    9, power = 24 }, { augment = 40, power =  3 } }, -- MP+25 Enmity-4
        { { augment =   23, power =  6 } }, -- Attack+7
        { { augment =   25, power =  6 } }, -- Accuracy+7
        { { augment =   27, power =  6 } }, -- Ranged Accuracy+7
        { { augment =   29, power =  6 } }, -- Ranged Attack+7
        { { augment =   31, power =  6 } }, -- Evasion+7
        { { augment =   35, power =  3 } }, -- Magic Accuracy+4
        { { augment =  133, power =  3 } }, -- "Magic Atk. Bonus" +4
        { { augment =   49, power =  2 } }, -- Haste +3%
        { { augment =  143, power =  1 } }, -- "Double Attack" +2%
        { { augment =  328, power =  2 } }, -- Increases Critical Hit Damage +3%
        { { augment =  332, power =  4 } }, -- Skillchain damage +5%
        { { augment =  333, power =  4 } }, -- "Conserve TP"+5
        { { augment =   54, power =  3 } }, -- Physical damage taken -4%
        { { augment =  335, power =  9 } }, -- Magic Critical Hit damage +10%
        { { augment =  334, power =  9 } }, -- Magic Burst damage +10%
        { { augment =  194, power =  4 } }, -- "Kick Attacks" +5
        { { augment =  329, power =  4 } }, -- "Cure" potency +5%
        { { augment =  336, power =  4 } }, -- "Sic" & "Ready" ability delay -5
        { { augment =  337, power =  2 } }, -- Song Recast Delay -3
        { { augment =  338, power =  0 } }, -- "Barrage" +1
        { { augment =  339, power = 19 } }, -- "Elemental Siphon" +20
        { { augment =  340, power =  4 } }, -- "Phantom Roll" ability delay -5
        { { augment =  341, power =  9 } }, -- "Repair" potency +10%
        { { augment =  342, power =  4 } }, -- "Waltz" TP cost -50
        { { augment =   96, power =  6 } }, -- Pet: Accuracy +7 Ranged Accuracy +7
        { { augment =   97, power =  6 } }, -- Pet: Attack +7 Ranged Attack +7
        { { augment =  115, power =  7 }, { augment = 116, power =  7 } }, -- Pet: "Store TP" +8 "Subtle Blow" +8
        { { augment =  100, power =  6 } }, -- Pet: Magic Accuracy +7
        { { augment =  913, power =  2 } }, -- Movement Speed +8%
        { { augment =  195, power =  4 } }, -- "Subtle Blow"+5
    },
}

local function givePrize(player, ki)
    if not player:hasKeyItem(ki) then
        player:showText(player, ID.text.NO_KEY)
    else
        local p = keyitems[ki]
        if p ~= nil then
            p = p.prizes
            -- determine prize
            local prize = nil
            local roll = math.random(1, p[#p].cutoff)
            for i = 1, #p do
                if roll <= p[i].cutoff then
                    prize = p[i]
                    break
                end
            end

            -- determine augments
            local addAug = {}
            if
                prize and
                prize.augments ~= nil
            then
                local pAug = {}
                -- deep copy augments for prize
                for k, v in pairs(prize.augments) do
                    table.insert(pAug, v)
                end

                for i = 1, 4 do
                    -- static 50% chance to get any augment at all each loop
                    if #addAug == 0 or math.random(1, 100) <= 50 then
                        -- since lua arrays start at index 1, set start at 1 to guarantee at least one augment
                        roll = math.random(1, #pAug)
                    else
                        roll = 0
                    end

                    local aug = pAug[roll]
                    if aug ~= nil then
                        if type(aug[1]) ~= 'number' then
                            -- augment is itself a list
                            -- used for stat ranges that go between negative and positive
                            -- but, could also be used for groups of stats like int/mnd/chr to avoid having them all show up?
                            aug = aug[math.random(1, #aug)]
                        end

                        -- if augment chosen, remove from cloned list to preserve chance of remaining augments
                        table.remove(pAug, roll)

                        table.insert(addAug, aug[1])
                        table.insert(addAug, math.random(aug[2], aug[3]))
                    end
                end
            end

            for i = #addAug, 7 do
                table.insert(addAug, 0)
            end

            -- give prize
            if prize then
                if
                    player:getFreeSlotsCount() ~= 0 and
                    player:addItem(prize.itemId, 1, unpack(addAug))
                then
                    player:messageSpecial(ID.text.ITEM_OBTAINED, prize.itemId)
                    player:delKeyItem(ki)
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, prize.itemId)
                end
            end
        end
    end
end

local function scenarioArmor(player, option, giveToPlayer)
    local aug1 = 0
    local aug2 = 0
    local gear = 0
    local addon = 0

    aug2 = bit.band(bit.rshift(option, 16), 31) -- 5 bits for 2nd selected augment
    aug1 = bit.band(bit.rshift(option, 11), 31) -- 5 bits for 1st selected augment
    gear = bit.band(bit.rshift(option, 6), 31)  -- 5 bits for selected gear piece
    addon = optionToGear[gear].addon            -- index of addon scenario the gear belongs to

    local augment1 = optionToAugment[addon][aug1]
    local augment2 = optionToAugment[addon][aug2]

    local addAug = {}
    if giveToPlayer then
        -- Add each augment's ID and power
        for i = 1, #augment1 do
            table.insert(addAug, augment1[i].augment)
            table.insert(addAug, augment1[i].power)
        end

        for i = 1, #augment2 do
            table.insert(addAug, augment2[i].augment)
            table.insert(addAug, augment2[i].power)
        end

        if player:getFreeSlotsCount() == 0 then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, optionToGear[gear].itemId)
        else
            player:addItem(optionToGear[gear].itemId, 1, unpack(addAug))
            player:messageSpecial(ID.text.ITEM_OBTAINED, optionToGear[gear].itemId)
            player:delKeyItem(({ xi.ki.PRISMATIC_KEY, xi.ki.OXBLOOD_KEY, xi.ki.BEHEMOTH_KEY })[addon])
        end
    else
        -- Convert each augment's power and ID to binary (5 bits for power followed by 11 bits for ID)
        for i = 1, #augment1 do
            table.insert(addAug, string.format('%05i%011i', utils.intToBinary(augment1[i].power), utils.intToBinary(augment1[i].augment)))
        end

        for i = 1, #augment2 do
            table.insert(addAug, string.format('%05i%011i', utils.intToBinary(augment2[i].power), utils.intToBinary(augment2[i].augment)))
        end

        for i = #addAug, 5 do
            table.insert(addAug, '0000000000000000')
        end

        -- Each argument concats 2 different augments. For some reason, argument 1 contacts the string below.
        player:updateEvent(tonumber(addAug[1] .. '0000001100000010', 2), tonumber(addAug[2] .. addAug[3], 2), tonumber(addAug[4] .. addAug[5], 2))
    end
end

local argumentKeyItems =
{
    [1] =
    {
        xi.ki.CRIMSON_KEY,
        xi.ki.VIRIDIAN_KEY,
        xi.ki.AMBER_KEY,
        xi.ki.AZURE_KEY,
        xi.ki.IVORY_KEY,
        xi.ki.EBON_KEY,
        xi.ki.PRISMATIC_KEY,
    },

    [2] =
    {
        xi.ki.WHITE_CORAL_KEY,
        xi.ki.BLUE_CORAL_KEY,
        xi.ki.PEACH_CORAL_KEY,
        xi.ki.BLACK_CORAL_KEY,
        xi.ki.RED_CORAL_KEY,
        xi.ki.ANGEL_SKIN_KEY,
        xi.ki.OXBLOOD_KEY,
    },

    [3] =
    {
        xi.ki.MOOGLE_KEY,
        xi.ki.BIRD_KEY,
        xi.ki.CACTUAR_KEY,
        xi.ki.BOMB_KEY,
        xi.ki.CHOCOBO_KEY,
        xi.ki.TONBERRY_KEY,
        xi.ki.BEHEMOTH_KEY,
    },
}

entity.onTrigger = function(player, npc)
    -- determines if server/player is eligible to receive a nexus cape
    local eligibleNexusCape = xi.settings.main.ENABLE_ACP == 1 and
                            xi.settings.main.ENABLE_AMK == 1 and
                            xi.settings.main.ENABLE_ASA == 1 and
                            not player:hasItem(xi.item.NEXUS_CAPE)

    local receivedNexusCape = player:hasCompletedUniqueEvent(xi.uniqueEvent.RECEIVED_NEXUS_CAPE)
    local kiArgs = { 0, 0, 0, 0 }

    -- Reminder that a "true" here removes the option from the player's menu
    for argNum = 1, 3 do
        for bitPos, keyItem in ipairs(argumentKeyItems[argNum]) do
            if not player:hasKeyItem(keyItem) then
                kiArgs[argNum] = utils.mask.setBit(kiArgs[argNum], bitPos, true)
            end
        end
    end

    if xi.settings.main.ENABLE_ACP == 0 or kiArgs[1] == 254 then
        kiArgs[4] = utils.mask.setBit(kiArgs[4], 1, true)
    end

    if xi.settings.main.ENABLE_AMK == 0 or kiArgs[2] == 254 then
        kiArgs[4] = utils.mask.setBit(kiArgs[4], 2, true)
    end

    if xi.settings.main.ENABLE_ASA == 0 or kiArgs[3] == 254 then
        kiArgs[4] = utils.mask.setBit(kiArgs[4], 3, true)
    end

    -- can recieve nexus cape and has never received
    if not (eligibleNexusCape and not receivedNexusCape) then
        kiArgs[4] = utils.mask.setBit(kiArgs[4], 4, true)
    end

    -- can recieve nexus cape and has received previously
    if not (eligibleNexusCape and receivedNexusCape) then
        kiArgs[4] = utils.mask.setBit(kiArgs[4], 5, true)
    end

    player:startEvent(10099, kiArgs[1], kiArgs[2], kiArgs[3], kiArgs[4], 0, 0, 0, 0)
end

entity.onEventUpdate = function(player, csid, option, npc)
    if csid == 10099 then
        if option >= 2048 and option < 16777216 then
            scenarioArmor(player, option, false)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10099 then
        if
            option == 16777216 and
            not player:hasCompletedUniqueEvent(xi.uniqueEvent.RECEIVED_NEXUS_CAPE) and
            npcUtil.giveItem(player, xi.item.NEXUS_CAPE)
        then
            player:setUniqueEvent(xi.uniqueEvent.RECEIVED_NEXUS_CAPE)
        elseif
            option == 33554432 or
            (option == 16777216 and player:hasCompletedUniqueEvent(xi.uniqueEvent.RECEIVED_NEXUS_CAPE))
        then
            player:addUsedItem(xi.item.NEXUS_CAPE)
        elseif option >= 1 and option <= 20 then
            local ki = optionToKI[option]
            if ki ~= nil then
                givePrize(player, ki)
            end
        elseif option >= 2048 and option < 16777216 then
            scenarioArmor(player, option, true)
        end
    end
end

return entity
