-----------------------------------
-- Area: Ship_bound_for_Selbina
-----------------------------------
zones = zones or {}

zones[xi.zone.SHIP_BOUND_FOR_SELBINA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7249, -- You can't fish here.
        ON_WAY_TO_SELBINA             = 7350, -- We're on our way to Selbina. We should be there in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (# [minute/minutes] in Earth time).
        RAJMONDA_SHOP_DIALOG          = 7355, -- There's nothing like fishing to pass the time!
        MAERA_SHOP_DIALOG             = 7356, -- May I offer you items to help you on your journey?
        ARRIVING_SOON_SELBINA         = 7357, -- We are on our way to Selbina. We will be arriving soon.
    },
    mob =
    {
        ENAGAKURE  = GetFirstID('Enagakure'),
        SEA_HORROR = GetFirstID('Sea_Horror'),
    },
    npc =
    {
    },
}

return zones[xi.zone.SHIP_BOUND_FOR_SELBINA]
