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
        ON_WAY_TO_MHAURA        = 7339, -- We're on our way to Mhaura. We should be there in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (<number> [minute/minutes] in Earth time).
        LOKHONG_SHOP_DIALOG     = 7337, -- There's nothing like fishing to pass the time!
        CHHAYA_SHOP_DIALOG      = 7338, -- May I offer you items to help you on your journey?
        ARRIVING_SOON_MHAURA    = 7346, -- We are on our way to Mhaura. We will be arriving soon.
    },
    mob =
    {
        SEA_CREATURES =
        {
            17711110,   -- Sea Crab 1
            17711111,   -- Sea Crab 2
            17711112,   -- Sea Pugil 1
            17711113,   -- Sea Pugil 2
            17711114,   -- Sea Monk 1
        },
        PHANTOM = 17711115,
        CROSSBONES =
        {
            17711116,
            17711117,
            17711118,
            17711119
        },
        SHIP_WIGHT = 17711120,
        NM = 17711121
    },
    npc =
    {
        PIRATES =
        {
            [17711136] =
            {
                start_pos =
                {
                    x = 33.601,
                    y = -7.163,
                    z = 13.377,
                    rot = 128
                },
                enter_path =
                {
                    25.2, -7.163, 6.23,
                    22.6, -7.163, 12.82
                },
                look_at =
                {
                    x = 0,
                    y = -7.163,
                    z = 13.10
                },
                exit_path =
                {
                    22.6, -7.163, 12.82,
                    25.2, -7.163, 6.23
                }
            },
            [17711137] =
            {
                start_pos =
                {
                    x = 29.728,
                    y = -7.163,
                    z = 1.303,
                    rot = 128
                },
                enter_path =
                {
                    26.23, -7.163, 16.7,
                    22.68, -7.163, 16.7
                },
                look_at =
                {
                     x = 0,
                     y = -7.163,
                     z = 13.10
                },
                exit_path =
                {
                    22.68, -7.163, 16.7,
                    26.23, -7.163, 16.7
                }
            },
            [17711138] =
            {
                start_pos =
                {
                    x = 29.602,
                    y = -7.163,
                    z = -2.475,
                    rot = 128
                },
                enter_path =
                {
                    29.38, -7.163, 20.51,
                    22.78, -7.163, 20.51
                },
                look_at =
                {
                    x = 0,
                    y = -7.163,
                    z = 13.10
                },
                exit_path =
                {
                    22.78, -7.163, 20.51,
                    29.38, -7.163, 20.51
                }
            }
        },
        PIRATE_SHIP =
        {
            id = 17711139,
            start_pos =
            {
                x = 150,
                y = 0,
                z = -990,
                rot = 192
            },
            event_pos =
            {
                x = 30,
                y = 0,
                z = 10,
                rot = 192
            },
            anim_path = 14
        }
    },
}

return zones[xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES]

