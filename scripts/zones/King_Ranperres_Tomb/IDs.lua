-----------------------------------
-- Area: King Ranperres Tomb (190)
-----------------------------------
zones = zones or {}

zones[xi.zone.KING_RANPERRES_TOMB] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6543,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6549,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6550,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6552,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6578,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7160,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7161,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7162,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7171,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7182,  -- Your party is unable to participate because certain members' levels are restricted.
        CHEST_UNLOCKED                = 7290,  -- You unlock the chest!
        SENSE_SOMETHING_EVIL          = 7317,  -- You sense something evil.
        HEAVY_DOOR                    = 7318,  -- It is a solid stone door.
        PLAYER_OBTAINS_ITEM           = 8256,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8257,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8258,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8259,  -- You already possess that temporary item.
        NO_COMBINATION                = 8264,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10342, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11429, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        GWYLLGI_PH            =
        {
            [17555661] = 17555664,
        },
        CRYPT_GHOST_PH        =
        {
            [17555665] = 17555668,
            [17555666] = 17555668,
            [17555667] = 17555668,
        },
        BARBASTELLE           = 17555721,
        CHERRY_SAPLING_OFFSET = 17555748,
        VRTRA                 = 17555763,
        CORRUPTED_YORGOS      = 17555770,
        CORRUPTED_SOFFEIL     = 17555771,
        CORRUPTED_ULBRIG      = 17555772,
        ANKOU                 = 17555709,
    },
    npc =
    {
        TREASURE_CHEST = 17555966,
    },
}

return zones[xi.zone.KING_RANPERRES_TOMB]
