-----------------------------------
-- Area: Silver_Sea_route_to_Nashmau
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SILVER_SEA_ROUTE_TO_NASHMAU] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number>  points.
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login no. <number>...
        FISHING_MESSAGE_OFFSET  = 7049, -- You can't fish here.
        DOCKING_IN_NASHMAU      = 7309, -- We are now docking in Nashmau.
        NEARING_NASHMAU         = 7310, -- We are nearing Nashmau.
        JIDWAHN_SHOP_DIALOG     = 7312, -- Would you care for some items to use on your travels?
        ON_WAY_TO_NASHMAU       = 7313, -- We are on our way to Nashmau. We will be arriving soon.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.SILVER_SEA_ROUTE_TO_NASHMAU]
