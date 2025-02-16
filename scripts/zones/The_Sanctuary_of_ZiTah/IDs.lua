-----------------------------------
-- Area: The_Sanctuary_of_ZiTah
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_SANCTUARY_OF_ZITAH] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6399,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7065,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7146,  -- There is a beastmen's banner.
        CONQUEST                      = 7233,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7566,  -- You can't fish here.
        DIG_THROW_AWAY                = 7579,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7581,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7647,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE          = 7656,  -- It appears your chocobo found this item with ease.
        AIR_HAS_SUDDENLY_CHANGED      = 7748,  -- The air around you has suddenly changed!
        SOMETHING_BETTER              = 7749,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7752,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7753,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        FOUND_ALL_FRAGS               = 7755,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7756,  -- It is an ancient Zilart monument.
        AIR_REMAINS_STAGNANT          = 7768,  -- The air in this area remains stagnant. You begin to feel sick... It would be wise to leave immediately.
        LOOKS_LIKE_STURDY_BRANCH      = 7778,  -- This looks like a sturdy branch. You will need <item> to cut it off.
        BEAUTIFUL_STURDY_BRANCH       = 7779,  -- It is a beautiful, sturdy branch.
        SENSE_STRONG_EVIL_PRESENCE    = 7781,  -- You can sense a strong, evil presence!
        STRANGE_FORCE_PREVENTS        = 7782,  -- Some strange force is preventing you from cutting all the way through.
        STRANGE_FORCE_VANISHED        = 7783,  -- The strange force has vanished, and <item> has newly sprouted in the cut!
        NO_LONGER_SENSE_EVIL          = 7784,  -- You no longer sense the evil presence, but there is still a feeling of unrest throughout the forest.
        NEWLY_SPROUTED_GLOWING        = 7785,  -- The newly sprouted <item> is glowing softly. You no longer feel as if you are being watched.
        NOT_THE_TIME_FOR_THAT         = 7786,  -- This is not the time for that!
        SENSE_OMINOUS_PRESENCE        = 7859,  -- You sense an ominous presence...
        GARRISON_BASE                 = 8046,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 8093,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8094,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8095,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8096,  -- You already possess that temporary item.
        NO_COMBINATION                = 8101,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 8163,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10279, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 12268, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
