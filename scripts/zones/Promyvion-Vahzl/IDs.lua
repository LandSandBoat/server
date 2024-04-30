-----------------------------------
-- Area: Promyvion-Vahzl
-----------------------------------
zones = zones or {}

zones[xi.zone.PROMYVION_VAHZL] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        OVERFLOWING_MEMORIES          = 7223, -- It appears to be a barrier woven from the energy of overflowing memories...
        ON_NM_SPAWN                   = 7227, -- You sense a dark, empty presence...
        NOTHING_OUT_OF_ORDINARY_MAP   = 7228, -- There is nothing out of the ordinary here.
        EERIE_GREEN_GLOW              = 7229, -- The sphere is emitting an eerie green glow.
        AMULET_RETURNED               = 7272, -- The <item> has been returned to you.
        LIGHT_OF_VAHZL                = 7273, -- You cannot remember when exactly, but you have obtained <item>!
        POPPED_NM_OFFSET              = 7309, -- Remnants of a cerebrator lie scattered about the area.
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16867387] = { 1, 3, 16867720 },
            [16867392] = { 1, 3, 16867721 },
            [16867439] = { 2, 5, 16867718 },
            [16867446] = { 2, 5, 16867719 },
            [16867504] = { 3, 5, 16867723 },
            [16867511] = { 3, 5, 16867724 },
            [16867518] = { 3, 5, 16867725 },
            [16867525] = { 3, 5, 16867726 },
            [16867601] = { 4, 7, 16867722 },
            [16867610] = { 4, 7, 16867727 },
            [16867619] = { 4, 7, 16867728 },
        },

        PONDERER   = GetFirstID('Ponderer'),
        PROPAGATOR = GetFirstID('Propagator'),
        SOLICITOR  = GetFirstID('Solicitor'),
        DEVIATOR   = GetFirstID('Deviator'),
        WAILER     = GetFirstID('Wailer'),
        PROVOKER   = GetFirstID('Provoker'),
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]       = {  -2, -2, -122,    2, 2, -117, { 45 } }, -- Floor 1 return
            [21]       = { -40, -2,  197,  -37, 2,  202, { 41 } }, -- Floor 2 return
            [31]       = { 317, -2, -282,  322, 2, -277, { 42 } }, -- Floor 3 return
            [41]       = { 277, -2,   38,  282, 2,   42, { 43 } }, -- Floor 4 return
            [51]       = { -42, -2,   -2,  -36, 2,    2, { 44 } }, -- Floor 5 return
            [16867720] = { -43, -2, -362,  -36, 2, -356, { 32 } }, -- Floor 1 MR S
            [16867721] = {  76, -2,  -43,   82, 2,  -37, { 33 } }, -- Floor 1 MR N
            [16867718] = { 163, -2,  197, -156, 2,  203, { 30 } }, -- Floor 2 MR N
            [16867719] = { 162, -2,  117, -156, 2,  123, { 31 } }, -- Floor 2 MR S
            [16867723] = { 155, -2, -163,  163, 2, -156, { 35 } }, -- Floor 3 MR W
            [16867724] = { 236, -2,  -43,  243, 2,  -36, { 36 } }, -- Floor 3 MR N
            [16867725] = { 236, -2, -243,  243, 2, -236, { 37 } }, -- Floor 3 MR S
            [16867726] = { 356, -2,  -82,  362, 2,  -76, { 38 } }, -- Floor 3 MR E
            [16867722] = { 116, -2,   37,  122, 2,   42, { 34 } }, -- Floor 4 MR SW
            [16867727] = { 435, -2,   38,  443, 2,   41, { 39 } }, -- Floor 4 MR SE
            [16867728] = { 436, -2,  276,  443, 2,  283, { 40 } }, -- Floor 4 MR NE
        },
    },
}

return zones[xi.zone.PROMYVION_VAHZL]
