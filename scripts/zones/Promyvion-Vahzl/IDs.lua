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
            [11]       = {    0, 3, -120, 0, 0, 0, { 45 } }, -- Floor 1 return
            [21]       = {  -40, 3,  200, 0, 0, 0, { 41 } }, -- Floor 2 return
            [31]       = {  320, 3, -280, 0, 0, 0, { 42 } }, -- Floor 3 return
            [41]       = {  280, 3,   40, 0, 0, 0, { 43 } }, -- Floor 4 return
            [51]       = {  -40, 3,    0, 0, 0, 0, { 44 } }, -- Floor 5 return
            [16867720] = {  -40, 3, -360, 0, 0, 0, { 32 } }, -- Floor 1 MR S
            [16867721] = {   80, 3,  -40, 0, 0, 0, { 33 } }, -- Floor 1 MR N
            [16867718] = { -160, 3,  200, 0, 0, 0, { 30 } }, -- Floor 2 MR N
            [16867719] = { -160, 3,  120, 0, 0, 0, { 31 } }, -- Floor 2 MR S
            [16867723] = {  160, 3, -160, 0, 0, 0, { 35 } }, -- Floor 3 MR W
            [16867724] = {  240, 3,  -40, 0, 0, 0, { 36 } }, -- Floor 3 MR N
            [16867725] = {  240, 3, -240, 0, 0, 0, { 37 } }, -- Floor 3 MR S
            [16867726] = {  360, 3,  -80, 0, 0, 0, { 38 } }, -- Floor 3 MR E
            [16867722] = {  120, 3,   40, 0, 0, 0, { 34 } }, -- Floor 4 MR SW
            [16867727] = {  440, 3,   40, 0, 0, 0, { 39 } }, -- Floor 4 MR SE
            [16867728] = {  440, 3,  279, 0, 0, 0, { 40 } }, -- Floor 4 MR NE
        },
    },
}

return zones[xi.zone.PROMYVION_VAHZL]
