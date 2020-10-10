-----------------------------------
-- Area: Promyvion-Holla
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.PROMYVION_HOLLA] =
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
            [16842781] = {1, 3, 16843058},
            [16842839] = {2, 5, 16843054},
            [16842846] = {2, 5, 16843055},
            [16842853] = {2, 5, 16843056},
            [16842860] = {2, 5, 16843057},
            [16842886] = {3, 7, 16843051},
            [16842895] = {3, 7, 16843052},
            [16842904] = {3, 7, 16843053},
            [16842938] = {4, 7, 16843059},
            [16842947] = {4, 7, 16843060},
            [16842956] = {4, 7, 16843061},
        },
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]        = {  78, -4,   78,   82, 4,   82, {46}},    -- floor 1 return
            [21]        = {-122, -4,   -2, -118, 4,    2, {41}},    -- floor 2 return
            [31]        = {-162, -4,  118, -158, 4,  122, {42}},    -- floor 3 return
            [32]        = { 158, -4,  238,  162, 4,  242, {42}},    -- floor 3 return
            [41]        = { 118, -4, -322,  121, 4, -318, {33}},    -- floor 4 return
            [16843058]  = { -42, -4,  198,  -38, 4,  202, {37}},    -- floor 1 MR1
            [16843054]  = {-240, -4,   38, -237, 4,   41, {33, 34}}, -- floor 2 MR1
            [16843055]  = {-282, -4,  -42, -278, 4,  -38, {33, 34}}, -- floor 2 MR2
            [16843056]  = {-162, -4, -202, -157, 4, -198, {33, 34}}, -- floor 2 MR3
            [16843057]  = {  -2, -4,  -42,    2, 4,  -38, {33, 34}}, -- floor 2 MR4
            [16843051]  = {-282, -4,  277, -278, 4,  282, {30}},    -- floor 3 MR1
            [16843052]  = {-362, -4,  237, -358, 4,  242, {30}},    -- floor 3 MR2
            [16843053]  = {-362, -4,  118, -358, 4,  122, {30}},    -- floor 3 MR3
            [16843059]  = {  38, -4,  318,   42, 4,  322, {30}},    -- floor 3 MR4
            [16843060]  = { 158, -4,  358,  162, 4,  362, {30}},    -- floor 3 MR5
            [16843061]  = { 278, -4,  197,  282, 4,  202, {30}},    -- floor 3 MR6
        },
    },
}

return zones[tpz.zone.PROMYVION_HOLLA]
