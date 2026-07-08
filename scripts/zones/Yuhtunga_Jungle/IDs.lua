-----------------------------------
-- Area: Yuhtunga_Jungle
-----------------------------------
zones = zones or {}

zones[xi.zone.YUHTUNGA_JUNGLE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6398,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6409,  -- You are suddenly overcome with a sense of foreboding...
        NOW_IS_NOT_THE_TIME           = 6410,  -- Now is not the time for that!
        FELLOW_MESSAGE_OFFSET         = 6423,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7153,  -- There is a beastmen's banner.
        CONQUEST                      = 7240,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7573,  -- You can't fish here.
        DIG_THROW_AWAY                = 7586,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7588,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7654,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE          = 7663,  -- It appears your chocobo found this item with ease.
        FLOWER_BLOOMING               = 7680,  -- A large flower is blooming.
        FOUND_NOTHING_IN_FLOWER       = 7683,  -- You find nothing inside the flower.
        FEEL_DIZZY                    = 7684,  -- You feel slightly dizzy. You must have breathed in too much of the pollen.
        SOMETHING_BETTER              = 7697,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7700,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7701,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS        = 7702,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS               = 7703,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7704,  -- It is an ancient Zilart monument.
        TOUCHING_RED_JEWEL            = 7706,  -- Touching the red jewel has infuriated the Opo-opos of the forest. It would be wise to leave immediately.
        THE_OPO_OPOS_ATTACK           = 7720,  -- The Opo-opos attack!
        LOGGING_IS_POSSIBLE_HERE      = 7721,  -- Logging is possible here if you have <item>.
        HARVESTING_IS_POSSIBLE_HERE   = 7728,  -- Harvesting is possible here if you have <item>.
        SOMETHING_IS_BURIED_HERE      = 7771,  -- It looks like something is buried here. If you had <item> you could dig it up.
        GARRISON_BASE                 = 7798,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        SWARM_APPEARED                = 7844,  -- A swarm has appeared!
        TIME_ELAPSED                  = 7863,  -- Time elapsed: <number> [hour/hours] (Vana'diel time) <number> [minute/minutes] and <number> [second/seconds] (Earth time)
        PLAYER_OBTAINS_ITEM           = 7884,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7885,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7886,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7887,  -- You already possess that temporary item.
        NO_COMBINATION                = 7892,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7954,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10070, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 12065, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BAYAWAK              = GetFirstID('Bayawak'),
        CARTHI               = GetFirstID('Carthi'),
        MISCHIEVOUS_MICHOLAS = GetFirstID('Mischievous_Micholas'),
        NASUS_OFFSET         = GetFirstID('Nasus'),
        TIPHA                = GetFirstID('Tipha'),
        ROSE_GARDEN          = GetFirstID('Rose_Garden'),
        SIREN                = GetFirstID('Siren'),
        VOLUPTUOUS_VILMA     = GetFirstID('Voluptuous_Vilma'),
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
