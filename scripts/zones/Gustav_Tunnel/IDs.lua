-----------------------------------
-- Area: Gustav Tunnel (212)
-----------------------------------
zones = zones or {}

zones[xi.zone.GUSTAV_TUNNEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6396,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6409,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6424,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7006,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7017,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7073,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7232,  -- You can't fish here.
        BAD_FEELING_ABOUT_PLACE       = 7333,  -- You have a bad feeling about this place.
        SENSE_OMINOUS_PRESENCE        = 7335,  -- You sense an ominous presence...
        UNITY_WANTED_BATTLE_INTERACT  = 7456,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9603,  -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 10655, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 10656, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 10657, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 10658, -- You already possess that temporary item.
        NO_COMBINATION                = 10663, -- You were unable to enter a combination.
        COMMON_SENSE_SURVIVAL         = 10687, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        GOBLINSAVIOR_HERONOX   = GetFirstID('Goblinsavior_Heronox'),
        WYVERNPOACHER_DRACHLOX = GetFirstID('Wyvernpoacher_Drachlox'),
        BAOBHAN_SITH           = GetFirstID('Baobhan_Sith'),
        TAXIM                  = GetFirstID('Taxim'),
        UNGUR                  = GetFirstID('Ungur'),
        AMIKIRI                = GetFirstID('Amikiri'),
        BUNE                   = GetFirstID('Bune'),
        GIGAPLASM              = GetFirstID('Gigaplasm'),
        BARONIAL_BAT           = GetFirstID('Baronial_Bat'),
    },
    npc =
    {
    },
}

return zones[xi.zone.GUSTAV_TUNNEL]
