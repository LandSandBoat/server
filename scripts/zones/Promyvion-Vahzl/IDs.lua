-----------------------------------
-- Area: Promyvion-Vahzl
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.PROMYVION_VAHZL] =
{
    text =
    {
        NOTHING_HAPPENS         =  119, -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        OVERFLOWING_MEMORIES    = 7211, -- It appears to be a barrier woven from the energy of overflowing memories...
        ON_NM_SPAWN             = 7215, -- You sense a dark, empty presence...
        EERIE_GREEN_GLOW        = 7217, -- The sphere is emitting an eerie green glow.
        POPPED_NM_OFFSET        = 7297, -- Remnants of a cerebrator lie scattered about the area.
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16867382] = {1, 3, 16867699},
            [16867387] = {1, 3, 16867700},
            [16867429] = {2, 5, 16867697},
            [16867436] = {2, 5, 16867698},
            [16867494] = {3, 5, 16867702},
            [16867501] = {3, 5, 16867703},
            [16867508] = {3, 5, 16867704},
            [16867515] = {3, 5, 16867705},
            [16867586] = {4, 7, 16867701},
            [16867595] = {4, 7, 16867706},
            [16867604] = {4, 7, 16867707},
        },
        PONDERER                 = 16867329,
        PROPAGATOR               = 16867330,
        SOLICITOR                = 16867333,
        DEVIATOR                 = 16867455,
        WAILER                   = 16867544,
        PROVOKER                 = 16867642,
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]        = {  -2, -2, -122,    2, 2, -117, {45}}, -- floor 1 return
            [21]        = { -40, -2,  197,  -37, 2,  202, {41}}, -- floor 2 return
            [31]        = { 317, -2, -282,  322, 2, -277, {42}}, -- floor 3 return
            [41]        = { 277, -2,   38,  282, 2,   42, {43}}, -- floor 4 return
            [51]        = { -42, -2,   -2,  -36, 2,    2, {44}}, -- floor 5 return
            [16867699]  = { -43, -2, -362,  -36, 2, -356, {33}}, -- floor 1 MR1
            [16867700]  = {  76, -2,  -43,   82, 2,  -37, {32}}, -- floor 1 MR2
            [16867697]  = {-163, -2,  197, -156, 2,  203, {30}}, -- floor 2 MR1
            [16867698]  = {-162, -2,  117, -156, 2,  123, {31}}, -- floor 2 MR2
            [16867702]  = { 155, -2, -163,  163, 2, -156, {37}}, -- floor 3 MR1
            [16867703]  = { 236, -2,  -43,  243, 2,  -36, {35}}, -- floor 3 MR2
            [16867704]  = { 236, -2, -243,  243, 2, -236, {38}}, -- floor 3 MR3
            [16867705]  = { 356, -2,  -82,  362, 2,  -76, {36}}, -- floor 3 MR4
            [16867701]  = { 116, -2,   37,  122, 2,   42, {39}}, -- floor 4 MR1
            [16867706]  = { 435, -2,   38,  443, 2,   41, {40}}, -- floor 4 MR2
            [16867707]  = { 436, -2,  276,  443, 2,  283, {34}}, -- floor 4 MR3
        },
    },
}

return zones[tpz.zone.PROMYVION_VAHZL]
