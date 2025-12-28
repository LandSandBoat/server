-----------------------------------
-- Area: The_Sanctuary_of_ZiTah
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_SANCTUARY_OF_ZITAH] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6389,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6400,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6405,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6406,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6420,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7002,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7068,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7149,  -- There is a beastmen's banner.
        CONQUEST                      = 7236,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7569,  -- You can't fish here.
        DIG_THROW_AWAY                = 7582,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7584,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7650,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE          = 7659,  -- It appears your chocobo found this item with ease.
        AIR_HAS_SUDDENLY_CHANGED      = 7751,  -- The air around you has suddenly changed!
        SOMETHING_BETTER              = 7752,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7755,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7756,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        FOUND_ALL_FRAGS               = 7758,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7759,  -- It is an ancient Zilart monument.
        AIR_REMAINS_STAGNANT          = 7771,  -- The air in this area remains stagnant. You begin to feel sick... It would be wise to leave immediately.
        LOOKS_LIKE_STURDY_BRANCH      = 7781,  -- This looks like a sturdy branch. You will need <item> to cut it off.
        BEAUTIFUL_STURDY_BRANCH       = 7782,  -- It is a beautiful, sturdy branch.
        SENSE_STRONG_EVIL_PRESENCE    = 7784,  -- You can sense a strong, evil presence!
        STRANGE_FORCE_PREVENTS        = 7785,  -- Some strange force is preventing you from cutting all the way through.
        STRANGE_FORCE_VANISHED        = 7786,  -- The strange force has vanished, and <item> has newly sprouted in the cut!
        NO_LONGER_SENSE_EVIL          = 7787,  -- You no longer sense the evil presence, but there is still a feeling of unrest throughout the forest.
        NEWLY_SPROUTED_GLOWING        = 7788,  -- The newly sprouted <item> is glowing softly. You no longer feel as if you are being watched.
        NOT_THE_TIME_FOR_THAT         = 7789,  -- This is not the time for that!
        SENSE_OMINOUS_PRESENCE        = 7862,  -- You sense an ominous presence...
        GARRISON_BASE                 = 8049,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 8096,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8097,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8098,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8099,  -- You already possess that temporary item.
        NO_COMBINATION                = 8104,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 8166,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10282, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 12271, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        KEEPER_OF_HALIDOM = GetFirstID('Keeper_of_Halidom'),
        NOBLE_MOLD        = GetFirstID('Noble_Mold'),
        GUARDIAN_TREANT   = GetFirstID('Guardian_Treant'),
        DOOMED_PILGRIMS   = GetFirstID('Doomed_Pilgrims'),
        ISONADE           = GetFirstID('Isonade'),
        GREENMAN          = GetFirstID('Greenman'),
    },
    npc =
    {
        OVERSEER_BASE     = GetFirstID('Credaurion_RK'),
        CERMET_HEADSTONE  = GetFirstID('Cermet_Headstone'),
    },
}

return zones[xi.zone.THE_SANCTUARY_OF_ZITAH]
