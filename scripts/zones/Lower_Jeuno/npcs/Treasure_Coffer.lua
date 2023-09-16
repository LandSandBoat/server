-----------------------------------
-- Area: Lower Jeuno
--  NPC: Treasure Coffer
-- Type: Add-on NPC
-- !pos 41.169 3.899 -51.005 245
-----------------------------------
local ID = zones[xi.zone.LOWER_JEUNO]
-----------------------------------
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
    [xi.ki.CRIMSON_KEY] = {
        expansion = xi.mission.log_id.ACP, mission = xi.mission.id.acp.THE_ECHO_AWAKENS, repeatable = true,
        prizes = {
            {cutoff =   70, itemId = 13206, augments = { -- Gold Obi
                    {516, 0, 1}, -- INT+1-2
                    {517, 0, 1}, -- MND+1-2
                    {518, 0, 1}, -- CHR+1-2
                    {  9, 0, 5}, -- MP+1-6
                    { 32, 0, 1}, -- Evasion-1--2
                    { 96, 0, 1}, -- Pet: Accuracy and Ranged Accuracy+1-2
                }
            },
            {cutoff =   80, itemId = 13445, augments = { -- Gold Ring
                    {  9, 0, 8}, -- MP+0-9
                    {516, 0, 1}, -- INT+0-2
                    {517, 0, 1}, -- MND+0-2
                    {518, 0, 2}, -- CHR+0-3
                    { 39, 0, 1}, -- Enmity+0-2
                    { 35, 0, 2}, -- Magic Accuracy+0-3
                }
            },
            {cutoff =  186, itemId = 13446, augments = { -- Mythril Ring
                    {  1, 0, 15}, -- HP+0-16
                    { 13, 0,  2}, -- MP-0-3
                    { 25, 0,  5}, -- Attack+0-6
                    { 31, 0,  1}, -- Evasion+0-2
                    {195, 0,  1}, -- Subtle Blow+0-2
                    { 35, 0,  1}, -- Magic Accuracy+0-2
                }
            },
            {cutoff =  276, itemId = 13643, augments = { -- Sarcenet Cape
                    {  9, 0, 5}, -- MP+0-6
                    {516, 0, 1}, -- INT+0-2
                    {517, 0, 1}, -- MND+0-2
                    {518, 0, 1}, -- CHR+0-2
                    {100, 0, 1}, -- Pet: Magic Accuracy+0-2
                    { 39, 0, 1}, -- Enmity+0-2
                }
            },
            {cutoff =  351, itemId = 13196, augments = { -- Silver Belt
                    {  1, 0, 5}, -- HP+0-6
                    { 23, 0, 1}, -- Accuracy+0-2
                    { 27, 0, 1}, -- Ranged Accuracy+0-2
                    {515, 0, 1}, -- AGI+0-2
                    {512, 0, 1}, -- STR+0-2
                    {520, 0, 1}, -- DEX-0-2
                }
            },
            {cutoff =  460, itemId = 13571, augments = { -- Wolf Mantle
                    {  1, 0, 5}, -- HP+0-6
                    { 25, 0, 3}, -- Attack+0-4
                    { 29, 0, 3}, -- Ranged Attack+0-4
                    {512, 0, 0}, -- STR+0-1
                    {769, 0, 2}, -- Ice+0-3
                    { 32, 0, 2}, -- Evasion-0-3
                }
            },
            {cutoff =  468, itemId =   694}, -- Chestnut Log
            {cutoff =  471, itemId =   887}, -- Coral Fragment
            {cutoff =  476, itemId =  4903}, -- Dark Spirit Pact
            {cutoff =  479, itemId =   654}, -- Darksteel Ingot
            {cutoff =  500, itemId =   645}, -- Darksteel Ore
            {cutoff =  523, itemId =  4868}, -- Scroll of Dispel
            {cutoff =  619, itemId =  4145}, -- Elixir
            {cutoff =  668, itemId =   690}, -- Elm Log
            {cutoff =  699, itemId =  4751}, -- Scroll of Erase
            {cutoff =  702, itemId =  4116}, -- Hi-Potion
            {cutoff =  723, itemId =   651}, -- Iron Ingot
            {cutoff =  775, itemId =   643}, -- Iron Ore
            {cutoff =  785, itemId =  4902}, -- Light Spirit Pact
            {cutoff =  821, itemId =  5070}, -- Scroll of Magic Finale
            {cutoff =  824, itemId =   691}, -- Maple Log
            {cutoff =  858, itemId =   653}, -- Mythril Ingot
            {cutoff =  879, itemId =   644}, -- Mythril Ore
            {cutoff =  884, itemId =  4113}, -- Potion +1
            {cutoff =  923, itemId =   744}, -- Silver Ingot
            {cutoff =  949, itemId =   736}, -- Silver Ore
            {cutoff =  993, itemId =   652}, -- Steel Ingot
            {cutoff = 1003, itemId =  4947}, -- Scroll of Utsusemi: Ni
        },
    },
    [xi.ki.VIRIDIAN_KEY] = {
        expansion = xi.mission.log_id.ACP, mission = xi.mission.id.acp.GATHERER_OF_LIGHT_I, repeatable = true,
        prizes = {
            {cutoff =   65, itemId = 13639, augments = { -- Aurora Mantle
                    {  9, 0, 19}, -- MP+0-20
                    {  1, 0, 19}, -- HP+0-20
                    { 40, 0,  1}, -- Enmity-0-2
                    {771, 0,  6}, -- Earth+0-7
                    {768, 0,  6}, -- Fire+0-7
                    { 34, 2,  3}, -- DEF-3-4
                }
            },
            {cutoff =  142, itemId = 13271, augments = { -- Corsette
                    { 23, 0,  2}, -- Accuracy+0-3
                    { 31, 0,  1}, -- Evasion+0-2
                    {  9, 0, 13}, -- MP+0-14
                    { 26, 0,  1}, -- Attack-0-2
                    {  1, 0, 12}, -- HP+0-13
                    { 49, 0,  2}, -- Haste+0-3
                }
            },
            {cutoff =  237, itemId = 12364, augments = { -- Nymph Shield
                    {  9, 0, 9}, -- MP+0-10
                    {517, 0, 0}, -- MND+0-1
                    {516, 0, 0}, -- INT+0-1
                    {512, 0, 0}, -- STR+0-1
                    {518, 0, 0}, -- CHR+0-1
                    { 35, 0, 1}, -- Magic Accuracy+0-2
                }
            },
            {cutoff =  356, itemId = 13570, augments = { -- Ram Mantle
                    {  5, 0,  5}, -- HP-0-6
                    { 13, 0, 10}, -- MP-0-11
                    {515, 0,  0}, -- AGI+0-1
                    {513, 0,  0}, -- DEX+0-1
                    { 23, 0,  3}, -- Accuracy+0-4
                    { 27, 0,  3}, -- Ranged Accuracy+0-4
                }
            },
            {cutoff =  457, itemId = 13198, augments = { -- Swordbelt
                    {  1, 0, 4}, -- HP+0-5
                    {512, 0, 1}, -- STR+0-2
                    {513, 0, 1}, -- DEX+0-2
                    {514, 0, 0}, -- VIT+0-1
                    { 24, 0, 2}, -- Accuracy-0-3
                    { 29, 0, 3}, -- Ranged Attack+0-4
                    { 52, 1, 1},-- MP Recovered While Healing
                }
            },
            {cutoff =  469, itemId =   793}, -- Black Pearl
            {cutoff =  497, itemId =   775}, -- Black Rock
            {cutoff =  515, itemId =   770}, -- Blue Rock
            {cutoff =  616, itemId =  4145}, -- Elixir
            {cutoff =  670, itemId =  4129}, -- Ether +1
            {cutoff =  676, itemId =   790}, -- Garnet
            {cutoff =  672, itemId =   808}, -- Goshenite
            {cutoff =  684, itemId =   772}, -- Green Rock
            {cutoff =  775, itemId =   699}, -- Oak Log
            {cutoff =  811, itemId =   792}, -- Pearl
            {cutoff =  829, itemId =   788}, -- Peridot
            {cutoff =  835, itemId =   738}, -- Platinum Ore
            {cutoff =  871, itemId =  4113}, -- Potion +1
            {cutoff =  877, itemId =   774}, -- Purple Rock
            {cutoff =  901, itemId =   769}, -- Red Rock
            {cutoff =  984, itemId =   701}, -- Rosewood Log
            {cutoff = 1008, itemId =   815}, -- Sphene
            {cutoff = 1020, itemId =   773}, -- Translucent Rock
            {cutoff = 1032, itemId =   776}, -- White Rock
            {cutoff = 1044, itemId =   771}, -- Yellow Rock
            {cutoff = 1056, itemId =   798}, -- Turquoise
        },
    },
    [xi.ki.AMBER_KEY] = {
        expansion = xi.mission.log_id.ACP, mission = xi.mission.id.acp.GATHERER_OF_LIGHT_II, repeatable = true,
        prizes = {
            {cutoff = 111, itemId = 16263, augments = { -- Beak Necklace
                    {  9, 0, 12}, -- MP+0-13
                    { 35, 0,  1}, -- Magic Accuracy+0-2
                    {516, 0,  1}, -- INT+0-2
                    {518, 0,  1}, -- CHR+0-2
                    {517, 0,  1}, -- MND+0-2
                    { 97, 0,  4}, -- Pet: Attack and Ranged Attack+0-5
                    { 39, 0,  1}, -- Enmity+0-2
                }
            },
            {cutoff = 219, itemId = 13207, augments = { -- Brocade Obi
                    {  1, 0, 11}, -- HP+0-12
                    {  9, 0, 11}, -- MP+0-12
                    { 35, 0,  2}, -- Magic Accuracy+0-3
                    {290, 0,  2}, -- Enhancing Magic Skill+0-3
                    { 50, 0,  0}, -- Slow+0-1
                    {100, 0,  2}, -- Pet: Magic Accuracy+0-3
                }
            },
            {cutoff = 334, itemId = 13091, augments = { -- Carapace Gorget
                    {513, 0,  0}, -- DEX+0-1
                    {512, 0,  2}, -- STR+0-3
                    { 25, 0,  6}, -- Attack+0-7
                    { 29, 0,  6}, -- Ranged Attack+0-7
                    {142, 0,  1}, -- Store TP+0-2
                    { 24, 0,  3}, -- Accuracy-0-4
                    {773, 0,  5}, -- Water+0-6
                }
            },
            {cutoff = 436, itemId = 13445, augments = { -- Gold Ring
                    {  9, 0, 13}, -- MP+0-14
                    {516, 0,  1}, -- INT+0-2
                    {517, 0,  1}, -- MND+0-2
                    {518, 0,  1}, -- CHR+0-2
                    { 39, 0,  1}, -- Enmity+0-2
                    { 35, 0,  2}, -- Magic Accuracy+0-3
                }
            },
            {cutoff = 561, itemId = 13593, augments = { -- Raptor Mantle
                    {  1, 0, 29}, -- HP+0-30
                {{520, 0,  1}, {513, 0, 1},}, -- DEX-2-+2 (split into two augments)
                    {515, 0,  2}, -- AGI+0-3
                    {514, 0,  2}, -- VIT+0-3
                    { 39, 0,  1}, -- Enmity+0-2
                    {774, 0,  5}, -- Light resist +0-6
                }
            },
            {cutoff = 564, itemId =   887}, -- Coral Fragment
            {cutoff = 576, itemId =   645}, -- Darksteel Ore
            {cutoff = 599, itemId =   902}, -- Demon Horn
            {cutoff = 616, itemId =   702}, -- Ebony Log
            {cutoff = 625, itemId =   737}, -- Gold Ore
            {cutoff = 683, itemId =  4144}, -- Hi-Elixer
            {cutoff = 730, itemId =  4132}, -- Hi-Ether
            {cutoff = 771, itemId =  4116}, -- Hi-Potion
            {cutoff = 788, itemId =   700}, -- Mahogany Log
            {cutoff = 805, itemId =  1116}, -- Manticore Hide
            {cutoff = 807, itemId =   703}, -- Petrified Log
            {cutoff = 809, itemId =   738}, -- Platinum Ore
            {cutoff = 818, itemId =   644}, -- Mythril Ore
            {cutoff = 835, itemId =   895}, -- Ram Horn
            {cutoff = 876, itemId =   859}, -- Ram Skin
            {cutoff = 885, itemId =  4621}, -- Scroll of Raise II
            {cutoff = 920, itemId =  4719}, -- Scroll of Regen III
            {cutoff = 946, itemId =   866}, -- Wyvern Scales
            {cutoff = 961, itemId =  1122}, -- Wyvern Skin
        },
    },
    [xi.ki.AZURE_KEY] = {
        expansion = xi.mission.log_id.ACP, mission = xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_II, repeatable = true,
        prizes = {
            {cutoff = 106, itemId = 13597, augments = { -- Beak Mantle
                    {512, 0,  1}, -- STR+0-2
                    {513, 0,  1}, -- DEX+0-2
                    { 26, 0,  5}, -- Attack-0-6
                    { 23, 0,  6}, -- Accuracy+0-7
                    { 31, 0,  6}, -- Evasion+0-7
                    {195, 0,  1}, -- Subtle Blow+0-2
                }
            },
            {cutoff = 203, itemId = 13092, augments = { -- Coeurl Gorget
                    {515, 0,  3}, -- AGI+0-4
                    { 23, 0,  7}, -- Accuracy+0-8
                    { 27, 0,  7}, -- Ranged Accuracy+0-8
                    { 30, 0,  3}, -- Ranged Attack-0-4
                    {195, 0,  1}, -- Subtle Blow+0-2
                    {771, 0,  3}, -- Earth+0-4
                }
            },
            {cutoff = 305, itemId = 13447, augments = { -- Platinum Ring
                    {  1, 0,  9}, -- HP+0-10
                    {512, 0,  1}, -- STR+0-2
                    {513, 0,  1}, -- DEX+0-2
                    {514, 0,  1}, -- VIT+0-2
                    { 26, 0,  2}, -- Attack-0-3
                    { 23, 0,  2}, -- Accuracy+0-3
                }
            },
            {cutoff = 386, itemId = 13208, augments = { -- Rainbow Obi
                    {  9, 0, 19}, -- MP+0-20
                    {516, 0,  4}, -- INT+0-5
                    {517, 0,  4}, -- MND+0-5
                    {518, 0,  4}, -- CHR+0-5
                    { 36, 0,  2}, -- Magic Accuracy-0-3
                    { 52, 0,  2}, -- MP Recovered While Healing+1-3
                }
            },
            {cutoff = 490, itemId = 13125, augments = { -- Torque
                    {  5, 0, 13}, -- HP-0-14
                    {  9, 0, 12}, -- MP+0-13
                    {515, 0,  2}, -- AGI+0-3
                    {516, 0,  1}, -- INT+0-2
                    {517, 0,  1}, -- MND+0-2
                    {518, 0,  1}, -- CHR+0-2
                }
            },
            {cutoff = 498, itemId =   791}, -- Aquamarine
            {cutoff = 502, itemId =   801}, -- Chrysoberyl
            {cutoff = 536, itemId =   654}, -- Darksteel Ingot
            {cutoff = 612, itemId =   645}, -- Darksteel Ore
            {cutoff = 659, itemId =   702}, -- Ebony Log
            {cutoff = 693, itemId =   745}, -- Gold Ingot
            {cutoff = 786, itemId =  4144}, -- Hi-Elixir
            {cutoff = 789, itemId =  4133}, -- Hi-Ether +1
            {cutoff = 831, itemId =  4117}, -- Hi-Potion +1
            {cutoff = 835, itemId =   784}, -- Jadeite
            {cutoff = 856, itemId =   700}, -- Mahogany Log
            {cutoff = 907, itemId =   653}, -- Mythril Ingot
            {cutoff = 911, itemId =   895}, -- Ram Horn
            {cutoff = 915, itemId =  4719}, -- Scroll of Regen III
            {cutoff = 948, itemId =   652}, -- Steel Ingot
            {cutoff = 956, itemId =   803}, -- Sunstone
            {cutoff = 960, itemId =   866}, -- Wyvern Scales
        },
    },
    [xi.ki.IVORY_KEY] = {
        expansion = xi.mission.log_id.ACP, mission = xi.mission.id.acp.THOSE_WHO_LURK_IN_SHADOWS_III, repeatable = true,
        prizes = {
            {cutoff =   62, itemId = 13357, augments = { -- Angels Earring
                    {518, 0, 1}, -- CHR+1-2
                    { 40, 0, 1}, -- Enmity-2--1
                    {  1, 0, 9}, -- HP+1-10
                    {  9, 0, 9}, -- MP+1-10
                    {105, 0, 1}, -- Pet: Enmity-2--1
                    {106, 0, 0}, -- Pet: Accuracy and Ranged Accuracy+0-1
                    {34, 0,  3}, -- Def-4--1
                }
            },
            {cutoff =   70, itemId = 13356, augments = { -- Death Earring
                    { 33, 0, 3}, -- Defense+1-4
                    { 39, 0, 1}, -- Enmity+1-2
                    {  1, 0, 9}, -- HP+1-10
                    {  9, 0, 9}, -- MP+1-10
                    {104, 0, 1}, -- Pet: Enmity+1-2
                    {521, 0, 1}, -- VIT-2--1
                }
            },
            {cutoff =  113, itemId = 13353, augments = { -- Diamond Earring
                    {516, 0, 1}, -- INT+1-2
                    {515, 0, 0}, -- AGI+1
                    {133, 0, 1}, -- Magic Attack Bonus+1-2
                    {  9, 0, 5}, -- MP+1-6
                    { 36, 0, 0}, -- Magic Accuracy-1
                    {101, 0, 1}, -- Pet: Magic Attack Bonus+1-2
                }
            },
            {cutoff =  196, itemId = 13351, augments = { -- Emerald Earring
                    {515, 0, 1}, -- AGI+1-2
                    { 31, 0, 4}, -- Evasion+1-5
                    { 98, 0, 4}, -- Pet: Evasion+1-5
                    { 27, 0, 2}, -- Ranged Accuracy+1-3
                    {514, 0, 0}, -- VIT+1
                    { 30, 0, 1}, -- Ranged Attack-2--1
                }
            },
            {cutoff =  301, itemId = 13352, augments = { -- Ruby Earring
                    { 25, 0, 4}, -- Attack+1-5
                    {516, 0, 1}, -- INT+1-2
                    { 97, 0, 4}, -- Pet: Attack and Ranged Attack+1-5
                    { 29, 0, 4}, -- Ranged Attack+1-5
                    {512, 0, 1}, -- STR+1-2
                    { 24, 0, 2}, -- Accuracy-3--1
                }
            },
            {cutoff =  392, itemId = 13355, augments = { -- Sapphire Earring
                    { 35, 0, 1}, -- Magic Accuracy+1-2
                    {517, 0, 1}, -- MND+1-2
                    {  9, 0, 5}, -- MP+1-6
                    {100, 0, 1}, -- Pet: Magic Accuracy+1-2
                    {512, 0, 1}, -- STR+1-2
                    {  5, 0, 6}, -- HP-7--1
                }
            },
            {cutoff =  478, itemId = 13354, augments = { -- Spinel Earring
                    { 23, 0, 2}, -- Accuracy+1-3
                    {513, 0, 1}, -- DEX+1-2
                    {517, 0, 0}, -- MND+1
                    { 96, 0, 2}, -- Pet: Accuracy and Ranged Accuracy+1-3
                    {142, 0, 0}, -- Store TP+1
                    {195, 0, 1}, -- Subtle Blow+1-2
                    { 26, 0, 4}, -- Attack-5--1
                }
            },
            {cutoff =  497, itemId = 13318, augments = { -- Topaz Earring
                    { 33, 0,  4}, -- DEF+1-5
                    {513, 0,  1}, -- DEX+1-2
                    {  1, 0, 19}, -- HP+1-20
                    { 99, 0,  4}, -- PET: DEF+1-5
                    {514, 0,  1}, -- VIT+1-2
                    { 32, 0,  2}, -- Evasion-3--1
                }
            },
            {cutoff =  546, itemId =  1110}, -- Beetle Blood
            {cutoff =  602, itemId =   823}, -- Gold Thread
            {cutoff =  627, itemId =  1465}, -- Granite
            {cutoff =  658, itemId =  4134}, -- Hi-Ether +2
            {cutoff =  901, itemId =  4118}, -- Hi-Potion +2
            {cutoff =  963, itemId =   837}, -- Malboro Fiber
            {cutoff =  982, itemId =   924}, -- Philosophers Stone
            {cutoff = 1019, itemId =   844}, -- Phoenix Feather
            {cutoff = 1062, itemId =   830}, -- Rainbow Cloth
            {cutoff = 1124, itemId =  1132}, -- Raxa
            {cutoff = 1172, itemId =  4174}, -- Vile Elixir
        },
    },
    [xi.ki.EBON_KEY] = {
        expansion = xi.mission.log_id.ACP, mission = xi.mission.id.acp.ODE_OF_LIFE_BESTOWING, repeatable = true,
        prizes = {
            {cutoff =  31, itemId = 13463, augments = { -- Angels Ring:
            -- https://ffxiclopedia.fandom.com/wiki/Ebon_Key?oldid=934097 doesn't list -acc and -def, but this had -dark resist before the restructure
            -- and that seems to fit the theme of the other rewards
                    { 40, 0,  1}, -- Enmity-0-2
                    {  1, 0, 19}, -- HP+0-20
                    {518, 0,  0}, -- CHR+1
                    { 23, 1,  5}, -- Accuracy+2-6
                    { 96, 0,  3}, -- Pet: Accuracy and Ranged Accuracy+1-4
                    {783, 0, 29},-- dark resist -0-30
                }
            },
            {cutoff =  82, itemId = 13462, augments = { -- Death Ring
                    {782, 0, 29}, -- Light-0-30
                    {525, 0,  2}, -- CHR-0-3
                    {  9, 0, 19}, -- MP+0-20
                    { 33, 0,  6}, -- Defense+0-7
                    { 31, 0,  4}, -- Evasion+0-5
                    { 39, 0,  0}, -- Enmity+1
                }
            },
            {cutoff = 174, itemId = 13450, augments = { -- Diamond Ring
                    {776, 0, 29}, -- Fire-0-30
                    {519, 0,  4}, -- STR-0-5
                    {  9, 0,  9}, -- MP+0-10
                    {515, 0,  2}, -- AGI+0-3
                    {516, 0,  0}, -- INT+1
                    {517, 0,  1}, -- MND+0-2
                }
            },
            {cutoff = 225, itemId = 13448, augments = { -- Emerald Ring
                    {777, 0, 29}, -- ice -0-30 (wiki is conflicting, might be water?)
                    {523, 0,  4}, -- INT-0-5
                    {  1, 0,  8}, -- HP+0-9
                    {512, 0,  1}, -- STR+0-2
                    {514, 0,  2}, -- VIT+0-3
                    {515, 0,  0}, -- AGI+1
                }
            },
            {cutoff = 296, itemId = 13449, augments = { -- Ruby Ring
                    {781, 0, 29}, -- Water-0-30
                    {524, 0,  1}, -- MND-0-2
                    {  1, 0,  9}, -- HP+0-10
                    {512, 0,  0}, -- STR+1
                    {513, 0,  1}, -- DEX+0-2
                    {516, 0,  2}, -- INT+0-3
                }
            },
            {cutoff = 357, itemId = 13452, augments = { -- Sapphire Ring
                    {780, 0, 29}, -- Lightning-0-30
                    {  9, 0,  9}, -- MP+0-10
                {{519, 0,  0}, {512, 0, 2},}, -- STR-1-+3 (split into two augments)
                    {520, 0,  3}, -- DEX-1-4
                    {517, 0,  0}, -- MND+1
                    {518, 0,  2}, -- CHR+0-3
                }
            },
            {cutoff = 459, itemId = 13451, augments = { -- Spinel Ring
                    {779, 0, 29}, -- Earth-0-30
                    {  1, 0,  9}, -- HP+0-10
                    {513, 0,  0}, -- DEX+1
                    {521, 0,  0}, -- VIT-0-1
                    {515, 0,  1}, -- AGI+0-2
                    {517, 0,  2}, -- MND+0-3
                    { 23, 0,  0}, -- Accuracy+1
                    {195, 0,  1}, -- Subtle Blow+0-2
                    { 96, 0,  1}, -- Pet: Accuracy and Ranged Accuracy+0-2
                }
            },
            {cutoff = 500, itemId = 13453, augments = { -- Topaz Ring
                    {778, 0, 29}, -- Wind-0-30
                    {522, 0, 5}, -- AGI-0-6
                    {771, 0, 8}, -- Earth+0-9
                    {  1, 0, 9}, -- HP+0-10
                    {513, 0, 1}, -- DEX+0-2
                    {514, 0, 0}, -- VIT+1
                    {516, 0, 2}, -- INT+0-3
                }
            },
            {cutoff = 510, itemId =   655}, -- Adaman Ingot
            {cutoff = 541, itemId =   813}, -- Angelstone
            {cutoff = 561, itemId =   645}, -- Darksteel Ore
            {cutoff = 592, itemId =   812}, -- Deathstone
            {cutoff = 633, itemId =   787}, -- Diamond
            {cutoff = 643, itemId =   785}, -- Emerald
            {cutoff = 714, itemId =  4135}, -- Hi-Ether +3
            {cutoff = 785, itemId =  4119}, -- Hi-Potion +3
            {cutoff = 805, itemId =   739}, -- Orichalcum Ore
            {cutoff = 815, itemId =   738}, -- Platinum Ore
            {cutoff = 835, itemId =   786}, -- Ruby
            {cutoff = 855, itemId =   794}, -- Sapphire
            {cutoff = 896, itemId =  4613}, -- Scroll of Cure V
            {cutoff = 916, itemId =  4659}, -- Scroll of Shell IV
            {cutoff = 936, itemId =  4774}, -- Scroll of Thunder III
            {cutoff = 987, itemId =  4174}, -- Vile Elixir
            {cutoff = 997, itemId =  4748}, -- Scroll of Raise III
        },
    },
    [xi.ki.PRISMATIC_KEY] = {
        expansion = xi.mission.log_id.ACP, mission = xi.mission.id.acp.ODE_OF_LIFE_BESTOWING, repeatable = false,
    },
    [xi.ki.WHITE_CORAL_KEY] = {
        expansion = xi.mission.log_id.AMK, mission = xi.mission.id.amk.DRENCHED_IT_BEGAN_WITH_A_RAINDROP, repeatable = true,
        prizes = {
            {cutoff =   31, itemId = 12433, augments = { -- Brass Mask
                    {  1, 0, 1}, -- HP +1-2
                    {  9, 0, 2}, -- MP +1-3
                    {514, 0, 0}, -- VIT +1
                    { 24, 0, 2}, -- Accuracy -1-3
                    {142, 0, 0}, -- Store TP +1
                    {177, 0, 0}, -- Resist Poison +1
                },
            },
            {cutoff =  109, itemId = 12986, augments = { -- Chestnut Sabots
                    { 13, 5, 5}, -- MP -6
                    {517, 0, 1}, -- MND +1-2
                    {100, 1, 1}, -- Pet: Magic Accuracy +2
                    { 40, 1, 1}, -- Enmity -2
                    {773, 1, 2}, -- Water Resist +2-3
                    { 53, 2, 2}, -- Spell Interruption Rate down 3%
                },
            },
            {cutoff =  218, itemId = 12721, augments = { -- Cotton Gloves
                    { 23, 0, 1}, -- Accuracy +1-2
                    {768, 0, 1}, -- Fire resist +1-2
                    {769, 0, 0}, -- Ice resist +1
                    {513, 0, 0}, -- DEX +1
                    {515, 0, 0}, -- AGI +1
                },
            },
            {cutoff =  296, itemId = 12826, augments = { -- Studded Trousers
                    { 29, 0, 1}, -- Ranged Attack +1-2
                    { 25, 0, 2}, -- Attack +1-3
                    {195, 1, 1}, -- Subtle Blow +2
                    { 99, 0, 1}, -- Pet: Defense +1-2
                    {179, 0, 3}, -- Resist Blind +1-4
                },
            },
            {cutoff =  437, itemId = 12602, augments = { -- Wool Robe
                    {771, 0, 4}, -- Earth resist +1-5
                    {515, 0, 1}, -- AGI +1-2
                    { 29, 0, 0}, -- Ranged Attack +1
                    { 27, 0, 3}, -- Ranged Accuracy +1-4
                    { 40, 0, 0}, -- Enmity -1
                    {519, 0, 1}, -- STR -1-2
                },
            },
            {cutoff =  468, itemId =   694}, -- Chestnut Log
            {cutoff =  499, itemId =   645}, -- Darksteel Ore
            {cutoff =  624, itemId =  4145}, -- Elixir
            {cutoff =  655, itemId =   690}, -- Elm Log
            {cutoff =  686, itemId =   643}, -- Iron Ore
            {cutoff =  717, itemId =   651}, -- Iron Ingot
            {cutoff =  764, itemId =   653}, -- Mythril Ingot
            {cutoff =  780, itemId =   644}, -- Mythril Ore
            {cutoff =  843, itemId =   744}, -- Silver Ingot
            {cutoff =  874, itemId =   736}, -- Silver Ore
            {cutoff =  937, itemId =   652}, -- Steel Ingot
            {cutoff =  968, itemId =  4868}, -- Scroll of Dispel
            {cutoff =  999, itemId =  5070}, -- Scroll of Magic Finale
            {cutoff = 1015, itemId =  4947}, -- Scroll of Utsusemi: Ni
            {cutoff = 1031, itemId =  4751}, -- Scroll of Erase
        },
    },
    [xi.ki.BLUE_CORAL_KEY] = {
        expansion = xi.mission.log_id.AMK, mission = xi.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE, repeatable = true,
        prizes = {
            {cutoff =   42, itemId = 12571, augments = { -- Cuir Bouilli
                    {  1, 3, 3}, -- HP+4
                    {291, 1, 1}, -- Enfeebling Magic+2
                    { 52, 1, 1}, -- MP Recovered While Healing+2
                    {187, 0, 2}, -- Resist Stun+1-3
                    {322, 0, 0}, -- Song Spellcasting Time-1%
                    { 39, 0, 0}, -- Enmity+1
                },
            },
            {cutoff =  250, itemId = 14118, augments = { -- Iron Greaves
                    {  1, 1, 1}, -- HP +2
                    {512, 0, 0}, -- STR +1
                    {518, 0, 1}, -- CHR +1-2
                    {133, 0, 1}, -- Magic Attack Bonus +1-2
                    {774, 0, 5}, -- Light resist +1-6
                },
            },
            {cutoff =  292, itemId = 12866, augments = { -- Linen Slacks
                    {  9, 6, 6}, -- MP +7
                    {524, 1, 1}, -- MND -2
                    {141, 1, 1}, -- Conserve MP +2
                    { 53, 0, 3}, -- Spell Interruption Rate -1-4%
                    { 35, 0, 1}, -- Magic Accuracy +1-2
                },
            },
            {cutoff =  375, itemId = 12450, augments = { -- Padded Cap
                    {513, 1, 1}, -- DEX +2
                    {515, 0, 0}, -- AGI +1
                    { 25, 0, 1}, -- Attack +1-2
                    {772, 0, 0}, -- Lightning resist +1
                },
            },
            {cutoff =  458, itemId = 12731, augments = { -- Velvet Cuffs
                    {  5, 0, 0}, -- HP -1
                    { 96, 0, 0}, -- Pet: Accuracy +1 Ranged Accuracy +1
                    {176, 0, 1}, -- Resist Sleep +1-2
                    { 31, 2, 2}, -- Evasion +3
                },
            },
            {cutoff =  500, itemId =   793}, -- Black Pearl
            {cutoff =  583, itemId =  4145}, -- Elixir
            {cutoff =  625, itemId =  4129}, -- Ether +1
            {cutoff =  667, itemId =   790}, -- Garnet
            {cutoff =  709, itemId =   788}, -- Peridot
            {cutoff =  751, itemId =  4113}, -- Potion +1
            {cutoff =  876, itemId =   699}, -- Oak Log
            {cutoff =  918, itemId =   830}, -- Rainbow Cloth
            {cutoff =  960, itemId =   769}, -- Red Rock
            {cutoff = 1002, itemId =   798}, -- Turquoise
        },
    },
    [xi.ki.PEACH_CORAL_KEY] = {
        expansion = xi.mission.log_id.AMK, mission = xi.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE, repeatable = true,
        prizes = {
            {cutoff =   66, itemId = 13712, augments = { -- Carapace Harness
                    { 23, 0, 5}, -- Accuracy +1-6
                    { 25, 0, 3}, -- Attack +1-4
                    { 31, 0, 5}, -- Evasion +1-6
                    {195, 0, 3}, -- Subtle Blow +1-4
                    {178, 0, 2}, -- Resist Paralyze +1-3
                    { 50, 0, 1}, -- Slow +1-2
                },
            },
            {cutoff =  198, itemId = 12956, augments = { -- Raptor Ledelsens
                    {  1, 0,  5}, -- HP +1-6
                    {  9, 3, 11}, -- MP +4-12
                    {514, 0,  2}, -- VIT +1-3
                    { 99, 0,  3}, -- Pet: DEF +1-4
                    { 36, 0,  1}, -- Magic Accuracy -1-2
                },
            },
            {cutoff =  303, itemId = 12476, augments = { -- Silk Hat
                    { 13, 1, 1}, -- MP-2
                    {289, 0, 2}, -- Healing Magic Skill +1-3
                    {291, 0, 2}, -- Enfeebling Magic Skill +1-3
                    {100, 0, 1}, -- Pet: Magic Accuracy +1-2
                    {293, 0, 2}, -- Dark Magic Skill +1-3
                },
            },
            {cutoff =  395, itemId = 14003, augments = { -- Steel Finger Gauntlets
                    { 68, 0, 2}, -- Accuracy +1-3 Attack +1-3
                    { 49, 0, 0}, -- Haste +1
                    {186, 0, 2}, -- Resist Slow +1-3
                    {770, 0, 2}, -- Wind resist +1-3
                },
            },
            {cutoff =  487, itemId = 12867, augments = { -- White Slacks
                    {516, 0, 3}, -- INT+1-4
                    {517, 0, 3},-- MND+1-4
                    {518, 0, 3},-- CHR+1-4
                    {320, 0, 2}, -- Blood Pact Ability Delay -1-3
                    { 53, 0, 3}, -- Spell Interruption Rate down 1-4%
                    { 39, 0, 2}, -- Enmity +1-3
                },
            },
            {cutoff =  500, itemId =   645}, -- Darksteel Ore
            {cutoff =  526, itemId =   902}, -- Demon Horn
            {cutoff =  565, itemId =   702}, -- Ebony Log
            {cutoff =  591, itemId =   737}, -- Gold Ore
            {cutoff =  696, itemId =  4144}, -- Hi-Elixer
            {cutoff =  747, itemId =  4132}, -- Hi-Ether
            {cutoff =  773, itemId =  4116}, -- Hi-Potion
            {cutoff =  786, itemId =   700}, -- Mahogany Log
            {cutoff =  839, itemId =  1116}, -- Manticore Hide
            {cutoff =  852, itemId =   644}, -- Mythril Ore
            {cutoff =  891, itemId =   703}, -- Petrified Log
            {cutoff =  930, itemId =  4621}, -- Scroll of Raise II
            {cutoff =  969, itemId =   738}, -- Platinum Ore
            {cutoff = 1008, itemId =   895}, -- Ram Horn
            {cutoff = 1021, itemId =   859}, -- Ram Skin
            {cutoff = 1074, itemId =  4719}, -- Scroll of Regen III
            {cutoff = 1087, itemId =   866}, -- Wyvern Scales
            {cutoff = 1103, itemId =  1122}, -- Wyvern Skin
        },
    },
    [xi.ki.BLACK_CORAL_KEY] = {
        expansion = xi.mission.log_id.AMK, mission = xi.mission.id.amk.SHOCK_ARRANT_ABUSE_OF_AUTHORITY, repeatable = true,
        prizes = {
            {cutoff =   90, itemId = 13698, augments = { -- Beak Helm
                    { 9, 0, 5}, -- MP +1-6
                    {25, 0, 3}, -- Attack +1-4
                    {23, 0, 5}, -- Accuracy +1-6
                    {31, 0, 4}, -- Evasion +1-5
                    {27, 0, 5}, -- Ranged Accuracy +1-6
                },
            },
            {cutoff =  194, itemId = 12988, augments = { -- Pigaches
                    {  1, 1, 11}, -- HP +2-12
                    { 29, 0,  2}, -- Ranged Attack +1-3
                    { 27, 0,  1}, -- Ranged Accuracy +1-2
                    { 51, 0,  1}, -- HP Recovered While Healing +1-2
                    {513, 0,  1}, -- DEX +1-2
                    {522, 0,  1}, -- AGI -1-2
                },
            },
            {cutoff =  224, itemId = 12811, augments = { -- Darksteel Breeches
                    {770, 1, 4}, -- Wind resist +2-5
                    {515, 1, 2}, -- Agility +2-3
                    { 31, 2, 2}, -- Evasion +3
                    {180, 0, 2}, -- Resist Silence +1-3
                },
            },
            {cutoff =  433, itemId = 12707, augments = { -- Scorpion Mitts
                    {512, 0,  3}, -- STR +1-4
                    {514, 0,  1}, -- VIT +1-2
                    {518, 0,  2}, -- CHR +1-3
                    { 97, 0,  2}, -- Pet: Attack and Ranged Attack +1-3
                    {  1, 4, 11}, -- MP +5-12
                    { 26, 0,  3}, -- Attack -1--4
                },
            },
            {cutoff =  552, itemId = 12604, augments = { -- Silk Coat
                    {516, 0,  3}, -- INT +1-4
                    {517, 0,  2}, -- CHR +1-3
                    {518, 0,  3}, -- MND +1-4
                    { 52, 0,  3}, -- MP Recovered While Healing +1-4
                    { 13, 1, 12}, -- MP -2--13
                {{ 36, 0,  2}, {35, 0, 0},}, -- Magic Accuracy -3 - +1 (split into two augments)
                    {293, 0,  4}, -- Dark +1-5
                },
            },
            {cutoff =  597, itemId =   645}, -- Darksteel Ore
            {cutoff =  612, itemId =   654}, -- Darksteel Ingot
            {cutoff =  642, itemId =   745}, -- Gold Ingot
            {cutoff =  776, itemId =  4144}, -- Hi-Elixer
            {cutoff =  821, itemId =  4133}, -- Hi-Ether +1
            {cutoff =  851, itemId =  4117}, -- Hi-Potion +1
            {cutoff =  866, itemId =   700}, -- Mahogany Log
            {cutoff =  881, itemId =   653}, -- Mythril Ingot
            {cutoff =  896, itemId =   797}, -- Painite
            {cutoff = 1000, itemId =   652}, -- Steel Ingot
            {cutoff = 1015, itemId =   805}, -- Zircon
        },
    },
    [xi.ki.RED_CORAL_KEY] = {
        expansion = xi.mission.log_id.AMK, mission = xi.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS, repeatable = true,
        prizes = {
            {cutoff =  109, itemId = 16289, augments = { -- Alloy Torque
                    { 51, 0, 1}, -- HP Recovered while Healing +1-2
                    { 35, 0, 2}, -- Magic Accuracy +1-3
                    {298, 0, 4}, -- Wind Instrument Skill +1-5
                    {291, 0, 4}, -- Enfeebling Magic Skill +1-5
                    {292, 0, 4}, -- Elemental Magic Skill +1-5
                },
            },
            {cutoff =  200, itemId = 16288, augments = { -- Aureate Necklace
                    {768, 2, 3}, -- Fire resist +3-4
                    {512, 0, 1}, -- STR +1-2
                    {513, 0, 4}, -- DEX +1-5
                    {142, 0, 2}, -- Store TP +1-3
                    {102, 0, 2}, -- Pet: Critical Hit Rate +1-3
                    { 24, 0, 3}, -- Accuracy -1--4
                },
            },
            {cutoff =  273, itemId = 16290, augments = { -- Burly Gorget
                    {516, 0, 2}, -- INT +1-3
                    {517, 0, 2}, -- CHR +1-3
                    {518, 0, 2}, -- MND +1-3
                    { 40, 0, 0}, -- Enmity -1
                    { 53, 0, 3}, -- Spell Interruption Rate down 1-4%
                    { 36, 1, 1}, -- Magic Accuracy -2
                },
            },
            {cutoff =  382, itemId = 16286, augments = { -- Nitid Choker
                    {  5, 0, 8}, -- HP -1-9
                    {513, 0, 1}, -- DEX +1-2
                    { 23, 0, 7}, -- Accuracy +1-8
                    { 25, 0, 3}, -- Attack +1-4
                    { 96, 0, 3}, -- Pet: Accuracy and Ranged Accuracy +1-4
                    {772, 0, 2}, -- Lightning resist +1-3
                },
            },
            {cutoff =  473, itemId = 16287, augments = { -- Pneuma Collar
                    { 34, 2, 2}, -- Defense -3
                    {512, 0, 1}, -- STR +1-2
                    { 27, 0, 1}, -- Ranged Accuracy +1-2
                    { 29, 0, 6}, -- Ranged Attack +1-7
                    {185, 0, 1}, -- Resist Gravity +1-2
                    { 98, 0, 2}, -- Pet: Evasion +1-3
                },
            },
            {cutoff =  528, itemId =  1110}, -- Beetle Blood
            {cutoff =  619, itemId =   823}, -- Gold Thread
            {cutoff =  692, itemId =  1465}, -- Granite
            {cutoff =  728, itemId =  4134}, -- Hi-Ether +2
            {cutoff =  764, itemId =   837}, -- Malboro Fiber
            {cutoff =  782, itemId =   924}, -- Philosophers Stone
            {cutoff =  800, itemId =   844}, -- Phoenix Feather
            {cutoff =  836, itemId =   830}, -- Rainbow Cloth
            {cutoff =  872, itemId =  1132}, -- Raxa
            {cutoff =  999, itemId =  4174}, -- Vile Elixir
            {cutoff = 1017, itemId =  4517}, -- Yellow Curry
        },
    },
    [xi.ki.ANGEL_SKIN_KEY] = {
        expansion = xi.mission.log_id.AMK, mission = xi.mission.id.amk.SMASH_A_MALEVOLENT_MENACE, repeatable = true,
        prizes = {
            {cutoff =   65, itemId = 16254, augments = { -- Altius Mantle
                    {782, 0, 19}, -- Light resist -1--20
                    {180, 0,  1}, -- Resist Silence +1-2
                    {101, 0,  1}, -- Pet: Magic Attack Bonus +1-2
                    {518, 0,  3}, -- CHR +1-4
                    {320, 0,  1}, -- Blood Pact Ability Delay -1--2
                    {  5, 0,  4}, -- HP -1-5
                },
            },
            {cutoff =  162, itemId = 16253, augments = { -- Chiffon Cape
                    {  1, 17, 29}, -- HP +18-30
                    {  9, 16, 28}, -- MP +17-29
                    { 54,  1,  2}, -- Physical Damage Taken -2--3%
                    { 50,  0,  0}, -- Slow +1
                    { 51,  0,  1}, -- HP Recovered While Healing +1-2
                    {777, 14, 22}, -- Ice resist -15--23
                },
            },
            {cutoff =  243, itemId = 16255, augments = { -- Cortege Cape
                    { 52, 0, 1}, -- MP Recovered While Healing +1-2
                    {178, 0, 2}, -- Resist Paralyze +1-3
                    {517, 0, 3}, -- MND +1-4
                    { 53, 0, 3}, -- Spell Interruption Rate Down 1-4%
                    { 36, 1, 1}, -- Magic Accuracy -2
                    {292, 0, 3}, -- Elemental Magic Skill +1-4
                },
            },
            {cutoff =  356, itemId = 16252, augments = { -- Resilient Mantle
                    { 23, 0,  2}, -- Accuracy +1-3 (from item page, assumed typo in key item page since not colored red)
                    { 25, 0, 17}, -- Attack +1-18
                    {512, 0,  2}, -- STR +1-3
                    {195, 0,  2}, -- Subtle Blow +1-3
                    { 32, 0,  2}, -- Evasion -1-3
                },
            },
            {cutoff =  437, itemId = 16256, augments = { -- Rugged Mantle
                    { 13, 1, 3}, -- MP -2-4
                    {141, 0, 2}, -- Conserve MP +1-3
                    { 40, 0, 1}, -- Enmity -1-2
                    {516, 0, 3}, -- INT +1-4
                    {107, 0, 2}, -- Pet:Attack and Ranged Attack +1-3
                    {323, 0, 3}, -- Cure casting time -1--4%
                },
            },
            {cutoff =  469, itemId =   646}, -- Adaman Ore
            {cutoff =  501, itemId =   813}, -- Angelstone
            {cutoff =  517, itemId =   645}, -- Darksteel Ore
            {cutoff =  582, itemId =   812}, -- Deathstone
            {cutoff =  614, itemId =   787}, -- Diamond
            {cutoff =  646, itemId =   785}, -- Emerald
            {cutoff =  662, itemId =  4135}, -- Hi-Ether +3
            {cutoff =  694, itemId =  4119}, -- Hi-Potion +3
            {cutoff =  742, itemId =   739}, -- Orichalcum Ore
            {cutoff =  790, itemId =   786}, -- Ruby
            {cutoff =  822, itemId =  4613}, -- Scroll of Cure V
            {cutoff =  855, itemId =  4659}, -- Scroll of Shell IV
            {cutoff =  888, itemId =   804}, -- Spinel
            {cutoff = 1021, itemId =  4174}, -- Vile Elixir
            {cutoff = 1037, itemId =  4774}, -- Scroll of Thunder III
            {cutoff = 1047, itemId =  4748}, -- Scroll of Raise III
        },
    },
    [xi.ki.OXBLOOD_KEY] = {
        expansion = xi.mission.log_id.AMK, mission = xi.mission.id.amk.SMASH_A_MALEVOLENT_MENACE, repeatable = false,
    },
    [xi.ki.MOOGLE_KEY] = {
        expansion = xi.mission.log_id.ASA, mission = xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD, repeatable = true,
        prizes = {
            {cutoff =  167, itemId = 12442, augments = { -- Studded Bandana
                    { 23, 0, 0}, -- Accuracy+1
                    {769, 0, 1}, -- Ice+2
                }
            },
            {cutoff =  374, itemId = 13209, augments = { -- Chain Belt
                    {770, 0, 0}, -- Wind+1
                    {514, 0, 0}, -- VIT+1
                    {  9, 0, 3}, -- MP+4
                }
            },
            {cutoff =  707, itemId = 13083, augments = { -- Chain Choker
                    {  9, 0, 11}, -- MP+12
                    {775, 0,  2}, -- Dark+3
                    { 40, 0,  0}, -- Enmity-1
                    { 53, 0,  0}, -- Spell Interruption Rate-1%
                }
            },
            {cutoff =  874, itemId =  4751}, -- Scroll of Erase
            {cutoff = 1041, itemId =   653}, -- Mythril Ingot
            {cutoff = 1100, itemId =   744}, -- Silver Ingot
        }
    },
    [xi.ki.BIRD_KEY] = {
        expansion = xi.mission.log_id.ASA, mission = xi.mission.id.asa.SUGAR_COATED_DIRECTIVE, repeatable = true,
        prizes = {
            {cutoff = 143, itemId = 12987, augments = { -- Ebony Sabots
                    {774, 0, 2}, -- Light+0-3
                    { 39, 0, 3}, -- Enmity+0-3
                    { 53, 0, 2}, -- Spell Interruption Rate-0-3%
                    { 35, 0, 0}, -- Magic Accuracy+0-1
                    {  9, 0, 5}, -- MP+0-6
                    {518, 0, 0}, -- CHR+0-1
                }
            },
            {cutoff = 393, itemId = 13783, augments = { -- Iron Scale Mail
                    {  1, 0, 9}, -- HP+0-10
                    { 51, 0, 2}, -- HP Recovered While Healing+0-3
                    {512, 0, 1}, -- STR+0-2
                    {520, 0, 3}, -- DEX-0-4
                    { 25, 0, 5}, -- Attack+0-6
                    { 97, 0, 2}, -- Pet: Attack and Ranged Attack+0-3
                }
            },
            {cutoff = 536, itemId = 12293, augments = { -- Oak Shield
                    {768, 0, 3}, -- Fire+0-4
                    { 35, 0, 0}, -- Magic Accuracy+0-1
                    {329, 0, 0}, -- Cure potency+0-1%
                    {  9, 0, 3}, -- MP+0-4
                    { 96, 0, 2}, -- Pet: Accuracy and Ranged Accuracy+0-3
                    {521, 0, 0}, -- VIT-0-1
                }
            },
            {cutoff = 653, itemId = 13200, augments = { -- Waistbelt
                    {188, 0, 1}, -- Resist Charm+0-2
                    {185, 0, 0}, -- Resist Gravity+0-1
                    {512, 0, 0}, -- STR+0-1
                    { 25, 0, 3}, -- Attack+1-4
                    { 32, 0, 5}, -- Evasion-0-6
                }
            },
            {cutoff = 663, itemId =   793}, -- Black Pearl
            {cutoff = 678, itemId =   770}, -- Blue Rock
            {cutoff = 770, itemId =  4145}, -- Elixir
            {cutoff = 801, itemId =  4129}, -- Ether +1
            {cutoff = 816, itemId =   808}, -- Goshenite
            {cutoff = 847, itemId =   699}, -- Oak Log
            {cutoff = 852, itemId =   792}, -- Pearl
            {cutoff = 862, itemId =   788}, -- Peridot
            {cutoff = 871, itemId =  4113}, -- Potion +1
            {cutoff = 922, itemId =   701}, -- Rosewood Log
            {cutoff = 927, itemId =   815}, -- Sphene
            {cutoff = 947, itemId =   773}, -- Translucent Rock
            {cutoff = 957, itemId =   776}, -- White Rock
            {cutoff = 967, itemId =   771}, -- Yellow Rock
            {cutoff = 972, itemId =   774}, -- Purple Rock
        }
    },
    [xi.ki.CACTUAR_KEY] = {
        expansion = xi.mission.log_id.ASA, mission = xi.mission.id.asa.ENEMY_OF_THE_EMPIRE_II, repeatable = true,
        prizes = {
            {cutoff = 109, itemId = 13111, augments = { -- Nodowa
                    {512, 0, 1}, -- STR+1-2
                    {513, 0, 1}, -- DEX+1-2
                    { 50, 0, 3}, -- Slow+4
                    {  1, 0, 4}, -- HP+1-5
                    {115, 0, 1}, -- Store TP+1-2
                    {773, 1, 1}, -- Water+2
                }
            },
            {cutoff = 196, itemId = 12604, augments = { -- Silk Coat
                    {516, 0, 3}, -- INT+1-4
                    {517, 0, 3}, -- MND+1-4
                    {518, 0, 3}, -- CHR+1-4
                    {137, 0, 0}, -- Regen+1
                    {179, 0, 1}, -- Resist Blind+1-2
                    { 36, 0, 2}, -- Magic Accuracy-1--3
                }
            },
            {cutoff = 305, itemId = 13981, augments = { -- Turtle Bangles
                    {518, 0, 1}, -- CHR+1-2
                    {520, 0, 2}, -- DEX-3
                    { 25, 0, 2}, -- Attack+1-3
                    { 23, 0, 1}, -- Accuracy+1-2
                    {178, 0, 1}, -- Resist Paralyze+1-2
                    {187, 0, 0}, -- Resist Stun+1
                }
            },
            {cutoff = 370, itemId = 13711, augments = { -- Carapace Mask
                    {517, 0, 1}, -- MND+1-2
                    {  1, 4, 5}, -- HP+5-6
                {{ 28, 0, 0},{ 27, 0, 4},}, -- Ranged Accuracy-1-+5
                    { 30, 0, 3}, -- Ranged Attack-4
                    {770, 0, 4}, -- Wind+1-5
                }
            },
            {cutoff = 435, itemId =  4132}, -- Hi-Ether
            {cutoff = 544, itemId =  4144}, -- Hi-Elixer
            {cutoff = 609, itemId =   645}, -- Darksteel Ore
            {cutoff = 631, itemId =   737}, -- Gold Ore
            {cutoff = 674, itemId =  4719}, -- Scroll of Regen III
            {cutoff = 696, itemId =  4621}, -- Scroll of Raise II
            {cutoff = 718, itemId =   738}, -- Platinum Ore
            {cutoff = 761, itemId =   866}, -- Wyvern Scales
            {cutoff = 804, itemId =   702}, -- Ebony Log
            {cutoff = 847, itemId =   902}, -- Demon Horn
            {cutoff = 869, itemId =   703}, -- Petrified Log
            {cutoff = 891, itemId =  1116}, -- Manticore Hide
            {cutoff = 913, itemId =   895}, -- Ram Horn
            {cutoff = 935, itemId =   859}, -- Ram Skin
        }
    },
    [xi.ki.BOMB_KEY] = {
        expansion = xi.mission.log_id.ASA, mission = xi.mission.id.asa.SHANTOTTO_IN_CHAINS, repeatable = true,
        prizes = {
            {cutoff = 308, itemId = 12980, augments = { -- Battle Boots
                    { 34, 1,  5}, -- DEF-6--2
                    {  9, 5, 10}, -- MP+6-11
                    {141, 0,  2}, -- Conserve MP+1-3
                    { 40, 0,  1}, -- Enmity-1-2
                    {104, 0,  1}, -- Pet: Enmity+1-2
                }
            },
            {cutoff = 462, itemId = 12860, augments = { -- Silk Slops
                    {  9, 2, 2}, -- MP+3
                    {515, 0, 0}, -- AGI+1
                    {517, 0, 1}, -- MND+1-2
                    { 29, 0, 2}, -- Ranged Attack+3
                    { 98, 0, 0}, -- Pet: Evasion+1
                }
            },
            {cutoff = 616, itemId = 13589, augments = { -- Tiger Mantle
                    {  1, 1, 4}, -- HP+2-5
                    {515, 0, 0}, -- AGI+1
                    { 31, 0, 0}, -- Evasion+1
                    {769, 1, 1}, -- Ice resist +2
                    { 55, 0, 0}, -- Magic Damage Taken-1%
                }
            },
            {cutoff = 693, itemId = 12427, augments = { -- Bascinet
                    { 49, 1, 2}, -- Haste+3
                    { 24, 0, 0}, -- Accuracy-1
                    {180, 0, 0}, -- Resist Silence+1
                    {100, 0, 0}, -- Pet: Magic Accuracy+1
                }
            },
            {cutoff = 747, itemId =  4144}, -- Hi-Elixer
            {cutoff = 824, itemId =   654}, -- Darksteel Ingot
            {cutoff = 901, itemId =   645}, -- Darksteel Ore
        },
        [xi.ki.CHOCOBO_KEY] = {
            expansion = xi.mission.log_id.ASA, mission = xi.mission.id.asa.BATTARU_ROYALE, repeatable = true,
            prizes = {
                {cutoff =  190, itemId = 16008, augments = { -- Aptus Earring
                -- assumed magic skill caps are all the same
                        {133, 0,  5}, -- Magic Attack Bonus+1-2
                        { 35, 0,  1}, -- Magic Accuracy+1-2
                        {141, 0,  2}, -- Conserve MP+1-3
                        { 53, 0,  4}, -- Spell Interruption Rate-1-5%
                        {294, 0,  2}, -- Summoning Magic Skill+1
                        {293, 0,  2}, -- Dark Magic Skill+2
                        {291, 0,  2}, -- Enfeebling Magic Skill+1-2
                        {295, 0,  2}, -- Ninjutsu Skill+1
                        {290, 0,  2}, -- Enhancing Magic Skill+2
                        {299, 0,  2}, -- Blue Magic Skill+1-2
                        { 13, 6, 25}, -- MP-7--26
                        {296, 0,  2}, -- Singing Skill+1-2
                        {298, 0,  2}, -- Wind Instrument Skill+3
                        {292, 0,  2}, -- Elemental Magic Skill+1
                    }
                },
                {cutoff =  285, itemId = 16372, augments = { -- Stearc Subligar
                        { 44, 0, 2}, -- Subtle Blow+1-3
                        {188, 0, 3}, -- Resist Charm+1-4
                        { 51, 0, 0}, -- HP Recovered While Healing+1
                        {  1, 7, 7}, -- HP+8
                        {774, 0, 6}, -- Light+1-7
                        {783, 5, 5}, -- Dark-6
                    }
                },
                {cutoff =  571, itemId = 16295, augments = { -- Varius Torque
                -- assumed combat skill caps are all the same
                        { 23,  0,  4}, -- Accuracy+1-5
                        { 25,  0,  4}, -- Attack+1-5
                        { 27,  0,  3}, -- Ranged Accuracy+1-4
                        { 29,  0,  3}, -- Ranged Attack+1-4
                        {259,  0,  4}, -- Sword Skill+1
                        {267,  0,  4}, -- Club Skill+3
                        {262,  0,  4}, -- Great Axe Skill+1
                        {260,  0,  4}, -- Great Sword Skill+1
                        {264,  0,  4}, -- Polearm Skill+1-5
                        {266,  0,  4}, -- Great Katana Skill+1
                        {282,  0,  4}, -- Marksmanship Skill+1-3
                        {281,  0,  4}, -- Archery Skill+1-5
                        {257,  0,  4}, -- Hand-to-Hand Skill+1-5
                        {  5, 15, 24}, -- HP-16-25
                    }
                },
                {cutoff =  595, itemId =   823}, -- Gold Thread
                {cutoff =  643, itemId =  4134}, -- Hi-Ether +2
                {cutoff =  714, itemId =  4118}, -- Hi-Potion +2
                {cutoff =  785, itemId =   837}, -- Malboro Fiber
                {cutoff =  856, itemId =  1110}, -- Beetle Blood
                {cutoff =  927, itemId =   924}, -- Philosophers Stone
                {cutoff =  995, itemId =   830}, -- Rainbow Cloth
                {cutoff = 1043, itemId =  1132}, -- Raxa
                {cutoff = 1067, itemId =  1465}, -- Granite
                {cutoff = 1115, itemId =  4174}, -- Vile Elixir
                {cutoff = 1186, itemId =   844}, -- Phoenix Feather
            },
        },
    },
    [xi.ki.TONBERRY_KEY] = {
        expansion = xi.mission.log_id.ASA, mission = xi.mission.id.asa.PROJECT_SHANTOTTOFICATION, repeatable = true,
        prizes = {
            {cutoff =  291, itemId = 15938, augments = { -- Esprit Belt
                    {516, 0, 5}, -- INT+1-6
                    {517, 0, 4}, -- MND+1-5
                    {518, 0, 4}, -- CHR+1-5
                    { 35, 0, 3}, -- Magic Accuracy+1-4
                    { 39, 0, 2}, -- Enmity+0-3
                    { 53, 0, 2}, -- Spell Interruption Rate-1-3%
                }
            },
            {cutoff =  600, itemId = 15937, augments = { -- Fettle Belt
                    { 49, 0, 4}, -- Haste+1-5
                    {512, 0, 2}, -- STR+1-3
                    {513, 0, 2}, -- DEX+1-3
                    {195, 0, 4}, -- Subtle Blow+1-5
                    { 31, 0, 4}, -- Evasion+1-5
                    { 24, 0, 9}, -- Accuracy-10--1
                }
            },
            {cutoff =  636, itemId =   813}, -- Angelstone
            {cutoff =  654, itemId =   812}, -- Deathstone
            {cutoff =  690, itemId =   645}, -- Darksteel Ore
            {cutoff =  708, itemId =   787}, -- Diamond
            {cutoff =  744, itemId =   785}, -- Emerald
            {cutoff =  780, itemId =   823}, -- Gold Thread
            {cutoff =  798, itemId =  4119}, -- Hi-Potion +3
            {cutoff =  816, itemId =   738}, -- Platinum Ore
            {cutoff =  834, itemId =   739}, -- Orichalcum Ore
            {cutoff =  870, itemId =   786}, -- Ruby
            {cutoff =  883, itemId =   794}, -- Sapphire
            {cutoff =  901, itemId =  4613}, -- Scroll of Cure V
            {cutoff =  919, itemId =  4748}, -- Scroll of Raise III
            {cutoff =  937, itemId =  4774}, -- Scroll of Thunder III
            {cutoff =  955, itemId =   804}, -- Spinel
            {cutoff =  973, itemId =   789}, -- Topaz
            {cutoff = 1082, itemId =  4174}, -- Vile Elixir
        },
    },
    [xi.ki.BEHEMOTH_KEY] = {
        expansion = xi.mission.log_id.ASA, mission = xi.mission.id.asa.AN_UNEASY_PEACE, repeatable = false,
    },
}

