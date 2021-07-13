-----------------------------------
-- Area: Buburimu_Peninsula
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BUBURIMU_PENINSULA] =
{
    text =
    {
        NOTHING_HAPPENS                = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED        = 6418,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6424,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6425,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6427,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6428,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET          = 6453,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7035,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7036,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 7037,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                  = 7088,  -- Tallying conquest results...
        BEASTMEN_BANNER                = 7169,  -- There is a beastmen's banner.
        FIVEOFSPADES_DIALOG            = 7247,  -- GiMmefIvE! FiVe isA cArdIanOF WiN-DuRst! FIvEiS OnpA-tRol!
        FISHING_MESSAGE_OFFSET         = 7253,  -- You can't fish here.
        DIG_THROW_AWAY                 = 7266,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                   = 7268,  -- You dig and you dig, but find nothing.
        SONG_RUNES_DEFAULT             = 7373,  -- An old momument. A melancholy song of two separated lovers is written upon it.
        SONG_RUNES_REQUIRE             = 7387,  -- If only you had <item>, you could jot down the lyrics.
        SONG_RUNES_WRITING             = 7388,  -- You write down the lyrics on the <item>.
        SIGN_1                         = 7395,  -- West: Tahrongi Canyon Southeast: Mhaura
        SIGN_2                         = 7396,  -- West: Tahrongi Canyon South: Mhaura
        SIGN_3                         = 7397,  -- West: Tahrongi Canyon Southwest: Mhaura
        SIGN_4                         = 7398,  -- West: Mhaura and Tahrongi Canyon
        SIGN_5                         = 7399,  -- West: Mhaura Northwest: Tahrongi Canyon
        LOGGING_IS_POSSIBLE_HERE       = 7400,  -- Logging is possible here if you have <item>.
        CONQUEST                       = 7416,  -- You've earned conquest points!
        YOU_CANNOT_ENTER_DYNAMIS       = 7910,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        DYNA_NPC_DEFAULT_MESSAGE       = 7911,  -- You hear a mysterious, floating voice: The guiding aura has not yet faded... Bring forth the <item>.
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7912,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        PLAYER_OBTAINS_ITEM            = 8122,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8123,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8124,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8125,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8130,  -- You were unable to enter a combination.
        REGIME_REGISTERED              = 10308, -- New training regime registered!
        COMMON_SENSE_SURVIVAL          = 12329, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BACKOO        = 17260613,
        HELLDIVER_PH  =
        {
            [17260886] = 17260907, -- 439.685 -0.200 -271.203
            [17260906] = 17260907, -- 509.641 0.151 -267.664
            [17260905] = 17260907, -- 503.268 -0.981 -211.204
            [17260868] = 17260907, -- 395.297 -0.037 -149.776
            [17260887] = 17260907, -- 445.199 -0.323 -306.818
        },
        BUBURIMBOO_PH =
        {
            [17261000] = 17261003, -- 443.429 19.500 135.322
            [17261002] = 17261003, -- 442.901 19.500 109.075
            [17261001] = 17261003, -- 443.004 19.500 96.000
            [17260999] = 17261003, -- 444.224 19.499 76.000
        },
    },
    npc =
    {
        CASKET_BASE     = 17261112,
        OVERSEER_BASE   = 17261149, -- Bonbavour_RK in npc_list
        SIGNPOST_OFFSET = 17261164,
        LOGGING =
        {
            17261174,
            17261175,
            17261176,
            17261177,
            17261178,
            17261179,
        },
    },
}

return zones[xi.zone.BUBURIMU_PENINSULA]
