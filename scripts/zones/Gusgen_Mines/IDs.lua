-----------------------------------
-- Area: Gusgen Mines (196)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.GUSGEN_MINES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6382,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6388,  -- Obtained: <item>.
        GIL_OBTAINED             = 6389,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6402,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6417,  -- I'm ready. I suppose.
        GEOMAGNETRON_ATTUNED     = 7010,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        CONQUEST_BASE            = 7049,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7208,  -- You can't fish here.
        DEVICE_NOT_WORKING       = 7322,  -- The device is not working.
        SYS_OVERLOAD             = 7331,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE             = 7336,  -- You lost the <item>.
        LOCK_OTHER_DEVICE        = 7339,  -- This entrance's lock is connected to some other device.
        MINING_IS_POSSIBLE_HERE  = 7359,  -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED           = 7374,  -- You unlock the chest!
        LETTERS_IS_WRITTEN_HERE  = 7382,  -- Something resembling letters is written here.
        FOUND_LOCATION_SEAL      = 7383,  -- You have found the location of the seal. You place <item> on it.
        IS_ON_THIS_SEAL          = 7384,  -- <item> is on this seal.
        PLAYER_OBTAINS_ITEM      = 8297,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 8298,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 8299,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 8300,  -- You already possess that temporary item.
        NO_COMBINATION           = 8305,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 10383, -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 11468, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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

return zones[tpz.zone.GUSGEN_MINES]
