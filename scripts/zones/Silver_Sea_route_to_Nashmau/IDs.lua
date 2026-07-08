-----------------------------------
-- Area: Silver_Sea_route_to_Nashmau
-----------------------------------
zones = zones or {}

zones[xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7068, -- You can't fish here.
        ON_WAY_TO_NASHMAU             = 7328, -- We are on our way to Nashmau. We should arrive in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (# [minute/minutes] in Earth time).
        DOCKING_IN_NASHMAU            = 7329, -- We are now docking in Nashmau.
        NEARING_NASHMAU               = 7330, -- We are nearing Nashmau.
        JIDWAHN_SHOP_DIALOG           = 7332, -- Would you care for some items to use on your travels?
        ARRIVING_SOON_NASHMAU         = 7333, -- We are on our way to Nashmau. We will be arriving soon.
    },
    mob =
    {
        PROTEUS = GetFirstID('Proteus'),
    },
    npc =
    {
    },
}

return zones[xi.zone.SILVER_SEA_ROUTE_TO_NASHMAU]
