-----------------------------------
-- Area: Promyvion-Dem
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.PROMYVION_DEM] =
{
    text =
    {
        NOTHING_HAPPENS         = 119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY = 6402, -- There is nothing out of the ordinary here.
        BARRIER_WOVEN           = 7211, -- It appears to be a barrier woven from the energy of overflowing memories...
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16850971] = {1, 3, 16851268},
            [16851025] = {2, 5, 16851272},
            [16851032] = {2, 5, 16851273},
            [16851039] = {2, 5, 16851274},
            [16851046] = {2, 5, 16851275},
            [16851072] = {3, 7, 16851269},
            [16851081] = {3, 7, 16851270},
            [16851090] = {3, 7, 16851271},
            [16851149] = {4, 7, 16851276},
            [16851158] = {4, 7, 16851277},
            [16851167] = {4, 7, 16851278},
        },
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]        = { 157, -4,  -82,  161, 4,  -77, {46}},    -- floor 1 return
            [21]        = {-383, -4,   -2, -278, 4,    2, {41}},    -- floor 2 return
            [31]        = {-160, -4,  437, -157, 4,  441, {30}},    -- floor 3 return
            [32]        = {  -2, -4, -322,    2, 4, -317, {30}},    -- floor 3 return
            [41]        = { 357, -4,  237,  361, 4,  242, {34}},    -- floor 4 return
            [16851268]  = { 117, -4, -283,  122, 4, -277, {30}},    -- floor 1 MR1
            [16851272]  = { -83, -4,  -83,  -77, 4,  -76, {34, 35}}, -- floor 2 MR1
            [16851273]  = { -82, -4,   76,  -77, 4,   80, {34, 35}}, -- floor 2 MR2
            [16851274]  = {-282, -4, -202, -277, 4, -196, {34, 35}}, -- floor 2 MR3
            [16851275]  = {-361, -4,   36, -356, 4,   42, {34, 35}}, -- floor 2 MR4
            [16851269]  = {  37, -4, -203,   43, 4, -198, {32}},    -- floor 3 MR1
            [16851270]  = {-122, -4, -242, -116, 4, -237, {32}},    -- floor 3 MR2
            [16851271]  = {-122, -4, -402, -116, 4, -396, {32}},    -- floor 3 MR3
            [16851276]  = {-322, -4,  156, -316, 4,  162, {32}},    -- floor 3 MR4
            [16851277]  = { -42, -4,  317,  -37, 4,  322, {32}},    -- floor 3 MR5
            [16851278]  = {-122, -4,  157, -118, 4,  163, {32}},    -- floor 3 MR6
        },
    },
}

return zones[tpz.zone.PROMYVION_DEM]
