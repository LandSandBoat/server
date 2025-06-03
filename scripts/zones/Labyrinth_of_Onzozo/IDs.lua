-----------------------------------
-- Area: Labyrinth of Onzozo (213)
-----------------------------------
zones = zones or {}

zones[xi.zone.LABYRINTH_OF_ONZOZO] =
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
        CHEST_UNLOCKED                = 7335,  -- You unlock the chest!
        NEST_OF_LARGE_BIRD            = 7343,  -- It looks like the nest of a very large bird.
        SENSE_OMINOUS_PRESENCE        = 7351,  -- You sense an ominous presence...
        REGIME_REGISTERED             = 9407,  -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 10459, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 10460, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 10461, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 10462, -- You already possess that temporary item.
        NO_COMBINATION                = 10467, -- You were unable to enter a combination.
        COMMON_SENSE_SURVIVAL         = 10491, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        UNITY_WANTED_BATTLE_INTERACT  = 10555, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        LORD_OF_ONZOZO       = GetFirstID('Lord_of_Onzozo'),
        OSE                  = GetFirstID('Ose'),
        SOULSTEALER_SKULLNIX = GetFirstID('Soulstealer_Skullnix'),
        NARASIMHA            = GetFirstID('Narasimha'),
        HELLION              = GetFirstID('Hellion'),
        PEG_POWLER           = GetFirstID('Peg_Powler'),
        MYSTICMAKER_PROFBLIX = GetFirstID('Mysticmaker_Profblix'),
        UBUME                = GetFirstID('Ubume'),
        MEGAPOD_MEGALOPS     = GetFirstID('Megapod_Megalops'),
    },
    npc =
    {
        TREASURE_CHEST = GetFirstID('Treasure_Chest'),
    },
}

return zones[xi.zone.LABYRINTH_OF_ONZOZO]
