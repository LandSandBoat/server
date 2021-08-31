-----------------------------------
-- Area: Crawlers_Nest
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.CRAWLERS_NEST] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        DEVICE_NOT_WORKING            = 173,   -- The device is not working.
        SYS_OVERLOAD                  = 182,   -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 187,   -- You lost the <item>.
        ITEM_CANNOT_BE_OBTAINED       = 6573,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6579,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6580,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6582,  -- Obtained key item: <keyitem>.
        SENSE_OF_FOREBODING           = 6594,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6608,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7190,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7191,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7192,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7201,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        CHEST_UNLOCKED                = 7256,  -- You unlock the chest!
        SOMEONE_HAS_BEEN_DIGGING_HERE = 7264,  -- Someone has been digging here.
        EQUIPMENT_NOT_PURIFIED        = 7265,  -- Your equipment has not been completely purified.
        YOU_BURY_THE                  = 7267,  -- You bury the <item> and <item>.
        NOTHING_WILL_HAPPEN_YET       = 7270,  -- It seems that nothing will happen yet.
        NOTHING_SEEMS_TO_HAPPEN       = 7271,  -- Nothing seems to happen.
        PLAYER_OBTAINS_ITEM           = 7346,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7347,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7348,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7349,  -- You already possess that temporary item.
        NO_COMBINATION                = 7354,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9432,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11384, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DEMONIC_TIPHIA_PH =
        {
            [17584392] = 17584398, -- -103.000 -1.000 311.000
            [17584395] = 17584398, -- -89.000 -1.000 301.000
            [17584396] = 17584398, -- -75.000 -1.000 299.000
            [17584391] = 17584398, -- -101.000 -1.000 285.000
        },
        AWD_GOGGIE          = 17584135,
        DYNAST_BEETLE       = 17584312,
        DREADBUG            = 17584425,
        MIMIC               = 17584426,
        APPARATUS_ELEMENTAL = 17584427,
    },
    npc =
    {
        CASKET_BASE     = 17584433,
        TREASURE_CHEST  = 17584475,
        TREASURE_COFFER = 17584476,
    },
}

return zones[xi.zone.CRAWLERS_NEST]
