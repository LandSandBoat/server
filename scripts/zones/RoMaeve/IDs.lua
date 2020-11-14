-----------------------------------
-- Area: RoMaeve
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.ROMAEVE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6382,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6388,  -- Obtained: <item>.
        GIL_OBTAINED             = 6389,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6402,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6417,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY  = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER             = 7001, -- In celebration of your most recent login no. <number>...
        CONQUEST_BASE            = 7049,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7208,  -- You can't fish here.
        SENSE_OMINOUS_PRESENCE   = 7394,  -- You sense an ominous presence...
        ITEMS_ITEMS_LA_LA        = 7397,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY      = 7403,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM      = 7426,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7427,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7428,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7429,  -- You already possess that temporary item.
        NO_COMBINATION           = 7434,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9612,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 11622, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        NIGHTMARE_VASE_PH =
        {
            [17276981] = 17276982, -- -101.575 -6.099 -1.520 (west)
            [17276987] = 17276992, -- 59.825 -5.760 25.123 (east)
        },
        ROGUE_RECEPTACLE_PH =
        {
            [17277075] = 17277079,
            [17277078] = 17277079,
        },
        MOKKURKALFI_I     = 17276929,
        MOKKURKALFI_II    = 17276930,
        ELDHRIMNIR        = 17277126,
    },
    npc =
    {
        BASTOK_7_1_QM_POS =
        {
             [1] = {  162.000, -8.000,   21.000}, -- L-7
             [2] = {  160.000, -6.000, -110.000}, -- L-10
             [3] = {  105.000, -4.000, -112.000}, -- K-11
             [4] = {  126.000, -3.000,  -75.000}, -- K-10
             [5] = {   60.000, -6.000,    2.000}, -- I-8/J-8
             [6] = {  -48.000, -4.000,  -32.000}, -- G-9
             [7] = { -109.000, -4.000, -114.000}, -- E-11
             [8] = { -137.000,  1.000,  -90.000}, -- E-10
             [9] = { -105.000, -3.000,  -36.000}, -- E-9
            [10] = { -160.000, -6.000, -107.000}  -- D-10
        },
        CASKET_BASE     = 17277171,
        MOONGATE_OFFSET = 17277195,
        BASTOK_7_1_QM   = 17277207,
    },
}

return zones[tpz.zone.ROMAEVE]
