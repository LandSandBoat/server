-----------------------------------
-- Area: Apollyon
-----------------------------------
zones = zones or {}

zones[xi.zone.APOLLYON] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7068, -- Tallying conquest results...
    },
    mob =
    {
        -- CS_CARNAGECHIEF_JACKBODOKK = GetFirstID('Carnagechief_Jackbodokk'),
        -- CS_DEE_WAPA_THE_DESOLATOR  = GetFirstID('Dee_Wapa_the_Desolator'),
        -- CS_NAQBA_CHIRURGEON        = GetFirstID('NaQba_Chirurgeon'),

        -- NE_APOLLYON_SWEEPER_OFFSET   = GetFirstID('Apollyon_Sweeper'),
        -- NE_GOOBBUE_HARVESTER         = GetFirstID('Goobbue_Harvester'),
        -- NE_TROGLODYTE_DHALMEL_OFFSET = GetFirstID('Troglodyte_Dhalmel'),

        -- NW_APOLLYON_SCAVENGER_OFFSET = GetFirstID('Apollyon_Scavenger'),
        -- NW_BARDHA_OFFSET             = GetFirstID('Bardha'),
        -- NW_CYNOPROSOPI               = GetFirstID('Cynoprosopi'),
        -- NW_GORYNICH_OFFSET           = GetFirstID('Gorynich'),
        -- NW_KAISER_BEHEMOTH           = GetFirstID('Kaiser_Behemoth'),
        -- NW_MILLENARY_MOSSBACK        = GetFirstID('Millenary_Mossback'),
        -- NW_MOUNTAIN_BUFFALO_OFFSET   = GetFirstID('Mountain_Buffalo'),
        -- NW_PLUTO                     = GetFirstID('Pluto'),
        -- NW_ZLATOROG                  = GetFirstID('Zlatorog'),

        -- SE_ADAMANTSHELL_OFFSET = GetFirstID('Adamantshell'),
        -- SE_FLYING_SPEAR_OFFSET = GetFirstID('Flying_Spear'),
        -- SE_TIEHOLTSODI         = GetFirstID('Tieholtsodi'),

        -- SW_BOSS_JIDRA               = GetFirstID('Jidra_Boss'),
        -- SW_AIR_ELEMENTAL_OFFSET     = GetFirstID('Air_Elemental'),
        -- SW_DARK_ELEMENTAL_OFFSET    = GetFirstID('Dark_Elemental'),
        -- SW_EARTH_ELEMENTAL_OFFSET   = GetFirstID('Earth_Elemental'),
        -- SW_FIRE_ELEMENTAL_OFFSET    = GetFirstID('Fire_Elemental'),
        -- SW_ICE_ELEMENTAL_OFFSET     = GetFirstID('Ice_Elemental'),
        -- SW_LIGHT_ELEMENTAL_OFFSET   = GetFirstID('Light_Elemental'),
        -- SW_THUNDER_ELEMENTAL_OFFSET = GetFirstID('Thunder_Elemental'),
        -- SW_WATER_ELEMENTAL_OFFSET   = GetFirstID('Water_Elemental'),
    },
    npc =
    {
        -- CENTRAL_LOOT_CRATE = GetFirstID('Central_Loot_Crate'),
        -- CS_LOOT_CRATE      = GetFirstID('CS_Loot_Crate'),
        -- NE_LOOT_CRATE      = GetFirstID('NE_Loot_Crate'),
        -- NW_LOOT_CRATE      = GetFirstID('NW_Loot_Crate'),
        -- SE_LOOT_CRATE      = GetFirstID('SE_Loot_Crate'),
        -- SW_LOOT_CRATE      = GetFirstID('SW_Loot_Crate'),
    },

    -- SW_APOLLYON =
    -- {
    --     npc =
    --     {
    --         PORTAL =
    --         {
    --             16933231,
    --             16933232,
    --             16933233,
    --         },
    --         ITEM_CRATES =
    --         {
    --             16932865,
    --             16932878,
    --             16932896,
    --         },

    --         RECOVER_CRATES =
    --         {
    --             16932867,
    --             16932880,
    --             16932898,
    --         },

    --         TIME_CRATES =
    --         {
    --             16932866,
    --             16932879,
    --             16932897,
    --         },
    --     },

    --     LINKED_CRATES =
    --     {
    --         [16932865] = { 16932866, 16932867 },
    --         [16932866] = { 16932865, 16932867 },
    --         [16932867] = { 16932865, 16932866 },
    --         [16932878] = { 16932879, 16932880 },
    --         [16932879] = { 16932878, 16932880 },
    --         [16932880] = { 16932878, 16932879 },
    --     },
    -- },

    -- SE_APOLLYON =
    -- {
    --     npc =
    --     {
    --         PORTAL =
    --         {
    --             16933240,
    --             16933239,
    --             16933242,
    --         },
    --         ITEM_CRATES =
    --         {
    --             16932991,
    --             16933005,
    --             16933019,
    --         },
    --         RECOVER_CRATES =
    --         {
    --             16932990,
    --             16933004,
    --             16933018,
    --         },
    --         TIME_CRATES =
    --         {
    --             16932989,
    --             16933003,
    --             16933017,
    --         },
    --     },
    -- },

    -- NW_APOLLYON =
    -- {
    --     npc =
    --     {
    --         PORTAL =
    --         {
    --             16933227,
    --             16933228,
    --             16933229,
    --             16933225,
    --         },
    --         ITEM_CRATES =
    --         {
    --             16932934,
    --             16932947,
    --             16932960,
    --             16932973,
    --         },

    --         RECOVER_CRATES =
    --         {
    --             16932936,
    --             16932949,
    --             16932962,
    --             16932983,
    --         },

    --         TIME_CRATES =
    --         {
    --             16932935,
    --             16932945,
    --             16932946,
    --             16932948,
    --             16932958,
    --             16932959,
    --             16932961,
    --             16932971,
    --             16932972,
    --             16932974,
    --             16932975,
    --             16932982,
    --         },
    --     },
    -- },

    -- NE_APOLLYON =
    -- {
    --     npc =
    --     {
    --         PORTAL =
    --         {
    --             16933236,
    --             16933235,
    --             16933234,
    --             16933238,
    --         },
    --         ITEM_CRATES =
    --         {
    --             16933041,
    --             16933059,
    --             16933076,
    --             16933096,
    --         },

    --         RECOVER_CRATES =
    --         {
    --             16933053,
    --             16933061,
    --             16933078,
    --             16933098,
    --         },

    --         TIME_CRATES =
    --         {
    --             16933042,
    --             16933043,
    --             16933054,
    --             16933060,
    --             16933074,
    --             16933075,
    --             16933077,
    --             16933079,
    --             16933080,
    --             16933097,
    --             16933110,
    --             16933111,
    --         },
    --     },
    -- },

    -- CENTRAL_APOLLYON =
    -- {
    -- },

    -- CS_APOLLYON =
    -- {
    --     npc =
    --     {
    --         TIME_CRATES =
    --         {
    --             16933127,
    --             16933128,
    --         },
    --     },
    -- },
}

return zones[xi.zone.APOLLYON]
