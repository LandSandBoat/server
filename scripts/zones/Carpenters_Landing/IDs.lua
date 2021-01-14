-----------------------------------
-- Area: Carpenters_Landing
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CARPENTERS_LANDING] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED    = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE = 6387, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED              = 6389, -- Obtained: <item>.
        GIL_OBTAINED               = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6392, -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED             = 6398, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY    = 6403, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET      = 6418, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS        = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE              = 7050, -- Tallying conquest results...
        CRYPTONBERRY_FALLEN_TREE   = 7247, -- A tree has fallen here...
        CRYPTONBERRY_EXECUTOR_POP  = 7248, -- You feel a wave of hatred wash over you!
        FISHING_MESSAGE_OFFSET     = 7271, -- You can't fish here.
        LOGGING_IS_POSSIBLE_HERE   = 7388, -- Logging is possible here if you have <item>.
        BEUGUNGEL_SHOP_DIALOG      = 7420, -- Hello, [sir/ma'am]! I'm selling goods direct from the Carpenters' Guild.
        CRYPTONBERRY_EXECUTOR_DIE  = 7472, -- ...Cleave our foesss with barren hate.
        CRYPTONBERRY_ASSASSIN_2HR  = 7473, -- ..Take up thy lanternsss. The truth we shall illuminate.
        CRYPTONBERRY_EXECUTOR_2HR  = 7474, -- Through this we ssseek our just reward...
        MYCOPHILE_MUSHROOM         = 7491, -- There is a rotten mushroom here. There are 3 openings in its cap.
        HERCULES_TREE_NOTHING_YET  = 7493, -- There is nothing here yet. Check again in the morning.
        COMMON_SENSE_SURVIVAL      = 7558, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        ORCTRAP_PH            =
        {
            [16785675] = 16785676, -- 181.819 -5.887 -524.872
        },
        TEMPEST_TIGON         = 16785593,
        OVERGROWN_IVY         = 16785709,
        CRYPTONBERRY_EXECUTOR = 16785710,
        MYCOPHILE             = 16785722,
        HERCULES_BEETLE       = 16785723,
    },
    npc =
    {
        HERCULES_BEETLE_TREES =
        {
            16785730,
            16785731,
            16785732,
            16785733,
            16785734,
            16785735,
        },
        LOGGING =
        {
            16785773,
            16785774,
            16785775,
            16785776,
        },
    },
}

return zones[tpz.zone.CARPENTERS_LANDING]
