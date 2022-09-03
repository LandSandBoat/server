-----------------------------------
-- Area: Ifrits_Cauldron
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.IFRITS_CAULDRON] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6388,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6390,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6399,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7057,  -- Tallying conquest results...
        ALTAR_COMPLETED               = 7246,  -- You have already made an offering today.
        ALTAR_INSPECT                 = 7247,  -- This looks like the altar where offerings are to be placed.
        ALTAR_OFFERING                = 7248,  -- You place your offering of <item> on the altar.
        ALTAR_STANDARD                = 7249,  -- It is an altar for offerings.
        CHEST_UNLOCKED                = 7258,  -- You unlock the chest!
        MINING_IS_POSSIBLE_HERE       = 7266,  -- Mining is possible here if you have <item>.
        BAD_FEELING_ABOUT_PLACE       = 7273,  -- You have a bad feeling about this place.
        LAVA_FLOWS_SLOWLY             = 7274,  -- Lava flows slowly through the rocks.
        EGGSHELLS_LIE_SCATTERED       = 7275,  -- Eggshells lie scattered around the place...
        SENSE_OMINOUS_PRESENCE        = 7278,  -- You sense an ominous presence...
        REGIME_REGISTERED             = 10430, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11482, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11483, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11484, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11485, -- You already possess that temporary item.
        NO_COMBINATION                = 11490, -- You were unable to enter a combination.
        HOMEPOINT_SET                 = 11516, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 11574, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 11596, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        TYRANNIC_TUNNOK_PH =
        {
            [17616996] = 17616999,
            [17617000] = 17616999,
            [17617001] = 17616999,
        },
        LINDWURM_PH =
        {
            [17617007] = 17617013,
            [17617008] = 17617013,
            [17617011] = 17617013,
            [17617012] = 17617013,
            [17617031] = 17617013,
            [17617032] = 17617013,
        },
        FORESEER_ORAMIX_PH =
        {
            [17617055] = 17617062,
            [17617066] = 17617062,
            [17617069] = 17617062,
        },
        VOUIVRE_PH =
        {
            [17617117] = 17617130,
            [17617118] = 17617130,
            [17617121] = 17617130,
            [17617122] = 17617130,
            [17617125] = 17617130,
            [17617129] = 17617130,
        },
        PIRATES_COVE_NMS = 17616897,
        ASH_DRAGON       = 17617147,
        MIMIC            = 17617157,
        BOMB_QUEEN       = 17617158,
        TARASQUE         = 17617164,
        CAILLEACH_BHEUR  = 17617165,
    },
    npc =
    {
        FLAME_SPOUT_OFFSET = 17617204,
        TREASURE_COFFER    = 17617224,
        MINING =
        {
            17617225,
            17617226,
            17617227,
            17617228,
            17617229,
            17617230,
        },
    },
}

return zones[xi.zone.IFRITS_CAULDRON]
