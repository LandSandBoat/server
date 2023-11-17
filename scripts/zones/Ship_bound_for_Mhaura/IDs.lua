-----------------------------------
-- Area: Ship_bound_for_Mhaura
-----------------------------------
zones = zones or {}

zones[xi.zone.SHIP_BOUND_FOR_MHAURA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7242, -- You can't fish here.
        ON_WAY_TO_MHAURA              = 7343, -- We're on our way to Mhaura. We should be there in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (# [minute/minutes] in Earth time).
        LOKHONG_SHOP_DIALOG           = 7348, -- There's nothing like fishing to pass the time!
        CHHAYA_SHOP_DIALOG            = 7349, -- May I offer you items to help you on your journey?
        ARRIVING_SOON_MHAURA          = 7350, -- We are on our way to Mhaura. We will be arriving soon.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.SHIP_BOUND_FOR_MHAURA]
