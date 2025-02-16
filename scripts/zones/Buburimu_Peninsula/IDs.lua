-----------------------------------
-- Area: Buburimu_Peninsula
-----------------------------------
zones = zones or {}

zones[xi.zone.BUBURIMU_PENINSULA] =
{
    text =
    {
        NOTHING_HAPPENS                = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED        = 6419,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6425,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6426,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6428,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6429,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET          = 6454,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7036,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7037,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 7038,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 7058,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                  = 7100,  -- Tallying conquest results...
        BEASTMEN_BANNER                = 7181,  -- There is a beastmen's banner.
        FIVEOFSPADES_DIALOG            = 7259,  -- GiMmefIvE! FiVe isA cArdIanOF WiN-DuRst! FIvEiS OnpA-tRol!
        FISHING_MESSAGE_OFFSET         = 7265,  -- You can't fish here.
        DIG_THROW_AWAY                 = 7278,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                   = 7280,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET             = 7346,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE           = 7355,  -- It appears your chocobo found this item with ease.
        SONG_RUNES_DEFAULT             = 7385,  -- An old momument. A melancholy song of two separated lovers is written upon it.
        SONG_RUNES_REQUIRE             = 7399,  -- If only you had <item>, you could jot down the lyrics.
        SONG_RUNES_WRITING             = 7400,  -- You write down the lyrics on the <item>.
        SIGN_1                         = 7407,  -- West: Tahrongi Canyon Southeast: Mhaura
        SIGN_2                         = 7408,  -- West: Tahrongi Canyon South: Mhaura
        SIGN_3                         = 7409,  -- West: Tahrongi Canyon Southwest: Mhaura
        SIGN_4                         = 7410,  -- West: Mhaura and Tahrongi Canyon
        SIGN_5                         = 7411,  -- West: Mhaura Northwest: Tahrongi Canyon
        LOGGING_IS_POSSIBLE_HERE       = 7412,  -- Logging is possible here if you have <item>.
        CONQUEST                       = 7428,  -- You've earned conquest points!
        GARRISON_BASE                  = 7798,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        TIME_ELAPSED                   = 7891,  -- Time Elapsed: / [hour/hours] (Vanadiel Time) / [minute/minutes] and [second/seconds] (Earth time)
        YOU_CANNOT_ENTER_DYNAMIS       = 7904,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7906,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 8028,  -- There is a strange symbol drawn here. A haunting chill sweeps through you as you gaze upon it...
        PLAYER_OBTAINS_ITEM            = 8116,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8117,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8118,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8119,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8124,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT   = 8186,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED              = 10302, -- New training regime registered!
        COMMON_SENSE_SURVIVAL          = 12323, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BACKOO     = GetFirstID('Backoo'),
        BUBURIMBOO = GetFirstID('Buburimboo'),
        HELLDIVER  = GetFirstID('Helldiver'),
    },
    npc =
    {
        LOGGING         = GetTableOfIDs('Logging_Point'),
        OVERSEER_BASE   = GetFirstID('Bonbavour_RK'),
        SIGNPOST_OFFSET = GetFirstID('Signpost'),
    },
}

return zones[xi.zone.BUBURIMU_PENINSULA]
