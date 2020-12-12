-----------------------------------
-- Area: The_Sanctuary_of_ZiTah
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.THE_SANCTUARY_OF_ZITAH] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED    = 6382,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE = 6386,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED              = 6388,  -- Obtained: <item>.
        GIL_OBTAINED               = 6389,  -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6391,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST               = 6392,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED             = 6397,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY    = 6402,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING        = 6403,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET      = 6417,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS        = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE              = 7049,  -- Tallying conquest results...
        BEASTMEN_BANNER            = 7130,  -- There is a beastmen's banner.
        CONQUEST                   = 7217,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET     = 7550,  -- You can't fish here.
        DIG_THROW_AWAY             = 7563,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING               = 7565,  -- You dig and you dig, but find nothing.
        SOMETHING_BETTER           = 7733,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG         = 7736,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG      = 7737,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        FOUND_ALL_FRAGS            = 7739,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT            = 7740,  -- It is an ancient Zilart monument.
        STURDY_BRANCH              = 7763,  -- It is a beautiful, sturdy branch.
        SENSE_OMINOUS_PRESENCE     = 7861,  -- You sense an ominous presence...
        PLAYER_OBTAINS_ITEM        = 8095,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM      = 8096,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM   = 8097,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP       = 8098,  -- You already possess that temporary item.
        NO_COMBINATION             = 8103,  -- You were unable to enter a combination.
        REGIME_REGISTERED          = 10281, -- New training regime registered!
        COMMON_SENSE_SURVIVAL      = 12270, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        KEEPER_OF_HALIDOM_PH =
        {
            [17272977] = 17272978, -- 319.939 -0.037 187.231
        },
        NOBLE_MOLD_PH   =
        {
            [17273276] = 17273278, -- -391.184 -0.269 -159.086
            [17273277] = 17273278, -- -378.456 0.425 -162.489
        },
        GUARDIAN_TREANT = 17272838,
        DOOMED_PILGRIMS = 17272839,
        NOBLE_MOLD      = 17273278,
        ISONADE         = 17273285,
        GREENMAN        = 17273295,
    },
    npc =
    {
        CASKET_BASE      = 17273337,
        OVERSEER_BASE    = 17273364, -- Credaurion_RK in npc_list
        CERMET_HEADSTONE = 17273389,
    },
}

return zones[tpz.zone.THE_SANCTUARY_OF_ZITAH]
