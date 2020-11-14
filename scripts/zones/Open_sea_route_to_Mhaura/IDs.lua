-----------------------------------
-- Area: Open_sea_route_to_Mhaura
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.OPEN_SEA_ROUTE_TO_MHAURA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED    = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED              = 6388, -- Obtained: <item>.
        GIL_OBTAINED               = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED           = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS        = 6999, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY    = 7000, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER               = 7001, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET     = 7049, -- You can't fish here.
        ON_WAY_TO_MHAURA           = 7308, -- We are on our way to Mhaura. We should arrive in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (# [minute/minutes] in Earth time).
        DOCKING_IN_MHAURA          = 7309, -- We are now docking in Mhaura.
        PASHI_MACCALEH_SHOP_DIALOG = 7312, -- Step right up for the best fishing gear in these parts!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.OPEN_SEA_ROUTE_TO_MHAURA]
