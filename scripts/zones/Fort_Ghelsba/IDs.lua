-----------------------------------
-- Area: Fort_Ghelsba
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.FORT_GHELSBA] =
{
    text =
    {
        CONQUEST_BASE           = 0, -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED = 6542, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6548, -- Obtained: <item>.
        GIL_OBTAINED            = 6549, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6551, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET   = 6577, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 7159, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7160, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7161, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CHEST_UNLOCKED          = 7356, -- You unlock the chest!
        COMMON_SENSE_SURVIVAL   = 7364, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        HUNDREDSCAR_HAJWAJ_PH =
        {
            [17354823] = 17354828,
        },
        ORCISH_PANZER = 17354894,
    },
    npc =
    {
        TREASURE_CHEST = 17355012,
    },
}

return zones[tpz.zone.FORT_GHELSBA]
