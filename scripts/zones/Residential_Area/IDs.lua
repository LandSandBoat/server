-----------------------------------
-- Area: Residential_Area
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.RESIDENTIAL_AREA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 0, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 0, -- Obtained: <item>.
        GIL_OBTAINED            = 0, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 0, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.RESIDENTIAL_AREA]
