-----------------------------------
-- Area: The_Garden_of_RuHmet (35)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------
zones = zones or {}

zones[xi.zone.THE_GARDEN_OF_RUHMET] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        PARTY_MEMBERS_HAVE_FALLEN     = 7410, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7417, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7450, -- Tallying conquest results...
        NO_NEED_INVESTIGATE           = 7629, -- There is no need to investigate further.
        PORTAL_SEALED                 = 7658, -- The portal is firmly sealed by a mysterious energy.
        UNKNOWN_PRESENCE              = 7766, -- You sense some unknown presence...
        NONE_HOSTILE                  = 7767, -- You sense some unknown presence, but it does not seem hostile.
        MENACING_CREATURES            = 7768, -- Menacing creatures appear out of nowhere!
        SHEER_ANIMOSITY               = 7769, -- <name> is enveloped in sheer animosity!
        HOMEPOINT_SET                 = 7774, -- Home point set!
    },

    mob =
    {
        AWAERN_DRG_GROUPS = -- First Aw'Aerns in each group. Used to randomize the mobID as the new placeholder.
        {
            16920777,
            16920781,
            16920785,
            16920789,
        },

        AWAERN_DRK_GROUPS =
        {
            16920646, -- SW
            16920651, -- NW
            16920660, -- NE
            16920665, -- SE
        },

        JAILER_OF_FORTITUDE = DYNAMIC_LOOKUP,
        KFGHRAH_WHM         = DYNAMIC_LOOKUP,
        KFGHRAH_BLM         = DYNAMIC_LOOKUP,
        IXAERN_DRK          = DYNAMIC_LOOKUP,
        JAILER_OF_FAITH     = DYNAMIC_LOOKUP,
        IXAERN_DRG          = DYNAMIC_LOOKUP,
        IXZDEI_BASE         = 16921011,
    },

    npc =
    {
        QM_IXAERN_DRK_POS =
        {
            { -560, 5.00, 239 }, -- Taru-Mithra
            { -600, 5.00, 440 }, -- Mithra-Hume
            { -240, 5.00, 440 }, -- Hume-Elvaan
            { -280, 5.00, 240 }, -- Elvaan-Galka
        },

        QM_JAILER_OF_FORTITUDE_POS =
        {
            { -420.00, 0.00, 755.00 }, -- North / Hume tower.
            {  -43.00, 0.00, 460.00 }, -- NE / Elvaan tower.
            { -260.00, 0.00, 44.821 }, -- SE / Galka tower.
            { -580.00, 0.00,  43.00 }, -- SW / Tarutaru tower.
            { -796.00, 0.00, 460.00 }, -- NW / Mithra tower.
        },

        QM_JAILER_OF_FAITH_POS =
        {
            { -420.00, 0.00, -157.00 }, -- North / Hume tower.
            { -157.00, 0.00, -340.00 }, -- NE / Elvaan tower.
            { -260.00, 0.00, -643.00 }, -- SE / Galka tower.
            { -580.00, 0.00, -644.00 }, -- SW / Tarutaru tower.
            { -683.00, 0.00, -340.00 }, -- NW / Mithra tower.
        },

        QM_JAILER_OF_FORTITUDE = DYNAMIC_LOOKUP,
        QM_IXAERN_DRK          = DYNAMIC_LOOKUP,
        QM_JAILER_OF_FAITH     = DYNAMIC_LOOKUP,
    },
}

return zones[xi.zone.THE_GARDEN_OF_RUHMET]
