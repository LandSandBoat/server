-----------------------------------
-- Area: Eastern_Altepa_Desert
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.EASTERN_ALTEPA_DESERT] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6389,  -- Obtained: <item>.
        GIL_OBTAINED             = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST             = 6393,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6403,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING      = 6404,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET    = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7000,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7050,  -- Tallying conquest results...
        BEASTMEN_BANNER          = 7131,  -- There is a beastmen's banner.
        CONQUEST                 = 7218,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET   = 7551,  -- You can't fish here.
        DIG_THROW_AWAY           = 7564,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7566,  -- You dig and you dig, but find nothing.
        ALREADY_OBTAINED_TELE    = 7660,  -- You already possess the gate crystal for this telepoint.
        PLAYER_OBTAINS_ITEM      = 7778,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7779,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7780,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7781,  -- You already possess that temporary item.
        NO_COMBINATION           = 7786,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9964,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 11100, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        CASKET_BASE   = 17244595,
        OVERSEER_BASE = 17244626, -- Eaulevisat_RK in npc_list
    },
}

return zones[xi.zone.EASTERN_ALTEPA_DESERT]
