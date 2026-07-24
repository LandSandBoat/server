-----------------------------------
-- Area: Gusgen Mines (196)
-----------------------------------
zones = zones or {}

zones[xi.zone.GUSGEN_MINES] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6423,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7016,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7137,  -- San d'Oria's region points have increased!
        FISHING_MESSAGE_OFFSET        = 7231,  -- You can't fish here.
        DEVICE_NOT_WORKING            = 7346,  -- The device is not working.
        SYS_OVERLOAD                  = 7355,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7360,  -- You lost the <item>.
        LOCK_OTHER_DEVICE             = 7363,  -- This entrance's lock is connected to some other device.
        SEE_MONSTER_TRACKS            = 7364,  -- You see monster tracks on the ground.
        FRESH_MONSTER_TRACKS          = 7365,  -- You see fresh monster tracks on the ground.
        NOTHING_SEEMS_HAPPENING       = 7366,  -- Nothing seems to be happening.
        YOU_PUT_ITEM_DOWN             = 7367,  -- You put <item> down.
        MINING_IS_POSSIBLE_HERE       = 7383,  -- Mining is possible here if you have <item>.
        CHEST_UNLOCKED                = 7398,  -- You unlock the chest!
        LETTERS_IS_WRITTEN_HERE       = 7406,  -- Something resembling letters is written here.
        FOUND_LOCATION_SEAL           = 7407,  -- You have found the location of the seal. You place <item> on it.
        IS_ON_THIS_SEAL               = 7408,  -- <item> is on this seal.
        SMALL_OPENING                 = 7409,  -- There is a small opening here.
        YOU_CANNOT_EVEN_DIG           = 7410,  -- You cannot even dig it open with <item>.
        PLAYER_OBTAINS_ITEM           = 8321,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8322,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8323,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8324,  -- You already possess that temporary item.
        NO_COMBINATION                = 8329,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10407, -- New training regime registered!
        LEARNS_SPELL                  = 11455, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 11457, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 11492, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        QM_RSE         = GetFirstID('qm1'),
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
        MINING         = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.GUSGEN_MINES]
