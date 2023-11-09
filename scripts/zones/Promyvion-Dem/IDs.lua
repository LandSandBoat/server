-----------------------------------
-- Area: Promyvion-Dem
-----------------------------------
zones = zones or {}

zones[xi.zone.PROMYVION_DEM] =
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
        BARRIER_WOVEN                 = 7223, -- It appears to be a barrier woven from the energy of overflowing memories...
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16850972] = { 1, 3, 16851277 },
            [16851026] = { 2, 5, 16851281 },
            [16851033] = { 2, 5, 16851282 },
            [16851040] = { 2, 5, 16851283 },
            [16851047] = { 2, 5, 16851284 },
            [16851073] = { 3, 7, 16851278 },
            [16851082] = { 3, 7, 16851279 },
            [16851091] = { 3, 7, 16851280 },
            [16851152] = { 4, 7, 16851285 },
            [16851161] = { 4, 7, 16851286 },
            [16851170] = { 4, 7, 16851287 },
        },

        SATIATOR    = 16851267,
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]        = {  157, -4,  -82,  161, 4,  -77, { 46 } },     -- floor 1 return
            [21]        = { -383, -4,   -2, -278, 4,    2, { 41 } },     -- floor 2 return
            [31]        = { -160, -4,  437, -157, 4,  441, { 30 } },     -- floor 3 return
            [32]        = {   -2, -4, -322,    2, 4, -317, { 30 } },     -- floor 3 return
            [41]        = {  357, -4,  237,  361, 4,  242, { 34 } },     -- floor 4 return
            [16851277]  = {  117, -4, -283,  122, 4, -277, { 30 } },     -- floor 1 MR1
            [16851281]  = {  -83, -4,  -83,  -77, 4,  -76, { 34, 35 } }, -- floor 2 MR1
            [16851282]  = {  -82, -4,   76,  -77, 4,   80, { 34, 35 } }, -- floor 2 MR2
            [16851283]  = { -282, -4, -202, -277, 4, -196, { 34, 35 } }, -- floor 2 MR3
            [16851284]  = { -361, -4,   36, -356, 4,   42, { 34, 35 } }, -- floor 2 MR4
            [16851278]  = {   37, -4, -203,   43, 4, -198, { 32 } },     -- floor 3 MR1
            [16851279]  = { -122, -4, -242, -116, 4, -237, { 32 } },     -- floor 3 MR2
            [16851280]  = { -122, -4, -402, -116, 4, -396, { 32 } },     -- floor 3 MR3
            [16851285]  = { -322, -4,  156, -316, 4,  162, { 32 } },     -- floor 3 MR4
            [16851286]  = {  -42, -4,  317,  -37, 4,  322, { 32 } },     -- floor 3 MR5
            [16851287]  = { -122, -4,  157, -118, 4,  163, { 32 } },     -- floor 3 MR6
        },
    },
}

return zones[xi.zone.PROMYVION_DEM]
