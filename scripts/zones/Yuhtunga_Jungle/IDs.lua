-----------------------------------
-- Area: Yuhtunga_Jungle
-----------------------------------
require("scripts/globals/zone")
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
        CONQUEST_BASE                 = 7060,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7141,  -- There is a beastmen's banner.
        CONQUEST                      = 7228,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET        = 7561,  -- You can't fish here.
        DIG_THROW_AWAY                = 7574,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7576,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7642,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FLOWER_BLOOMING               = 7667,  -- A large flower is blooming.
        FOUND_NOTHING_IN_FLOWER       = 7670,  -- You find nothing inside the flower.
        FEEL_DIZZY                    = 7671,  -- You feel slightly dizzy. You must have breathed in too much of the pollen.
        SOMETHING_BETTER              = 7684,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG            = 7687,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG         = 7688,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS        = 7689,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS               = 7690,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT               = 7691,  -- It is an ancient Zilart monument.
        TOUCHING_RED_JEWEL            = 7693,  -- Touching the red jewel has infuriated the Opo-opos of the forest. It would be wise to leave immediately.
        THE_OPO_OPOS_ATTACK           = 7707,  -- The Opo-opos attack!
        LOGGING_IS_POSSIBLE_HERE      = 7708,  -- Logging is possible here if you have <item>.
        HARVESTING_IS_POSSIBLE_HERE   = 7715,  -- Harvesting is possible here if you have <item>.
        SOMETHING_IS_BURIED_HERE      = 7757,  -- It looks like something is buried here. If you had <item> you could dig it up.
        GARRISON_BASE                 = 7784,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        SWARM_APPEARED                = 7830,  -- A swarm has appeared!
        PLAYER_OBTAINS_ITEM           = 7870,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7871,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7872,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7873,  -- You already possess that temporary item.
        NO_COMBINATION                = 7878,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7940,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10056, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 12050, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        MISCHIEVOUS_MICHOLAS_PH =
        {
            [17281148] = 17281149, -- -265.616 -0.5 -24.389
        },
        TIPHA                   = 17281030,
        CARTHI                  = 17281031,
        ROSE_GARDEN_PH          = 17281356,
        ROSE_GARDEN             = 17281357,
        VOLUPTUOUS_VILMA        = 17281358,
        NASUS_OFFSET            = 17281491,
        SIREN                   = 17281547,
    },
    npc =
    {
        BLUE_RAFFLESIA_OFFSET = 17281586,
        TUNING_OUT_QM         = 17281590, -- qm2 in npc_list
        OVERSEER_BASE         = 17281600, -- Zorchorevi_RK in npc_list
        CERMET_HEADSTONE      = 17281625,
        PEDDLESTOX            = 17281640,
        BEASTMEN_TREASURE     =
        {
            17281643, -- qm3
            17281644, -- qm4
            17281645, -- qm5
            17281646, -- qm6
            17281647, -- qm7
            17281648, -- qm8
            17281649, -- qm9
            17281650, -- qm10
        },
        HARVESTING =
        {
            17281636,
            17281637,
            17281638,
        },
        LOGGING =
        {
            17281630,
            17281631,
            17281632,
            17281633,
            17281634,
            17281635,
        },
    },
}

return zones[xi.zone.YUHTUNGA_JUNGLE]
