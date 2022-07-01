-----------------------------------
-- Area: Ship_bound_for_Selbina_Pirates
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES] =
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
        ON_WAY_TO_SELBINA       = 7339, -- We're on our way to Selbina. We should be there in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (<number> [minute/minutes] in Earth time).
        RAJMONDA_SHOP_DIALOG    = 7337, -- There's nothing like fishing to pass the time!
        MAERA_SHOP_DIALOG       = 7338, -- May I offer you items to help you on your journey?
        ARRIVING_SOON_SELBINA   = 7346, -- We are on our way to Selbina. We will be arriving soon.<space>
    },
    mob =
    {
        SEA_CREATURES =
        {
            17707014,   -- Sea Crab 1
            17707015,   -- Sea Crab 2
            17707016,   -- Sea Pugil 1
            17707017,   -- Sea Pugil 2
            17707018,   -- Sea Monk 1
        },
        PHANTOM = 17707019,
        CROSSBONES =
        {
            17707020,
            17707021,
            17707022,
            17707023
        },
        SHIP_WIGHT = 17707024,
        NM = 17707025,
        ENAGAKURE = 17707026
    },
    npc =
    {
        PIRATES =
        {
            [17707041] =
            {
                start_pos =
                {
                    x = -33.601,
                    y = -7.163,
                    z = 13.377,
                    rot = 128
                },
                enter_path =
                {
                    -27.14, -7.163, 5.13,
                    -22.00, -7.163, 12.69
                },
                look_at =
                {
                    x = 0,
                    y = -7.163,
                    z = 13.10
                },
                exit_path =
                {
                    -22.00, -7.163, 12.69,
                    -27.14, -7.163, 5.13
                }
            },
            [17707042] =
            {
                start_pos =
                {
                    x = -29.728,
                    y = -7.163,
                    z = 1.303,
                    rot = 128
                },
                enter_path =
                {
                    -25.07, -7.163, 16.6,
                    -21.90, -7.163, 16.6
                },
                look_at =
                {
                     x = 0,
                     y = -7.163,
                     z = 13.10
                },
                exit_path =
                {
                    21.90, -7.163, 16.6,
                    -25.07, -7.163, 16.6
                }
            },
            [17707043] =
            {
                start_pos =
                {
                    x = -29.602,
                    y = -7.163,
                    z = -2.475,
                    rot = 128
                },
                enter_path =
                {
                    -29.32, -7.163, 20.46,
                    -22.13, -7.163, 20.48
                },
                look_at =
                {
                    x = 0,
                    y = -7.163,
                    z = 13.10
                },
                exit_path =
                {
                    -22.13, -7.163, 20.48,
                    -29.32, -7.163, 20.46
                }
            }
        },
        PIRATE_SHIP =
        {
            id = 17707044,
            start_pos =
            {
                x = -150,
                y = 0,
                z = -990,
                rot = 192
            },
            event_pos =
            {
                x = -30,
                y = 0,
                z = 10,
                rot = 192
            },
            anim_path = 13
        }
    },
}

return zones[xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES]
