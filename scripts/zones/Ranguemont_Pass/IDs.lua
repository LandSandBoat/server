-----------------------------------
-- Area: Ranguemont Pass (166)
-----------------------------------
zones = zones or {}

zones[xi.zone.RANGUEMONT_PASS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6409,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6410,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6424,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7017,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7073,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7232,  -- You can't fish here.
        WATERS_OF_OBLIVION            = 7375,  -- You behold the Waters of Oblivion.
        REGIME_REGISTERED             = 9543,  -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 10595, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 10596, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 10597, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 10598, -- You already possess that temporary item.
        NO_COMBINATION                = 10603, -- You were unable to enter a combination.
        COMMON_SENSE_SURVIVAL         = 10694, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        GLOOM_EYE    = GetFirstID('Gloom_Eye'),
        HYAKUME      = GetFirstID('Hyakume'),
        TAISAIJIN    = GetFirstID('Taisaijin'),
        TROS         = GetFirstID('Tros'),
    },
    npc =
    {
    },
}

return zones[xi.zone.RANGUEMONT_PASS]
