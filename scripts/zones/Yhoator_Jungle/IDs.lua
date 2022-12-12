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
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
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
        ALREADY_OBTAINED_TELE         = 7661,  -- You already possess the gate crystal for this telepoint.
        LOGGING_IS_POSSIBLE_HERE      = 7674,  -- Logging is possible here if you have <item>.
        HARVESTING_IS_POSSIBLE_HERE   = 7681,  -- Harvesting is possible here if you have <item>.
        TREE_CHECK                    = 7688,  -- The hole in this tree is filled with a sweet-smelling liquid.
        TREE_FULL                     = 7689,  -- Your wine barrel is already full.
        WATER_HOLE                    = 7692,  -- There is an Opo-opo drinking well here. It seems they feast here, too.
        FAINT_CRY                     = 7693,  -- You hear the cry of a famished Opo-opo!
        PAMAMAS                       = 7696,  -- You might be able to draw an Opo-opo here if you had more pamamas.
        SOMETHING_IS_BURIED_HERE      = 7732,  -- It looks like something is buried here. If you had <item> you could dig it up.
        GARRISON_BASE                 = 7742,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 7821,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7822,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7823,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7824,  -- You already possess that temporary item.
        NO_COMBINATION                = 7829,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT  = 7891,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10007, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11126, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        OVERSEER_BASE     = 17285650, -- Ilieumort_RK in npc_list
        PEDDLESTOX        = 17285686,
        BEASTMEN_TREASURE =
        {
            17285696, -- qm4
            17285689, -- qm5
            17285690, -- qm6
            17285691, -- qm7
            17285692, -- qm8
            17285693, -- qm9
            17285694, -- qm10
            17285695, -- qm11
        },
        HARVESTING =
        {
            17285681,
            17285682,
            17285683,
        },
        LOGGING =
        {
            17285675,
            17285676,
            17285677,
            17285678,
            17285679,
            17285680,
        },
    },
}

return zones[xi.zone.YHOATOR_JUNGLE]
