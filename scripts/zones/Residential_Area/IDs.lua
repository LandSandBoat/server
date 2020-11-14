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
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login no. <number>...
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.RESIDENTIAL_AREA]
