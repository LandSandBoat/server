-----------------------------------
-- Area: Gusgen Mines (196)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.GUSGEN_MINES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6389,  -- Obtained: <item>.
        GIL_OBTAINED             = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6403,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7000,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED     = 7011,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        CONQUEST_BASE            = 7053,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7212,  -- You can't fish here.
        DEVICE_NOT_WORKING       = 7326,  -- The device is not working.
        SYS_OVERLOAD             = 7335,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE             = 7340,  -- You lost the <item>.
        LOCK_OTHER_DEVICE        = 7343,  -- This entrance's lock is connected to some other device.
        MINING_IS_POSSIBLE_HERE  = 7363,  -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED           = 7378,  -- You unlock the chest!
        LETTERS_IS_WRITTEN_HERE  = 7386,  -- Something resembling letters is written here.
        FOUND_LOCATION_SEAL      = 7387,  -- You have found the location of the seal. You place <item> on it.
        IS_ON_THIS_SEAL          = 7388,  -- <item> is on this seal.
        PLAYER_OBTAINS_ITEM      = 8301,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8302,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8303,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8304,  -- You already possess that temporary item.
        NO_COMBINATION           = 8309,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10387, -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 11472, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BLIND_MOBY          = 17580038,
        WANDERING_GHOST     = 17580337,
        PUDDING_OFFSET      = 17580338,
        APPARATUS_ELEMENTAL = 17580340,
        AROMA_FLY           = 17580341,
    },
    npc =
    {
        CASKET_BASE    = 17580348,
        TREASURE_CHEST = 17580403,
        MINING =
        {
            17580397,
            17580398,
            17580399,
            17580400,
            17580401,
            17580402,
        },
    },
}

return zones[xi.zone.GUSGEN_MINES]
