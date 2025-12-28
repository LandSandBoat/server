-----------------------------------
-- Area: Yuhtunga_Jungle
-----------------------------------
zones = zones or {}

zones[xi.zone.YUHTUNGA_JUNGLE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6406,  -- You are suddenly overcome with a sense of foreboding...
        NOW_IS_NOT_THE_TIME           = 6407,  -- Now is not the time for that!
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
        FLOWER_BLOOMING               = 7675,  -- A large flower is blooming.
        FOUND_NOTHING_IN_FLOWER       = 7678,  -- You find nothing inside the flower.
        FEEL_DIZZY                    = 7679,  -- You feel slightly dizzy. You must have breathed in too much of the pollen.
        SOMETHING_BETTER              = 7692,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7695,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7696,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS        = 7697,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS               = 7698,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7699,  -- It is an ancient Zilart monument.
        TOUCHING_RED_JEWEL            = 7701,  -- Touching the red jewel has infuriated the Opo-opos of the forest. It would be wise to leave immediately.
        THE_OPO_OPOS_ATTACK           = 7715,  -- The Opo-opos attack!
        LOGGING_IS_POSSIBLE_HERE      = 7716,  -- Logging is possible here if you have <item>.
        HARVESTING_IS_POSSIBLE_HERE   = 7723,  -- Harvesting is possible here if you have <item>.
        SOMETHING_IS_BURIED_HERE      = 7766,  -- It looks like something is buried here. If you had <item> you could dig it up.
        GARRISON_BASE                 = 7793,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        SWARM_APPEARED                = 7839,  -- A swarm has appeared!
        TIME_ELAPSED                  = 7858,  -- Time elapsed: <number> [hour/hours] (Vana'diel time) <number> [minute/minutes] and <number> [second/seconds] (Earth time)
        PLAYER_OBTAINS_ITEM           = 7879,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7880,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7881,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7882,  -- You already possess that temporary item.
        NO_COMBINATION                = 7887,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7949,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10065, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 12060, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        MISCHIEVOUS_MICHOLAS = GetFirstID('Mischievous_Micholas'),
        TIPHA                = GetFirstID('Tipha'),
        CARTHI               = GetFirstID('Carthi'),
        PYUU_THE_SPATEMAKER  = GetFirstID('Pyuu_the_Spatemaker'),
        ROSE_GARDEN          = GetFirstID('Rose_Garden'),
        VOLUPTUOUS_VILMA     = GetFirstID('Voluptuous_Vilma'),
        NASUS_OFFSET         = GetFirstID('Nasus'),
        SIREN                = GetFirstID('Siren'),
        TURTLERIDER          = GetFirstID('Meww_the_Turtlerider'),
        BAYAWAK              = GetFirstID('Bayawak'),
    },
    npc =
    {
        BLUE_RAFFLESIA_OFFSET    = GetFirstID('Blue_Rafflesia'),
        TUNING_OUT_QM            = GetFirstID('qm2'),
        OVERSEER_BASE            = GetFirstID('Zorchorevi_RK'),
        CERMET_HEADSTONE         = GetFirstID('Cermet_Headstone'),
        PEDDLESTOX               = GetFirstID('Peddlestox'),
        BEASTMEN_TREASURE_OFFSET = GetFirstID('qm3'),

        HARVESTING = GetTableOfIDs('Harvesting_Point'),
        LOGGING    = GetTableOfIDs('Logging_Point'),
    },
}

return zones[xi.zone.YUHTUNGA_JUNGLE]
