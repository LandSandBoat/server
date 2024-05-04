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
        NOTHING_OUT_OF_ORDINARY_MAP   = 7224, -- There is nothing out of the ordinary here.
        EERIE_GREEN_GLOW              = 7225, -- The sphere is emitting an eerie green glow.
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

        SATIATOR    = 16851267,
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]       = {  160, 3,  -80, 0, 0, 0, { 46 } }, -- Floor 1 return
            [21]       = { -280, 3,    0, 0, 0, 0, { 41 } }, -- Floor 2 return
            [31]       = { -160, 3,  440, 0, 0, 0, { 43 } }, -- Floor 3 (North) return
            [32]       = {    0, 3, -320, 0, 0, 0, { 42 } }, -- Floor 3 (South) return
            [41]       = {  360, 3,  240, 0, 0, 0, { 44 } }, -- Floor 4 return
            -- TODO: Cleanup prmyvions. It knows where you came from and will only return the apropiate event acordingly.
            -- Event 44 -> Return to floor 3 South
            -- Event 45 -> Return to floor 3 North

            [16851278] = {  120, 3, -280, 0, 0, 0, { 30 } }, -- Floor 1 MR
            [16851282] = {  -80, 3,  -80, 0, 0, 0, { 36 } }, -- Floor 2 MR SE - Destination: North
            [16851283] = {  -80, 3,   80, 0, 0, 0, { 37 } }, -- Floor 2 MR NE - Destination: South
            [16851284] = { -280, 3, -200, 0, 0, 0, { 34 } }, -- Floor 2 MR SW - Destination: South
            [16851285] = { -360, 3,   40, 0, 0, 0, { 35 } }, -- floor 2 MR NW - Destination: North
            [16851279] = {   40, 3, -200, 0, 0, 0, { 31 } }, -- Floor 3 (South) MR NE
            [16851280] = { -120, 3, -240, 0, 0, 0, { 32 } }, -- Floor 3 (South) MR NW
            [16851281] = { -120, 3, -400, 0, 0, 0, { 33 } }, -- Floor 3 (South) MR SW
            [16851286] = { -320, 3,  160, 0, 0, 0, { 38 } }, -- Floor 3 (North) MR SW
            [16851287] = {  -40, 3,  320, 0, 0, 0, { 39 } }, -- Floor 3 (North) MR NE
            [16851288] = { -120, 3,  160, 0, 0, 0, { 40 } }, -- Floor 3 (North) MR SE
        },
    },
}

return zones[xi.zone.PROMYVION_DEM]
