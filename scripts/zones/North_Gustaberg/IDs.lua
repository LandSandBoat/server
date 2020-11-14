-----------------------------------
-- Area: North_Gustaberg
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.NORTH_GUSTABERG] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        NOTHING_HAPPENS               = 300,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED_TWICE = 6562,  -- You cannot obtain any more.
        ITEM_CANNOT_BE_OBTAINED       = 6563,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6567,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6569,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6570,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6572,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6573,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6578,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6583,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6598,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7180, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY       = 7181, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7182, -- In celebration of your most recent login no. <number>...
        FISHING_MESSAGE_OFFSET        = 7230,  -- You can't fish here.
        DIG_THROW_AWAY                = 7243,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7245,  -- You dig and you dig, but find nothing.
        SPARKLING_LIGHT               = 7374,  -- The ground is sparkling with a strange light.
        SHINING_OBJECT_SLIPS_AWAY     = 7438,  -- The shining object slips through your fingers and is washed further down the stream.
        REACH_WATER_FROM_HERE         = 7445,  -- You can reach the water from here.
        CONQUEST                      = 7481,  -- You've earned conquest points!
        ITEMS_ITEMS_LA_LA             = 7833,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7839,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 8064,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8065,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8066,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8067,  -- You already possess that temporary item.
        NO_COMBINATION                = 8072,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10393, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 12466, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        STINGING_SOPHIE_PH  =
        {
            [17211532] = 17211561, -- 352.974 -40.359 472.914
            [17211534] = 17211561, -- 353.313 -40.347 463.609
            [17211535] = 17211561, -- 237.753 -40.500 469.738
            [17211533] = 17211561, -- 216.150 -41.182 445.157
            [17211536] = 17211561, -- 197.369 -40.612 453.688
            [17211531] = 17211561, -- 196.873 -40.415 500.153
            [17211556] = 17211561, -- 210.607 -40.478 566.096
            [17211557] = 17211561, -- 288.447 -40.842 634.161
            [17211558] = 17211561, -- 295.890 -41.593 614.738
            [17211560] = 17211561, -- 356.544 -40.528 570.302
            [17211559] = 17211561, -- 363.973 -40.774 562.355
            [17211581] = 17211561, -- 308.116 -60.352 550.771
            [17211582] = 17211561, -- 308.975 -61.082 525.690
            [17211580] = 17211561, -- 310.309 -60.634 521.404
            [17211583] = 17211561, -- 285.813 -60.784 518.539
            [17211579] = 17211561, -- 283.958 -60.926 530.016
        },
        MAIGHDEAN_UAINE_PH  =
        {
            [17211698] = 17211702, -- 121.242 -0.500 654.504
            [17211701] = 17211702, -- 176.458 -0.347 722.666
            [17211697] = 17211702, -- 164.140 1.981 740.020
            [17211710] = 17211702, -- 239.992 -0.493 788.037
            [17211700] = 17211702, -- 203.606 -0.607 721.541
            [17211711] = 17211702, -- 289.709 -0.297 750.252
        },
        GAMBILOX_WANDERLING = 17211848,
    },
    npc =
    {
        CASKET_BASE   = 17212023,
        OVERSEER_BASE = 17212060,
    },
}

return zones[tpz.zone.NORTH_GUSTABERG]
