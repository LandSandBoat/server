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
        LOKHONG_SHOP_DIALOG     = 7344, -- There's nothing like fishing to pass the time!
        CHHAYA_SHOP_DIALOG      = 7345, -- May I offer you items to help you on your journey?
        ARRIVING_SOON_MHAURA    = 7346, -- We are on our way to Mhaura. We will be arriving soon.
    },
    mob =
    {
        SEA_CREATURES = 17711110, -- Starting Sea Creature offset
        PHANTOM = 17711115,
        CROSSBONES = 17711116, -- Starting pirate offset
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
                    28.75, -7.163, 10.60,
                    22.00, -7.163, 10.46,
                    21.90, -7.163, 10.46
                },
                look_at =
                {
                    x = 20,
                    y = -7.163,
                    z = 10.46
                },
                exit_path =
                {
                    29.79, -7.163, 10.63,
                    33.57, -7.163, 13.14,
                    33.601, -7.163, 13.377
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
                    24.87, -7.163, 2.77,
                    22.00, -7.163, 6.59,
                    21.90, -7.163, 6.59
                },
                look_at =
                {
                    x = 20,
                    y = -7.163,
                    z = 6.59
                },
                exit_path =
                {
                    21.90, -7.163, 6.59,
                    22.00, -7.163, 6.59,
                    24.87, -7.163, 2.77,
                    25.91, -7.163, 2.77,
                    29.71, -7.163, 1.54,
                    29.728, -7.163, 1.303
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
                    29.602, -7.163, -2.475,
                    29.61, -7.163, -2.71,
                    25.97, -7.163, -4.02,
                    24.93, -7.163, -4.02,
                    22.00, -7.163, 2.10,
                    21.90, -7.163, 2.10
                },
                look_at =
                {
                    x = 20,
                    y = -7.163,
                    z = 2.10
                },
                exit_path =
                {
                    21.90, -7.163, 2.10,
                    22.00, -7.163, 2.10,
                    24.93, -7.163, -4.02,
                    25.97, -7.163, -4.02,
                    29.61, -7.163, -2.71,
                    29.602, -7.163, -2.475
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
                z = -1000,
                rot = 192
            },
            event_pos =
            {
                x = 30,
                y = 0,
                z = 0,
                rot = 192
            },
            anim_path = 14
        }
    },
}

return zones[xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES]

