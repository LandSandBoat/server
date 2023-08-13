-----------------------------------
-- Area: Gusgen Mines (196)
-----------------------------------
zones = zones or {}

zones[xi.zone.GUSGEN_MINES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7012,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7219,  -- You can't fish here.
        DEVICE_NOT_WORKING            = 7333,  -- The device is not working.
        SYS_OVERLOAD                  = 7342,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7347,  -- You lost the <item>.
        LOCK_OTHER_DEVICE             = 7350,  -- This entrance's lock is connected to some other device.
        SEE_MONSTER_TRACKS            = 7351,  -- You see monster tracks on the ground.
        FRESH_MONSTER_TRACKS          = 7352,  -- You see fresh monster tracks on the ground.
        NOTHING_SEEMS_HAPPENING       = 7353,  -- Nothing seems to be happening.
        YOU_PUT_ITEM_DOWN             = 7354,  -- You put <item> down.
        MINING_IS_POSSIBLE_HERE       = 7370,  -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED                = 7385,  -- You unlock the chest!
        LETTERS_IS_WRITTEN_HERE       = 7393,  -- Something resembling letters is written here.
        FOUND_LOCATION_SEAL           = 7394,  -- You have found the location of the seal. You place <item> on it.
        IS_ON_THIS_SEAL               = 7395,  -- <item> is on this seal.
        PLAYER_OBTAINS_ITEM           = 8308,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8309,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8310,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8311,  -- You already possess that temporary item.
        NO_COMBINATION                = 8316,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10394, -- New training regime registered!
        LEARNS_SPELL                  = 11442, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11444, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11479, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BLIND_MOBY          = 17580038,
        WANDERING_GHOST     = 17580337,
        PUDDING_OFFSET      = 17580338,
        APPARATUS_ELEMENTAL = 17580340,
        AROMA_FLY           = 17580341,
        ASPHYXIATED_AMSEL   = 17580044,
        BURNED_BERGMANN     = 17580042,
        CRUSHED_KRAUSE      = 17580040,
        PULVERIZED_PFEFFER  = 17580041,
        SMOTHERED_SCHMIDT   = 17580039,
        WOUNDED_WURFEL      = 17580043,
    },
    npc =
    {
        TREASURE_CHEST = 17580403,
        MINING         = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.GUSGEN_MINES]
