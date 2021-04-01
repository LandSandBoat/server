-----------------------------------
-- Area: Yuhtunga_Jungle
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.YUHTUNGA_JUNGLE] =
{
    text =
    {
        NOTHING_HAPPENS             = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED     = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6389,  -- Obtained: <item>.
        GIL_OBTAINED                = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6392,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                = 6393,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY     = 6403,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING         = 6404,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET       = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS         = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE               = 7050,  -- Tallying conquest results...
        BEASTMEN_BANNER             = 7131,  -- There is a beastmen's banner.
        CONQUEST                    = 7218,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET      = 7551,  -- You can't fish here.
        DIG_THROW_AWAY              = 7564,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                = 7566,  -- You dig and you dig, but find nothing.
        FLOWER_BLOOMING             = 7657,  -- A large flower is blooming.
        FOUND_NOTHING_IN_FLOWER     = 7660,  -- You find nothing inside the flower.
        FEEL_DIZZY                  = 7661,  -- You feel slightly dizzy. You must have breathed in too much of the pollen.
        SOMETHING_BETTER            = 7674,  -- Don't you have something better to do right now?
        CANNOT_REMOVE_FRAG          = 7677,  -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG       = 7678,  -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS      = 7679,  -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS             = 7680,  -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT             = 7681,  -- It is an ancient Zilart monument.
        LOGGING_IS_POSSIBLE_HERE    = 7698,  -- Logging is possible here if you have <item>.
        HARVESTING_IS_POSSIBLE_HERE = 7705,  -- Harvesting is possible here if you have <item>.
        SOMETHING_IS_BURIED_HERE    = 7766,  -- It looks like something is buried here. If you had <item> you could dig it up.
        SWARM_APPEARED              = 7839, -- A swarm has appeared!
        PLAYER_OBTAINS_ITEM         = 7879,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM       = 7880,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM    = 7881,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP        = 7882,  -- You already possess that temporary item.
        NO_COMBINATION              = 7887,  -- You were unable to enter a combination.
        REGIME_REGISTERED           = 10065, -- New training regime registered!
        COMMON_SENSE_SURVIVAL       = 12059, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        CASKET_BASE           = 17281558,
        BLUE_RAFFLESIA_OFFSET = 17281585,
        TUNING_OUT_QM         = 17281589, -- qm2 in npc_list
        OVERSEER_BASE         = 17281599, -- Zorchorevi_RK in npc_list
        CERMET_HEADSTONE      = 17281624,
        PEDDLESTOX            = 17281639,
        BEASTMEN_TREASURE     =
        {
            17281642, -- qm3
            17281643, -- qm4
            17281644, -- qm5
            17281645, -- qm6
            17281646, -- qm7
            17281647, -- qm8
            17281648, -- qm9
            17281649, -- qm10
        },
        HARVESTING =
        {
            17281635,
            17281636,
            17281637,
        },
        LOGGING =
        {
            17281629,
            17281630,
            17281631,
            17281632,
            17281633,
            17281634,
        },
    },
}

return zones[ xi.zone.YUHTUNGA_JUNGLE]
