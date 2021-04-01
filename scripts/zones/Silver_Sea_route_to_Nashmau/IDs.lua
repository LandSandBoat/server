-----------------------------------
-- Area: Silver_Sea_route_to_Nashmau
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[ xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET  = 7050, -- You can't fish here.
        DOCKING_IN_NASHMAU      = 7310, -- We are now docking in Nashmau.
        NEARING_NASHMAU         = 7311, -- We are nearing Nashmau.
        JIDWAHN_SHOP_DIALOG     = 7313, -- Would you care for some items to use on your travels?
        ON_WAY_TO_NASHMAU       = 7314, -- We are on our way to Nashmau. We will be arriving soon.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[ xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU]
