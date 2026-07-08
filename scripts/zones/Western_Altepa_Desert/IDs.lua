-----------------------------------
-- Area: Western_Altepa_Desert
-----------------------------------
zones = zones or {}

zones[xi.zone.WESTERN_ALTEPA_DESERT] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6390,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6403,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6423,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7231,  -- You can't fish here.
        DIG_THROW_AWAY                = 7244,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7246,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7312,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE          = 7321,  -- It appears your chocobo found this item with ease.
        THE_DOOR_IS_LOCKED            = 7352,  -- The door is locked.
        DOES_NOT_RESPOND              = 7353,  -- It does not respond.
        CANNOT_REMOVE_FRAG            = 7369,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7370,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS        = 7371,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS               = 7372,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7373,  -- It is an ancient Zilart monument.
        FEEL_SOMETHING_PRICKLY        = 7391,  -- You feel something prickly...
        MANY_STONES_LITTER_AREA       = 7392,  -- Many stones litter the area.
        EVIL_LOOMING_ABOVE_YOU        = 7393,  -- You sense something evil looming above you.
        SENSE_OMINOUS_PRESENCE        = 7414,  -- You sense an ominous presence...
        SOMETHING_IS_BURIED_HERE      = 7432,  -- It looks like something is buried here. If you had <item> you could dig it up.
        PLAYER_OBTAINS_ITEM           = 7652,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7653,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7654,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7655,  -- You already possess that temporary item.
        NO_COMBINATION                = 7660,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7722,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9838,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11827, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
