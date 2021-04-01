-----------------------------------
-- Area: Ifrits_Cauldron
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.IFRITS_CAULDRON] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED    = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE = 6387,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED              = 6389,  -- Obtained: <item>.
        GIL_OBTAINED               = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6392,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED             = 6398,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY    = 6403,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET      = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS        = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE              = 7050,  -- Tallying conquest results...
        ALTAR_COMPLETED            = 7239,  -- You have already made an offering today.
        ALTAR_INSPECT              = 7240,  -- This looks like the altar where offerings are to be placed.
        ALTAR_OFFERING             = 7241,  -- You place your offering of <item> on the altar.
        ALTAR_STANDARD             = 7242,  -- It is an altar for offerings.
        CHEST_UNLOCKED             = 7251,  -- You unlock the chest!
        MINING_IS_POSSIBLE_HERE    = 7259,  -- Mining is possible here if you have <item>.
        EGGSHELLS_LIE_SCATTERED    = 7268,  -- Eggshells lie scattered around the place...
        SENSE_OMINOUS_PRESENCE     = 7271,  -- You sense an ominous presence...
        REGIME_REGISTERED          = 10423, -- New training regime registered!
        PLAYER_OBTAINS_ITEM        = 11475, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM      = 11476, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM   = 11477, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP       = 11478, -- You already possess that temporary item.
        NO_COMBINATION             = 11483, -- You were unable to enter a combination.
        HOMEPOINT_SET              = 11509, -- Home point set!
        COMMON_SENSE_SURVIVAL      = 11589, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
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
        CASKET_BASE        = 17617182,
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

return zones[ xi.zone.IFRITS_CAULDRON]
