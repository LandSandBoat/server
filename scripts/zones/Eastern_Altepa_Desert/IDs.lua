-----------------------------------
-- Area: Eastern_Altepa_Desert
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.EASTERN_ALTEPA_DESERT] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6382,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6388,  -- Obtained: <item>.
        GIL_OBTAINED             = 6389,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6392,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6402,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING      = 6403,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET    = 6417,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7049,  -- Tallying conquest results...
        BEASTMEN_BANNER          = 7130,  -- There is a beastmen's banner.
        CONQUEST                 = 7217,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET   = 7550,  -- You can't fish here.
        DIG_THROW_AWAY           = 7563,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7565,  -- You dig and you dig, but find nothing.
        ALREADY_OBTAINED_TELE    = 7659,  -- You already possess the gate crystal for this telepoint.
        PLAYER_OBTAINS_ITEM      = 7759,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7760,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7761,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7762,  -- You already possess that temporary item.
        NO_COMBINATION           = 7767,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9945,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 11081, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DUNE_WIDOW_PH     =
        {
            [17244395] = 17244396,
        },
        DONNERGUGI_PH     =
        {
            [17244258] = 17244268,
            [17244263] = 17244268,
        },
        CENTURIO_XII_I    = 17244372,
        NANDI             = 17244471,
        DECURIO_I_III     = 17244523,
        TSUCHIGUMO_OFFSET = 17244524,
        CACTROT_RAPIDO    = 17244539,
    },
    npc =
    {
        CASKET_BASE   = 17244596,
        OVERSEER_BASE = 17244627,
    },
}

return zones[tpz.zone.EASTERN_ALTEPA_DESERT]
