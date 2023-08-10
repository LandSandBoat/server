-----------------------------------
-- Area: Toraimarai Canal (169)
-----------------------------------
zones = zones or {}

zones[xi.zone.TORAIMARAI_CANAL] =
{
    text =
    {
        SEALED_SHUT                   = 3,     -- It's sealed shut with incredibly strong magic.
        ITEM_CANNOT_BE_OBTAINED       = 6430,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6436,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6437,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6439,  -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6465,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7047,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7048,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7049,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7058,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7069,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7106,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7265,  -- You can't fish here.
        CHEST_UNLOCKED                = 7373,  -- You unlock the chest!
        PLAYER_OBTAINS_ITEM           = 7542,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7543,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7544,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7545,  -- You already possess that temporary item.
        NO_COMBINATION                = 7550,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 9628,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 10676, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        HOMEPOINT_SET                 = 10704, -- Home point set!
    },
    mob =
    {
        CANAL_MOOCHER_PH =
        {
            [17469575] = 17469578,
            [17469576] = 17469578,
            [17469577] = 17469578,
        },
        KONJAC_PH =
        {
            [17469629] = 17469632,
            [17469630] = 17469632,
            [17469631] = 17469632,
        },
        MAGIC_SLUDGE      = 17469516,
        HINGE_OILS_OFFSET = 17469666,
        MIMIC             = 17469761,
    },
    npc =
    {
        TOME_OF_MAGIC_OFFSET = 17469828,
        TREASURE_COFFER      = 17469835,
    },
}

return zones[xi.zone.TORAIMARAI_CANAL]
