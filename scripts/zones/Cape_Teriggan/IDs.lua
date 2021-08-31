-----------------------------------
-- Area: Cape_Teriggan
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.CAPE_TERIGGAN] =
{
    text =
    {
        NOTHING_HAPPENS            = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED    = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE = 6387,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED              = 6389,  -- Obtained: <item>.
        GIL_OBTAINED               = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6392,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST               = 6393,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED             = 6398,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY    = 6403,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET      = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS        = 7000,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7001,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7002,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE              = 7053,  -- Tallying conquest results...
        BEASTMEN_BANNER            = 7134,  -- There is a beastmen's banner.
        CONQUEST                   = 7221,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET     = 7554,  -- You can't fish here.
        SOMETHING_BETTER           = 7666,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG         = 7669,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG      = 7670,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        FOUND_ALL_FRAGS            = 7671,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        ZILART_MONUMENT            = 7673,  -- It is an ancient Zilart monument.
        SENSE_OMINOUS_PRESENCE     = 7690,  -- You sense an ominous presence...
        PLAYER_OBTAINS_ITEM        = 7924,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM      = 7925,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM   = 7926,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP       = 7927,  -- You already possess that temporary item.
        NO_COMBINATION             = 7932,  -- You were unable to enter a combination.
        REGIME_REGISTERED          = 10110, -- New training regime registered!
        COMMON_SENSE_SURVIVAL      = 11229, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        HOMEPOINT_SET              = 11257, -- Home point set!
    },
    mob =
    {
        FROSTMANE_PH           =
        {
            [17240374] = 17240376, -- -283.874 -0.660 485.504
            [17240372] = 17240376, -- -272.224 -0.942 461.321
            [17240373] = 17240376, -- -268.000 -0.558 440.000
            [17240371] = 17240376, -- -262.000 -0.700 442.000
        },
        KREUTZET               = 17240413,
        AXESARION_THE_WANDERER = 17240414,
        STOLAS                 = 17240424,
    },
    npc =
    {
        CASKET_BASE      = 17240445,
        OVERSEER_BASE    = 17240472,
        CERMET_HEADSTONE = 17240497,
    },
}

return zones[xi.zone.CAPE_TERIGGAN]
