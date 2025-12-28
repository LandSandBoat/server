-----------------------------------
-- Area: Western_Altepa_Desert
-----------------------------------
zones = zones or {}

zones[xi.zone.WESTERN_ALTEPA_DESERT] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6389,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6400,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6405,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6420,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7002,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7068,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7227,  -- You can't fish here.
        DIG_THROW_AWAY                = 7240,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7242,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7308,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE          = 7317,  -- It appears your chocobo found this item with ease.
        THE_DOOR_IS_LOCKED            = 7347,  -- The door is locked.
        DOES_NOT_RESPOND              = 7348,  -- It does not respond.
        CANNOT_REMOVE_FRAG            = 7364,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7365,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS        = 7366,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS               = 7367,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7368,  -- It is an ancient Zilart monument.
        FEEL_SOMETHING_PRICKLY        = 7386,  -- You feel something prickly...
        MANY_STONES_LITTER_AREA       = 7387,  -- Many stones litter the area.
        EVIL_LOOMING_ABOVE_YOU        = 7388,  -- You sense something evil looming above you.
        SENSE_OMINOUS_PRESENCE        = 7409,  -- You sense an ominous presence...
        SOMETHING_IS_BURIED_HERE      = 7427,  -- It looks like something is buried here. If you had <item> you could dig it up.
        PLAYER_OBTAINS_ITEM           = 7647,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7648,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7649,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7650,  -- You already possess that temporary item.
        NO_COMBINATION                = 7655,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7717,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9833,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11822, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        CACTUAR_CANTAUTOR    = GetFirstID('Cactuar_Cantautor'),
        CALCHAS              = GetFirstID('Calchas'),
        CELPHIE              = GetFirstID('Celphie'),
        DAHU                 = GetFirstID('Dahu'),
        EASTERN_SPHINX       = GetFirstID('Eastern_Sphinx'),
        KING_VINEGARROON     = GetFirstID('King_Vinegarroon'),
        MAHARAJA             = GetFirstID('Maharaja'),
        PICOLATON            = GetFirstID('Picolaton'),
        SABOTENDER_ENAMORADO = GetFirstID('Sabotender_Enamorado'),
        WESTERN_SPHINX       = GetFirstID('Western_Sphinx'),
    },
    npc =
    {
        ALTEPA_GATE              = GetFirstID('_3h0'),
        PEDDLESTOX               = GetFirstID('Peddlestox'),
        BEASTMEN_TREASURE_OFFSET = GetFirstID('qm3'),
    },
}

return zones[xi.zone.WESTERN_ALTEPA_DESERT]
