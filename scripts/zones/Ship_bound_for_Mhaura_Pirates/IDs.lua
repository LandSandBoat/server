-----------------------------------
-- Area: Ship bound for Mhaura Pirates
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES] =
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
        FISHING_MESSAGE_OFFSET  = 7231, -- You can't fish here.
        ON_WAY_TO_MHAURA        = 7332, -- We're on our way to Mhaura. We should be there in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (<number> [minute/minutes] in Earth time).
        LOKHONG_SHOP_DIALOG     = 7337, -- There's nothing like fishing to pass the time!
        CHHAYA_SHOP_DIALOG      = 7338, -- May I offer you items to help you on your journey?
        ARRIVING_SOON_MHAURA    = 7339, -- We are on our way to Mhaura. We will be arriving soon.
    },
    mob =
    {
        WIGHT      = 17711120,
        SILVERHOOK = 17711121,
        SEA_MONK   = 17682442,
        SEA_HORROR = 17682446,
    },
    npc =
    {
    },
}

return zones[xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES]

