-----------------------------------
-- Area: Eastern Adoulin (257)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.EASTERN_ADOULIN] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6384,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6390,  -- Obtained: <item>.
        GIL_OBTAINED            = 6391,  -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6393,  -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7001,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7002,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7003,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        BAYLD_OBTAINED          = 7007,  -- You have obtained <number> bayld!
        YOU_CAN_NOW_BECOME      = 7011,  -- You can now become a [geomancer/rune fencer]!
        MOG_LOCKER_OFFSET       = 7582,  -- Your Mog Locker lease is valid until <timestamp>, kupo.
        HOMEPOINT_SET           = 8298,  -- Home point set!
        COMMON_SENSE_SURVIVAL   = 13860, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.EASTERN_ADOULIN]
