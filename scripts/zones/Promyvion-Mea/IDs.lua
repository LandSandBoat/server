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
        BARRIER_WOVEN                 = 7223, -- It appears to be a barrier woven from the energy of overflowing memories...
        NOTHING_OUT_OF_ORDINARY_MAP   = 7224, -- There is nothing out of the ordinary here.
        EERIE_GREEN_GLOW              = 7225, -- The sphere is emitting an eerie green glow.
    },
    mob =
    {
        MEMORY_RECEPTACLES =
        {
            [16859155] = { 1, 3, 16859483 },
            [16859205] = { 2, 5, 16859486 },
            [16859212] = { 2, 5, 16859490 },
            [16859219] = { 2, 5, 16859491 },
            [16859226] = { 2, 5, 16859492 },
            [16859296] = { 3, 7, 16859484 },
            [16859305] = { 3, 7, 16859485 },
            [16859314] = { 3, 7, 16859487 },
            [16859376] = { 4, 7, 16859488 },
            [16859385] = { 4, 7, 16859489 },
            [16859394] = { 4, 7, 16859493 },
        },

        COVETER    = 16859472,
    },
    npc =
    {
        MEMORY_STREAMS =
        {
            [11]       = { -122, -4,  197, -117, 4,  202, { 46 } }, -- Floor 1 return
            [21]       = {   -1, -4, -121,    2, 4, -118, { 41 } }, -- Floor 2 return
            [31]       = { -161, -4,  158, -157, 4,  161, { 42 } }, -- Floor 3 (West) return
            [32]       = {  158, -4, -281,  161, 4, -278, { 43 } }, -- Floor 3 (East) return
            [41]       = {  -82, -4,  358,  -78, 4,  361, { 33 } }, -- Floor 4 return
            -- TODO: Cleanup promyvions. It knows where you came from and will only return the apropiate event acordingly.
            -- Event 44 -> Return to floor 3 West
            -- Event 45 -> Return to floor 3 East

            [16859483] = { -283, -4,  237, -276, 4,  242, { 30 } }, -- Floor 1 MR
            [16859486] = {  -82, -4,  -42,  -78, 4,  -38, { 33 } }, -- Floor 2 MR N  - Destination: East
            [16859490] = { -322, -4, -361, -318, 4, -357, { 37 } }, -- Floor 2 MR SW - Destination: West
            [16859491] = {  -42, -4, -321,  -37, 4, -317, { 38 } }, -- Floor 2 MR S  - Destination: West
            [16859492] = {   77, -4, -241,   81, 4, -238, { 39 } }, -- Floor 2 MR SE - Destination: East
            [16859484] = { -321, -4,  -42, -318, 4,  -38, { 31 } }, -- Floor 3 (West) MR SW
            [16859485] = { -241, -4,  -42, -238, 4,  -37, { 32 } }, -- Floor 3 (West) MR S
            [16859487] = {  -42, -4,   -2,  -38, 4,    2, { 34 } }, -- Floor 3 (West) MR SE
            [16859488] = {  198, -4,   -2,  201, 4,    2, { 35 } }, -- Floor 3 (East) MR NW
            [16859489] = {  358, -4,  -41,  362, 4,  -38, { 36 } }, -- Floor 3 (East) MR NE
            [16859493] = {  240, -4, -322,  244, 4, -317, { 40 } }, -- Floor 3 (East) MR SW
        },
    },
}

return zones[xi.zone.PROMYVION_MEA]
