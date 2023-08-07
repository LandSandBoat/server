-----------------------------------
-- Area: Promyvion-Holla
-----------------------------------
zones = zones or {}

zones[xi.zone.PROMYVION_HOLLA] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        BARRIER_WOVEN                 = 7222, -- It appears to be a barrier woven from the energy of overflowing memories...
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16842781] = { 1, 3, 16843060 },
            [16842841] = { 2, 5, 16843056 },
            [16842848] = { 2, 5, 16843057 },
            [16842855] = { 2, 5, 16843058 },
            [16842862] = { 2, 5, 16843059 },
            [16842888] = { 3, 7, 16843053 },
            [16842897] = { 3, 7, 16843054 },
            [16842906] = { 3, 7, 16843055 },
            [16842940] = { 4, 7, 16843061 },
            [16842949] = { 4, 7, 16843062 },
            [16842958] = { 4, 7, 16843063 },
        },

        CEREBRATOR    = 16843043,
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]        = {   78, -4,   78,   82, 4,   82, { 46 } },    -- floor 1 return
            [21]        = { -122, -4,   -2, -118, 4,    2, { 41 } },    -- floor 2 return
            [31]        = { -162, -4,  118, -158, 4,  122, { 42 } },    -- floor 3 return
            [32]        = {  158, -4,  238,  162, 4,  242, { 42 } },    -- floor 3 return
            [41]        = {  118, -4, -322,  121, 4, -318, { 33 } },    -- floor 4 return
            [16843060]  = {  -42, -4,  198,  -38, 4,  202, { 37 } },    -- floor 1 MR1
            [16843056]  = { -240, -4,   38, -237, 4,   41, { 33, 34 } }, -- floor 2 MR1
            [16843057]  = { -282, -4,  -42, -278, 4,  -38, { 33, 34 } }, -- floor 2 MR2
            [16843058]  = { -162, -4, -202, -157, 4, -198, { 33, 34 } }, -- floor 2 MR3
            [16843059]  = {   -2, -4,  -42,    2, 4,  -38, { 33, 34 } }, -- floor 2 MR4
            [16843053]  = { -282, -4,  277, -278, 4,  282, { 30 } },    -- floor 3 MR1
            [16843054]  = { -362, -4,  237, -358, 4,  242, { 30 } },    -- floor 3 MR2
            [16843055]  = { -362, -4,  118, -358, 4,  122, { 30 } },    -- floor 3 MR3
            [16843061]  = {   38, -4,  318,   42, 4,  322, { 30 } },    -- floor 3 MR4
            [16843062]  = {  158, -4,  358,  162, 4,  362, { 30 } },    -- floor 3 MR5
            [16843063]  = {  278, -4,  197,  282, 4,  202, { 30 } },    -- floor 3 MR6
        },
    },
}

return zones[xi.zone.PROMYVION_HOLLA]
