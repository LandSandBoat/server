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
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7241, -- You can't fish here.
        ON_WAY_TO_SELBINA             = 7342, -- We're on our way to Selbina. We should be there in [less than an hour/about 1 hour/about 2 hours/about 3 hours/about 4 hours/about 5 hours/about 6 hours/about 7 hours] (<number> [minute/minutes] in Earth time).
        RAJMONDA_SHOP_DIALOG          = 7347, -- There's nothing like fishing to pass the time!
        MAERA_SHOP_DIALOG             = 7348, -- May I offer you items to help you on your journey?
        ARRIVING_SOON_SELBINA         = 7349, -- We are on our way to Selbina. We will be arriving soon.
    },
    mob =
    {
        SEA_CREATURES = 17707014,   -- Starting Sea Creature Offset
        PHANTOM = 17707019,
        CROSSBONES = 17707020, -- Starting Pirate Offset
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
                    { x = -28.75, y = -7.163, z = 10.60 },
                    { x = -22.00, y = -7.163, z = 10.46 },
                    { x = -21.90, y = -7.163, z = 10.46 },
                },
                look_at =
                {
                    x = -20,
                    y = -7.163,
                    z = 10.46
                },
                exit_path =
                {
                    { x = -29.79, y = -7.163, z = 10.63 },
                    { x = -33.57, y = -7.163, z = 13.14 },
                    { x = -33.601, y = -7.163, z = 13.377 },
                },
                position = 1,
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
                    { x = -24.87, y = -7.163, z = 2.77 },
                    { x = -22.00, y = -7.163, z = 6.59 },
                    { x = -21.90, y = -7.163, z = 6.59 },
                },
                look_at =
                {
                    x = -20,
                    y = -7.163,
                    z = 6.59
                },
                exit_path =
                {
                    { x = -25.91, y = -7.163, z = 2.77 },
                    { x = -29.71, y = -7.163, z = 1.54 },
                    { x = -29.728, y = -7.163, z = 1.303 },
                },
                position = 2,
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
                    { x = -24.93, y = -7.163, z = -4.02 },
                    { x = -22.00, y = -7.163, z = 2.10 },
                    { x = -21.90, y = -7.163, z = 2.10 },
                },
                look_at =
                {
                    x = -20,
                    y = -7.163,
                    z = 2.10
                },
                exit_path =
                {
                    { x = -25.97, y = -7.163, z = -4.02 },
                    { x = -29.61, y = -7.163, z = -2.71 },
                    { x = -29.602, y = -7.163, z = -2.475 },
                },
                position = 3,
            },
            [17707061] =
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
                    { x = -24.87, y = -7.163, z = 2.77 },
                    { x = -22.00, y = -7.163, z = 6.59 },
                    { x = -21.90, y = -7.163, z = 6.59 },
                },
                look_at =
                {
                    x = -20,
                    y = -7.163,
                    z = 6.59
                },
                exit_path =
                {
                    { x = -25.91, y = -7.163, z = 2.77 },
                    { x = -29.71, y = -7.163, z = 1.54 },
                    { x = -29.728, y = -7.163, z = 1.303 },
                },
                position = 4,
            },
        },
        PIRATE_SHIP =
        {
            id = 17707044,
            start_pos =
            {
                x = -150,
                y = 0,
                z = -1000,
                rot = 192
            },
            event_pos =
            {
                x = -30,
                y = 0,
                z = 0,
                rot = 192
            },
            anim_path = 13
        }
    },
}

return zones[xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES]
