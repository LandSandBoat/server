-----------------------------------
-- Area: Gusgen Mines (196)
-----------------------------------
zones = zones or {}

zones[xi.zone.GUSGEN_MINES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6420,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7002,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7013,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7068,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7227,  -- You can't fish here.
        DEVICE_NOT_WORKING            = 7341,  -- The device is not working.
        SYS_OVERLOAD                  = 7350,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7355,  -- You lost the <item>.
        LOCK_OTHER_DEVICE             = 7358,  -- This entrance's lock is connected to some other device.
        SEE_MONSTER_TRACKS            = 7359,  -- You see monster tracks on the ground.
        FRESH_MONSTER_TRACKS          = 7360,  -- You see fresh monster tracks on the ground.
        NOTHING_SEEMS_HAPPENING       = 7361,  -- Nothing seems to be happening.
        YOU_PUT_ITEM_DOWN             = 7362,  -- You put <item> down.
        MINING_IS_POSSIBLE_HERE       = 7378,  -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED                = 7393,  -- You unlock the chest!
        LETTERS_IS_WRITTEN_HERE       = 7401,  -- Something resembling letters is written here.
        FOUND_LOCATION_SEAL           = 7402,  -- You have found the location of the seal. You place <item> on it.
        IS_ON_THIS_SEAL               = 7403,  -- <item> is on this seal.
        PLAYER_OBTAINS_ITEM           = 8316,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8317,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8318,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8319,  -- You already possess that temporary item.
        NO_COMBINATION                = 8324,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10402, -- New training regime registered!
        LEARNS_SPELL                  = 11450, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11452, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11487, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BLIND_MOBY          = GetFirstID('Blind_Moby'),
        WANDERING_GHOST     = GetFirstID('Wandering_Ghost'),
        PUDDING_OFFSET      = GetFirstID('Pudding'),
        AROMA_FLY           = GetFirstID('Aroma_Fly'),
        ASPHYXIATED_AMSEL   = GetFirstID('Asphyxiated_Amsel'),
        BURNED_BERGMANN     = GetFirstID('Burned_Bergmann'),
        CRUSHED_KRAUSE      = GetFirstID('Crushed_Krause'),
        PULVERIZED_PFEFFER  = GetFirstID('Pulverized_Pfeffer'),
        SMOTHERED_SCHMIDT   = GetFirstID('Smothered_Schmidt'),
        WOUNDED_WURFEL      = GetFirstID('Wounded_Wurfel'),
        APPARATUS_ELEMENTAL = GetTableOfIDs('Earth_Elemental')[3], -- Last elemental in the list
    },
    npc =
    {
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
        MINING         = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.GUSGEN_MINES]
