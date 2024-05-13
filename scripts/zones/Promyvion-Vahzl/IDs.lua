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
        NOTHING_OUT_OF_ORDINARY_MAP   = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        OVERFLOWING_MEMORIES          = 7226, -- It appears to be a barrier woven from the energy of overflowing memories...
        ON_NM_SPAWN                   = 7230, -- You sense a dark, empty presence...
        EERIE_GREEN_GLOW              = 7232, -- The sphere is emitting an eerie green glow.
        AMULET_RETURNED               = 7275, -- The <item> has been returned to you.
        LIGHT_OF_VAHZL                = 7276, -- You cannot remember when exactly, but you have obtained <item>!
        POPPED_NM_OFFSET              = 7312, -- Remnants of a cerebrator lie scattered about the area.
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
        MEMORY_STREAM_OFFSET = GetFirstID('_0m1'),
    },
}

return zones[xi.zone.PROMYVION_VAHZL]
