-----------------------------------
-- Area: Yuhtunga_Jungle
-----------------------------------
zones = zones or {}

zones[xi.zone.YUHTUNGA_JUNGLE] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6405,  -- You are suddenly overcome with a sense of foreboding...
        NOW_IS_NOT_THE_TIME           = 6406,  -- Now is not the time for that!
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7064,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7145,  -- There is a beastmen's banner.
        CONQUEST                      = 7232,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7565,  -- You can't fish here.
        DIG_THROW_AWAY                = 7578,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7580,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7646,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FLOWER_BLOOMING               = 7671,  -- A large flower is blooming.
        FOUND_NOTHING_IN_FLOWER       = 7674,  -- You find nothing inside the flower.
        FEEL_DIZZY                    = 7675,  -- You feel slightly dizzy. You must have breathed in too much of the pollen.
        SOMETHING_BETTER              = 7688,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7691,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7692,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS        = 7693,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS               = 7694,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7695,  -- It is an ancient Zilart monument.
        TOUCHING_RED_JEWEL            = 7697,  -- Touching the red jewel has infuriated the Opo-opos of the forest. It would be wise to leave immediately.
        THE_OPO_OPOS_ATTACK           = 7711,  -- The Opo-opos attack!
        LOGGING_IS_POSSIBLE_HERE      = 7712,  -- Logging is possible here if you have <item>.
        HARVESTING_IS_POSSIBLE_HERE   = 7719,  -- Harvesting is possible here if you have <item>.
        SOMETHING_IS_BURIED_HERE      = 7762,  -- It looks like something is buried here. If you had <item> you could dig it up.
        GARRISON_BASE                 = 7789,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        SWARM_APPEARED                = 7835,  -- A swarm has appeared!
        PLAYER_OBTAINS_ITEM           = 7875,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7876,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7877,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7878,  -- You already possess that temporary item.
        NO_COMBINATION                = 7883,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7945,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10061, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 12056, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
