-----------------------------------
-- Area: RuAun_Gardens
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.RUAUN_GARDENS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED    = 6382,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE = 6386,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED              = 6388,  -- Obtained: <item>.
        GIL_OBTAINED               = 6389,  -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6391,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED             = 6397,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY    = 6402,  -- There is nothing out of the ordinary here.
        FISHING_MESSAGE_OFFSET     = 7049,  -- You can't fish here.
        CONQUEST_BASE              = 7149,  -- Tallying conquest results...
        IT_IS_ALREADY_FUNCTIONING  = 7309,  -- It is already functioning.
        CHEST_UNLOCKED             = 7343,  -- You unlock the chest!
        SKY_GOD_OFFSET             = 7360,  -- A strange insignia pointing north is carved into the wall.
        PLAYER_OBTAINS_ITEM        = 7562,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM      = 7563,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM   = 7564,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP       = 7565,  -- You already possess that temporary item.
        NO_COMBINATION             = 7570,  -- You were unable to enter a combination.
        REGIME_REGISTERED          = 9726,  -- New training regime registered!
        HOMEPOINT_SET              = 11647, -- Home point set!
        COMMON_SENSE_SURVIVAL      = 11667, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DESPOT_PH =
        {
            [17309946] = 17309954, -- -20.312 -41.729 -339.929
            [17309947] = 17309954, -- -20.239 -42.929 -324.024
            [17309948] = 17309954, -- -20.239 -42.929 -315.955
            [17309949] = 17309954, -- -20.239 -42.929 -307.985
            [17309950] = 17309954, -- -20.239 -42.929 -292.006
            [17309951] = 17309954, -- -20.239 -42.929 -284.072
            [17309952] = 17309954, -- -20.239 -42.929 -276.010
            [17309953] = 17309954, -- -20.239 -42.929 -259.976
            [17309938] = 17309954, -- 20.239 -41.729 -340.048
            [17309939] = 17309954, -- 20.239 -41.729 -324.024
            [17309940] = 17309954, -- 20.239 -41.729 -315.955
            [17309941] = 17309954, -- 20.239 -41.729 -307.985
            [17309942] = 17309954, -- 20.239 -44.129 -292.006
            [17309943] = 17309954, -- 20.239 -44.129 -284.072
            [17309944] = 17309954, -- 20.239 -44.129 -276.010
            [17309945] = 17309954, -- 20.239 -45.329 -259.976
        },
        MIMIC     = 17309979,
        GENBU     = 17309980,
        SEIRYU    = 17309981,
        BYAKKO    = 17309982,
        SUZAKU    = 17309983,
    },
    npc =
    {
        CASKET_BASE     = 17310003,
        TREASURE_COFFER = 17310019,
        PINCERSTONES =
        {
            [17310031] = 17310054, -- Main to Seriyu
            [17310033] = 17310055, -- Seriyu to Main
            [17310035] = 17310057, -- Seriyu to Genbu
            [17310037] = 17310058, -- Genbu to Seriyu
            [17310039] = 17310060, -- Genbu to Byakko
            [17310041] = 17310061, -- Byakko to Genbu
            [17310043] = 17310063, -- Byakko to Suzaku
            [17310045] = 17310064, -- Suzaku to Byakko
            [17310047] = 17310066, -- Suzaku to Main
            [17310049] = 17310067, -- Main to Suzaku
        },
        PORTALS      =
        {
            { coords = {  -3, -54, -583,    1, -50, -579}, event = 0       },
            { coords = { 147, -26, -449,  151, -22, -445}, event = 1       },
            { coords = { 186, -43, -405,  190, -39, -401}, event = 2       },
            { coords = { 272, -42, -379,  276, -38, -375}, event = {4, 5}   },
            { coords = { 306, -39, -317,  310, -35, -313}, event = 6       },
            { coords = { 393, -39,  193,  397, -35,  197}, event = 9       },
            { coords = {  62, -39,  434,   66, -35,  438}, event = 16      },
            { coords = {  -2, -42,  464,    2, -38,  468}, event = {18, 19} },
            { coords = { -65, -39,  434,  -61, -35,  438}, event = 20      },
            { coords = {-397, -39,  193, -393, -35,  197}, event = 23      },
            { coords = {-445, -42,  142, -441, -38,  146}, event = {25, 26} },
            { coords = {-276, -42, -379, -272, -38, -375}, event = {32, 33} },
            { coords = {-191, -43, -405, -187, -39, -401}, event = 34      },
            { coords = {-151, -26, -449, -147, -22, -445}, event = 36      },
            { coords = { 543, -73,  -19,  547, -69,  -15}, event = 37      },
            { coords = { 182, -73,  511,  186, -69,  515}, event = 38      },
            { coords = {-432, -73,  332, -428, -69,  336}, event = 39      },
            { coords = {-453, -73, -308, -449, -69, -304}, event = 40      },
            { coords = {-436, -39,   71, -432, -35,   75}, event = 27      },
            { coords = {-310, -39, -317, -306, -35, -313}, event = 30      },
            { coords = { 441, -42,  142,  445, -38,  146}, event = {11, 12} },
            { coords = { 432, -39,   71,  436, -35,   75}, event = 9       },
            { coords = { 162.5, -31, -353.5,  168.5, -30, -347.5}, event = 3,  portal = 17310054 },
            { coords = { 374.5, -25,   61.5,  380.5, -24,   67.5}, event = 10, portal = 17310057 },
            { coords = {  52.5, -25,  376.5,   58.5, -24,  382.5}, event = 17, portal = 17310060 },
            { coords = {-346.5, -25,  166.5, -340.5, -24,  172.5}, event = 24, portal = 17310063 },
            { coords = {-270.5, -25, -277.5, -264.5, -24, -271.5}, event = 31, portal = 17310066 },
            { coords = {-170.0, -31, -354.4, -162.0, -30, -347.2}, event = 35, portal = 17310067 },
            { coords = {-381.0, -25,   61.5, -374.5, -24,   67.5}, event = 28, portal = 17310064 },
            { coords = { -58.0, -25,  376.5,  -52.0, -24,  382.5}, event = 21, portal = 17310061 },
            { coords = { 340.5, -25,  166.5,  346.5, -24,  172.5}, event = 14, portal = 17310058 },
            { coords = { 264.5, -25, -277.5,  270.5, -24, -271.5}, event = 7,  portal = 17310055 },
            { coords = { 454, -5, -149,  456, -3, -147}, event = 8  },
            { coords = { 278, -5,  383,  281, -3,  386}, event = 15 },
            { coords = {-283, -5,  386, -280, -3,  389}, event = 22 },
            { coords = {-456, -5, -149, -454, -3, -147}, event = 29 },
            {coords={-145, -41, -156, -142, -39, -153}, green = true},
            {coords={ 142, -41, -156,  145, -39, -153}, green = true},
        },
        OVERSEER_BASE   = 17310080,
    },
}

return zones[tpz.zone.RUAUN_GARDENS]