local optionToGear =
{
    [1] = {addon = 1, itemid = 11313}, -- nuevo_coselete
    [2] = {addon = 1, itemid = 11314}, -- mirke_wardecors
    [3] = {addon = 1, itemid = 11315}, -- royal_redingote
    [4] = {addon = 2, itemid = 11487}, -- champions_galea
    [5] = {addon = 2, itemid = 11488}, -- anwig_salade
    [6] = {addon = 2, itemid = 11489}, -- selenian_cap
    [7] = {addon = 3, itemid = 16369}, -- blitzer_poleyn
    [8] = {addon = 3, itemid = 16370}, -- desultor_tassets
    [9] = {addon = 3, itemid = 16371}, -- tatsumaki_sitagoromo
}

local optionToAugment =
{
    [1] = -- ACP
    {
        {{augment =  23, power =  9}}, -- Accuracy+10
        {{augment =  25, power =  9}}, -- Attack+10
        {{augment =  27, power =  9}}, -- Ranged Accuracy+10
        {{augment =  29, power =  9}}, -- Ranged Attack+10
        {{augment =  31, power =  9}}, -- Evasion+10
        {{augment =  35, power =  3}}, -- Magic Accuracy+4
        {{augment = 133, power =  3}}, -- "Magic Atk, Bonus"+4
        {{augment = 143, power =  1}}, -- "Double Attack"+2
        {{augment =  41, power =  2}}, -- Critical hit rate +3
        {{augment =  44, power =  3}}, -- Store TP"+4 "Subtle Blow"+4
        {{augment =  39, power =  4}}, -- Enmity+5
        {{augment =  40, power =  4}}, -- Enmity-5
        {{augment = 140, power =  4}}, -- Enhances "Fast Cast" effect +5
        {{augment = 324, power = 14}}, -- "Call Beast" ability delay -15
        {{augment = 211, power =  4}}, -- "Snapshot"+5
        {{augment = 146, power =  2}}, -- Enhances "Dual Wield" effect +3
        {{augment = 320, power =  3}}, -- "Blood Pact" ability delay -4
        {{augment = 321, power =  1}}, -- Avatar perpetuation cost -2
        {{augment = 325, power =  4}}, -- Quick Draw" ability delay -5
        {{augment =  96, power = 14}}, -- Pet: Accuracy+15 Ranged Accuracy+15
        {{augment =  97, power = 14}}, -- Pet: Attack+15 Ranged Attack+15
        {{augment = 108, power =  6}}, -- Pet: Magic Acc.+7 "Magic Atk. Bonus"+7
        {{augment = 109, power =  1}}, -- Pet: "Double Attack"+2 Crit. hit rate +2
    },
    [2] = -- AMK
    {
        {{augment =  49, power = 2}, {augment = 211, power =  2}}, -- Haste+3% Enhances "Snapshot" effect (+3%)
        {{augment = 512, power = 3}, {augment = 326, power = 14}}, -- STR+4 Weapon Skill Accuracy +15
        {{augment = 513, power = 3}, {augment = 328, power =  1}}, -- DEX+4 Increases Critical Hit Damage (+2%)
        {{augment = 514, power = 3}, {augment = 286, power =  4}}, -- VIT+4 Shield Skill +5
        {{augment = 515, power = 3}, {augment = 327, power =  1}}, -- AGI+4 Increases weapon skill damage (+2%)
        {{augment = 516, power = 3}, {augment =  35, power =  1}}, -- INT+4 Magic Accuracy+2
        {{augment = 517, power = 3}, {augment = 329, power =  2}}, -- MND+4 "Cure" potency +3%
        {{augment = 518, power = 3}, {augment = 331, power =  1}}, -- CHR+4 "Waltz" ability delay -2
        {{augment =  23, power = 9}, {augment =  25, power =  4}}, -- Accuracy+10 Attack+5
        {{augment =  27, power = 9}, {augment =  29, power =  4}}, -- Ranged Accuracy+10 Ranged Attack+5
        {{augment =  31, power = 9}, {augment = 142, power =  3}}, -- Evasion+10 Store TP +4
        {{augment =  35, power = 2}, {augment =  52, power =  2}}, -- Magic Accuracy+3 MP recovered while healing +3
        {{augment = 133, power = 1}, {augment =  51, power =  2}}, -- "Magic Attack Bonus"+2 HP recovered while healing +3
        {{augment =  55, power = 1}, {augment =  39, power =  3}}, -- Magic damage taken -2% Enmity+4
        {{augment =  57, power = 9}, {augment =  40, power =  3}}, -- Magic critical hit rate +10% Enmity-4
        {{augment = 140, power = 2}, {augment = 320, power =  2}}, -- Enhances "Fast Cast" effect (+3%) "Blood Pact" ability delay -3
        {{augment = 512, power = 1}, {augment =  49, power =  1}}, -- STR+2 Haste +2%
        {{augment = 513, power = 1}, {augment =  49, power =  1}}, -- DEX+2 Haste +2%
        {{augment = 514, power = 1}, {augment =  49, power =  1}}, -- VIT+2 Haste +2%
        {{augment = 515, power = 1}, {augment =  49, power =  1}}, -- AGI+2 Haste +2%
        {{augment = 516, power = 1}, {augment = 140, power =  1}}, -- INT+2 Enhances "Fast Cast" effect (+2%)
        {{augment = 517, power = 1}, {augment = 140, power =  1}}, -- MND+2 Enhances "Fast Cast" effect (+2%)
        {{augment = 518, power = 1}, {augment = 140, power =  1}}, -- CHR+2 Enhances "Fast Cast" effect (+2%)
        {{augment =  23, power = 2}, {augment = 111, power =  4}}, -- Accuracy+3 Pet: Haste +5%
        {{augment =  23, power = 2}, {augment = 102, power =  2}}, -- Accuracy+3 Pet: Critical Hit Rate +3%
        {{augment =  25, power = 2}, {augment = 110, power =  0}}, -- Attack+3 Pet: Adds "Regen" effect
        {{augment =  25, power = 2}, {augment = 112, power =  9}}, -- Attack+3 Pet: Damage taken -10%
    },
    [3] = -- ASA
    {
        {{augment =    1, power = 24}, {augment = 39, power =  3}}, -- HP+25 Enmity+4
        {{augment =    9, power = 24}, {augment = 40, power =  3}}, -- MP+25 Enmity-4
        {{augment =   23, power =  6}}, -- Attack+7
        {{augment =   25, power =  6}}, -- Accuracy+7
        {{augment =   27, power =  6}}, -- Ranged Accuracy+7
        {{augment =   29, power =  6}}, -- Ranged Attack+7
        {{augment =   31, power =  6}}, -- Evasion+7
        {{augment =   35, power =  3}}, -- Magic Accuracy+4
        {{augment =  133, power =  3}}, -- "Magic Atk. Bonus" +4
        {{augment =   49, power =  2}}, -- Haste +3%
        {{augment =  143, power =  1}}, -- "Double Attack" +2%
        {{augment =  328, power =  2}}, -- Increases Critical Hit Damage +3%
        {{augment =  332, power =  4}}, -- Skillchain damage +5%
        {{augment =  333, power =  4}}, -- "Conserve TP"+5
        {{augment =   54, power =  3}}, -- Physical damage taken -4%
        {{augment =  335, power =  9}}, -- Magic Critical Hit damage +10%
        {{augment =  334, power =  9}}, -- Magic Burst damage +10%
        {{augment =  194, power =  4}}, -- "Kick Attacks" +5
        {{augment =  329, power =  4}}, -- "Cure" potency +5%
        {{augment =  336, power =  4}}, -- "Sic" & "Ready" ability delay -5
        {{augment =  337, power =  2}}, -- Song Recast Delay -3
        {{augment =  338, power =  0}}, -- "Barrage" +1
        {{augment =  339, power = 19}}, -- "Elemental Siphon" +20
        {{augment =  340, power =  4}}, -- "Phantom Roll" ability delay -5
        {{augment =  341, power =  9}}, -- "Repair" potency +10%
        {{augment =  342, power =  4}}, -- "Waltz" TP cost -50
        {{augment =   96, power =  6}}, -- Pet: Accuracy +7 Ranged Accuracy +7
        {{augment =   97, power =  6}}, -- Pet: Attack +7 Ranged Attack +7
        {{augment =  115, power =  7}, {augment = 116, power =  7}}, -- Pet: "Store TP" +8 "Subtle Blow" +8
        {{augment =  100, power =  6}}, -- Pet: Magic Accuracy +7
        {{augment =  913, power =  2}}, -- Movement Speed +8%
        {{augment =  195, power =  4}}, -- "Subtle Blow"+5
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
            local roll = math.random(p[#p].cutoff)
            for i = 1, #p do
                if roll <= p[i].cutoff then
                    prize = p[i]
                    break
                end
            end

            -- determine augments
            local addAug = {}
            if prize.augments ~= nil then
                local pAug = {}
                -- deep copy augments for prize
                for k,v in pairs(prize.augments) do
                    table.insert(pAug, v)
                end
                for i = 1, 4 do
                    -- static 50% chance to get any augment at all each loop
                    if #addAug == 0 or math.random(1,2) == 1 then
                        -- since lua arrays start at index 1, set start at 1 to guarantee at least one augment
                        roll = math.random(1, #pAug)
                    else
                        roll = 0
                    end
                    local aug = pAug[roll]
                    if aug ~= nil then
                        if type(aug[1]) ~= "number" then
                            -- augment is itself a list
                            -- used for stat ranges that go between negative and positive
                            -- but, could also be used for groups of stats like int/mnd/chr to avoid having them all show up?
                            aug = aug[math.random(1,#aug)]
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
            if player:getFreeSlotsCount() == 0 then
                player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, prize.itemId)
            else
                player:addItem(prize.itemId, 1, unpack(addAug))
                player:messageSpecial(ID.text.ITEM_OBTAINED, prize.itemId)
                player:delKeyItem(ki)
            end
        end
    end
end

local function intToBinary(x)
    local bin = ""

    while x > 1 do
        bin = tostring(x % 2) .. bin
        x = math.floor(x / 2)
    end

    bin = tostring(x) .. bin

    return bin
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
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, optionToGear[gear].itemid)
        else
            player:addItem(optionToGear[gear].itemid, 1, unpack(addAug))
            player:messageSpecial(ID.text.ITEM_OBTAINED, optionToGear[gear].itemid)
            player:delKeyItem(({xi.ki.PRISMATIC_KEY,xi.ki.OXBLOOD_KEY,xi.ki.BEHEMOTH_KEY})[addon])
        end
    else
        -- Convert each augment's power and ID to binary (5 bits for power followed by 11 bits for ID)
        for i = 1, #augment1 do
            table.insert(addAug, string.format("%05i%011i", intToBinary(augment1[i].power), intToBinary(augment1[i].augment)))
        end

        for i = 1, #augment2 do
            table.insert(addAug, string.format("%05i%011i", intToBinary(augment2[i].power), intToBinary(augment2[i].augment)))
        end

        for i = #addAug, 5 do
            table.insert(addAug, "0000000000000000")
        end

        -- Each argument concats 2 different augments. For some reason, argument 1 contacts the string below.
        player:updateEvent(tonumber(addAug[1] .. "0000001100000010", 2), tonumber(addAug[2] .. addAug[3], 2), tonumber(addAug[4] .. addAug[5], 2))
    end

end

entity.onTrade = function(player, npc, trade)
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
    local acpFin  = player:getCurrentMission(xi.mission.log_id.ACP) >= xi.mission.id.acp.A_CRYSTALLINE_PROPHECY_FIN
    local amkFin  = player:getCurrentMission(xi.mission.log_id.AMK) >= xi.mission.id.amk.A_MOOGLE_KUPO_DETAT_FIN
    local asaFin  = player:getCurrentMission(xi.mission.log_id.ASA) >= xi.mission.id.asa.A_SHANTOTTO_ASCENSION_FIN
    local eligableNexusCape = asaFin and amkFin and acpFin
    local receivedNexusCape = player:getCharVar('receivedNexusCape')
    local kiArgs = { 0, 0, 0 }

    if (xi.settings.main.NEXUS_CAPE_FIN or 0) ~= 1 then
        eligableNexusCape = (xi.settings.main.ENABLE_ACP * xi.settings.main.ENABLE_AMK * xi.settings.main.ENABLE_ASA) ~= 0
    end


    for argNum = 1, 3 do
        for bitPos, keyItem in ipairs(argumentKeyItems[argNum]) do
            if not player:hasKeyItem(keyItem) then
                kiArgs[argNum] = utils.mask.setBit(kiArgs[argNum], bitPos, true)
            end
        end
    end

    local arg4 =
        ((xi.settings.main.ENABLE_ACP == 0 or kiArgs[1] == 254) and 2 or 0) +
        ((xi.settings.main.ENABLE_AMK == 0 or kiArgs[2] == 254) and 4 or 0) +
        ((xi.settings.main.ENABLE_ASA == 0 or kiArgs[3] == 254) and 8 or 0) +
        ((not eligableNexusCape or receivedNexusCape == 1) and 16 or 0) +
        ((not eligableNexusCape or receivedNexusCape == 0) and 32 or 0)

    player:startEvent(10099, kiArgs[1], kiArgs[2], kiArgs[3], arg4, 0, 0, 0, 0)
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
            player:getCharVar('receivedNexusCape') == 0 and
            npcUtil.giveItem(player, xi.item.NEXUS_CAPE)
        then
            player:setCharVar('receivedNexusCape', 1)

        elseif
            option == 33554432 or
            (option == 16777216 and player:getCharVar('receivedNexusCape') == 0)
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
