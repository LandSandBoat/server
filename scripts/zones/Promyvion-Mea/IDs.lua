-----------------------------------
-- Area: Promyvion-Mea
-----------------------------------
zones = zones or {}

zones[xi.zone.PROMYVION_MEA] =
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
            [16859155] = { 1, 3, 16859482 },
            [16859205] = { 2, 5, 16859485 },
            [16859212] = { 2, 5, 16859489 },
            [16859219] = { 2, 5, 16859490 },
            [16859226] = { 2, 5, 16859491 },
            [16859296] = { 3, 7, 16859483 },
            [16859305] = { 3, 7, 16859484 },
            [16859314] = { 3, 7, 16859486 },
            [16859376] = { 4, 7, 16859487 },
            [16859385] = { 4, 7, 16859488 },
            [16859394] = { 4, 7, 16859492 },
        },

        COVETER    = 16859472,
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]        = { -122, -4,  197, -117, 4,  202, { 46 } },     -- floor 1 return
            [21]        = {   -1, -4, -121,    2, 4, -118, { 41 } },     -- floor 2 return
            [31]        = { -161, -4,  158, -157, 4,  161, { 30 } },     -- floor 3 return
            [32]        = {  158, -4, -281,  161, 4, -278, { 30 } },     -- floor 3 return
            [41]        = {  -82, -4,  358,  -78, 4,  361, { 33 } },     -- floor 4 return
            [16859482]  = { -283, -4,  237, -276, 4,  242, { 30 } },     -- floor 1 MR1
            [16859485]  = {  -82, -4,  -42,  -78, 4,  -38, { 33, 37 } }, -- floor 2 MR1
            [16859489]  = { -322, -4, -361, -318, 4, -357, { 33, 37 } }, -- floor 2 MR2
            [16859490]  = {  -42, -4, -321,  -37, 4, -317, { 33, 37 } }, -- floor 2 MR3
            [16859491]  = {   77, -4, -241,   81, 4, -238, { 33, 37 } }, -- floor 2 MR4
            [16859483]  = { -321, -4,  -42, -318, 4,  -38, { 31 } },     -- floor 3 MR1
            [16859484]  = { -241, -4,  -42, -238, 4,  -37, { 31 } },     -- floor 3 MR2
            [16859486]  = {  -42, -4,   -2,  -38, 4,    2, { 31 } },     -- floor 3 MR3
            [16859487]  = {  198, -4,   -2,  201, 4,    2, { 31 } },     -- floor 3 MR4
            [16859488]  = {  358, -4,  -41,  362, 4,  -38, { 31 } },     -- floor 3 MR5
            [16859492]  = {  240, -4, -322,  244, 4, -317, { 31 } },     -- floor 3 MR6
        },
    },
}

return zones[xi.zone.PROMYVION_MEA]
