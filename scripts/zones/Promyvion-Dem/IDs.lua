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
        BARRIER_WOVEN                 = 7226, -- It appears to be a barrier woven from the energy of overflowing memories...
        EERIE_GREEN_GLOW              = 7228, -- The sphere is emitting an eerie green glow.
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16850972] = { 1, 3, 16851278 },
            [16851026] = { 2, 5, 16851282 },
            [16851033] = { 2, 5, 16851283 },
            [16851040] = { 2, 5, 16851284 },
            [16851047] = { 2, 5, 16851285 },
            [16851073] = { 3, 7, 16851279 },
            [16851082] = { 3, 7, 16851280 },
            [16851091] = { 3, 7, 16851281 },
            [16851152] = { 4, 7, 16851286 },
            [16851161] = { 4, 7, 16851287 },
            [16851170] = { 4, 7, 16851288 },
        },

        SATIATOR = GetFirstID('Satiator'),
    },
    npc =
    {
        MEMORY_STREAM_OFFSET = GetFirstID('_0i1'),
    },
}

return zones[xi.zone.PROMYVION_DEM]
