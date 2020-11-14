-----------------------------------
-- Area: Castle_Oztroja
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CASTLE_OZTROJA] =
{
    text =
    {
        CANNOT_REACH_TARGET                = 0, -- Cannot reach target.
        ITS_LOCKED                         = 1, -- It's locked.
        PROBABLY_WORKS_WITH_SOMETHING_ELSE = 3, -- It probably works with something else.
        TORCH_LIT                          = 5, -- The torch is lit.
        INCORRECT                          = 11, -- Incorrect.
        FIRST_WORD                         = 12, -- The first word.
        SECOND_WORD                        = 13, -- The second word.
        THIRD_WORD                         = 14, -- The third word.
        CONQUEST_BASE                      = 26, -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED            = 6567, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE         = 6571, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                      = 6573, -- Obtained: <item>.
        GIL_OBTAINED                       = 6574, -- Obtained <number> gil.
        KEYITEM_OBTAINED                   = 6576, -- Obtained key item: <keyitem>.
        NOT_ENOUGH_GIL                     = 6578, -- You do not have enough gil.
        ITEMS_OBTAINED                     = 6582, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY            = 6587, -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING                = 6588, -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET              = 6602, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS                = 7184, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY            = 7085, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER                       = 7086, -- In celebration of your most recent login no. <number>...
        FISHING_MESSAGE_OFFSET             = 7253, -- You can't fish here.
        CHEST_UNLOCKED                     = 7424, -- You unlock the chest!
        YAGUDO_AVATAR_ENGAGE               = 7445, -- Kahk-ka-ka... You filthy, dim-witted heretics! You have damned yourselves by coming here.
        YAGUDO_AVATAR_DEATH                = 7446, -- Our lord, Tzee Xicu the Manifest!  Even should our bodies be crushed and broken, may our souls endure into eternity...
        YAGUDO_KING_ENGAGE                 = 7447, -- You are not here as sacrifices, are you? Could you possibly be committing this affront in the face of a deity?  Very well, I will personally mete out your divine punishment, kyah!
        YAGUDO_KING_DEATH                  = 7448, -- You have...bested me... However, I...am...a god... I will never die...never rot...never fade...never...
        COMMON_SENSE_SURVIVAL              = 8296, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        MEE_DEGGI_THE_PUNISHER_PH  =
        {
            [17395798] = 17395800, -- -207.840 -0.498 109.939
            [17395766] = 17395800, -- -178.119 -0.644 153.039
            [17395769] = 17395800, -- -188.253 -0.087 158.955
            [17395783] = 17395800, -- -233.116 -0.741 172.067
            [17395784] = 17395800, -- -254.302 -0.057 163.759
            [17395799] = 17395800, -- -227.415 -4.340 145.213
            [17395761] = 17395800, -- -207.370 -0.056 106.537
            [17395775] = 17395800, -- -235.639 -0.063 103.280
        },
        MOO_OUZI_THE_SWIFTBLADE_PH =
        {
            [17395809] = 17395816, -- -18.415 -0.075 -92.889
            [17395813] = 17395816, -- -38.689 0.191 -101.068
        },
        QUU_DOMI_THE_GALLANT_PH    =
        {
            [17395844] = 17395870, -- 103.948 -1.250 -189.869
            [17395845] = 17395870, -- 67.103 -0.079 -176.981
            [17395853] = 17395870, -- 99.000 -0.181 -149.000
            [17395831] = 17395870, -- 46.861 0.343 -176.989
            [17395868] = 17395870, -- 35.847 -0.500 -101.685
            [17395867] = 17395870, -- 59.000 -4.000 -131.000
            [17395829] = 17395870, -- 33.832 -0.068 -176.627
            [17395837] = 17395870, -- 18.545 -0.056 -120.283
        },
        YAA_HAQA_THE_PROFANE_PH    =
        {
            [17395950] = 17395954, -- -24.719 -16.250 -139.678
            [17395951] = 17395954, -- -22.395 -16.250 -139.341
            [17395952] = 17395954, -- -25.044 -16.250 -141.534
            [17395953] = 17395954, -- -32.302 -16.250 -139.169
        },
        YAGUDO_AVATAR              = 17396134,
        HUU_XALMO_THE_SAVAGE       = 17396140,
        MIMIC                      = 17396144,
    },
    npc =
    {
        HANDLE_DOOR_FLOOR_2    = 17396160,
        FIRST_PASSWORD_STATUE  = 17396168,
        SECOND_PASSWORD_STATUE = 17396173,
        THIRD_PASSWORD_STATUE  = 17396178,
        BRASS_DOOR_FLOOR_4_H7  = 17396185,
        TRAP_DOOR_FLOOR_4      = 17396191,
        FINAL_PASSWORD_STATUE  = 17396192,
        HINT_HANDLE_OFFSET     = 17396196,
        TREASURE_CHEST         = 17396210,
        TREASURE_COFFER        = 17396211,
    },
}

return zones[tpz.zone.CASTLE_OZTROJA]
