-----------------------------------
-- Area: Yhoator_Jungle
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.YHOATOR_JUNGLE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6389,  -- Obtained: <item>.
        GIL_OBTAINED                = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6392,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                = 6393,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY     = 6403,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET       = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS         = 7000,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7001,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7002,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE               = 7053,  -- Tallying conquest results...
        BEASTMEN_BANNER             = 7134,  -- There is a beastmen's banner.
        CONQUEST                    = 7221,  -- You've earned conquest points!
        FISHING_MESSAGE_OFFSET      = 7554,  -- You can't fish here.
        DIG_THROW_AWAY              = 7567,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                = 7569,  -- You dig and you dig, but find nothing.
        ALREADY_OBTAINED_TELE       = 7654,  -- You already possess the gate crystal for this telepoint.
        LOGGING_IS_POSSIBLE_HERE    = 7667,  -- Logging is possible here if you have <item>.
        HARVESTING_IS_POSSIBLE_HERE = 7674,  -- Harvesting is possible here if you have <item>.
        TREE_CHECK                  = 7681,  -- The hole in this tree is filled with a sweet-smelling liquid.
        TREE_FULL                   = 7682,  -- Your wine barrel is already full.
        WATER_HOLE                  = 7685,  -- There is an Opo-opo drinking well here. It seems they feast here, too.
        FAINT_CRY                   = 7686,  -- You hear the cry of a famished Opo-opo!
        PAMAMAS                     = 7689,  -- You might be able to draw an Opo-opo here if you had more pamamas.
        SOMETHING_IS_BURIED_HERE    = 7744,  -- It looks like something is buried here. If you had <item> you could dig it up.
        PLAYER_OBTAINS_ITEM         = 7833,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM       = 7834,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM    = 7835,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP        = 7836,  -- You already possess that temporary item.
        NO_COMBINATION              = 7841,  -- You were unable to enter a combination.
        REGIME_REGISTERED           = 10019, -- New training regime registered!
        COMMON_SENSE_SURVIVAL       = 11138, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        HOAR_KNUCKLED_RIMBERRY_PH =
        {
            [17285392] = 17285394,
            [17285393] = 17285394,
        },
        WOODLAND_SAGE          = 17285220,
        POWDERER_PENNY         = 17285248,
        BISQUE_HEELED_SUNBERRY = 17285460,
        BRIGHT_HANDED_KUNBERRY = 17285526,
        KAPPA_AKUSO            = 17285544,
        KAPPA_BONZE            = 17285545,
        KAPPA_BIWA             = 17285546,
        EDACIOUS_OPO_OPO       = 17285571,
    },
    npc =
    {
        CASKET_BASE       = 17285618,
        OVERSEER_BASE     = 17285649, -- Ilieumort_RK in npc_list
        PEDDLESTOX        = 17285685,
        BEASTMEN_TREASURE =
        {
            17285695, -- qm4
            17285688, -- qm5
            17285689, -- qm6
            17285690, -- qm7
            17285691, -- qm8
            17285692, -- qm9
            17285693, -- qm10
            17285694, -- qm11
        },
        HARVESTING =
        {
            17285680,
            17285681,
            17285682,
        },
        LOGGING =
        {
            17285674,
            17285675,
            17285676,
            17285677,
            17285678,
            17285679,
        },
    },
}

return zones[xi.zone.YHOATOR_JUNGLE]
