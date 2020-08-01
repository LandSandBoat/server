-----------------------------------
-- Area: The_Garden_of_RuHmet
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.THE_GARDEN_OF_RUHMET] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        CONQUEST_BASE           = 7439, -- Tallying conquest results...
        NO_NEED_INVESTIGATE     = 7618, -- There is no need to investigate further.
        PORTAL_SEALED           = 7647, -- The portal is firmly sealed by a mysterious energy.
        UNKNOWN_PRESENCE        = 7755, -- You sense some unknown presence...
        NONE_HOSTILE            = 7756, -- You sense some unknown presence, but it does not seem hostile.
        MENACING_CREATURES      = 7757, -- Menacing creatures appear out of nowhere!
        SHEER_ANIMOSITY         = 7758, -- <name> is enveloped in sheer animosity!
        HOMEPOINT_SET           = 7763, -- Home point set!
    },
    mob =
    {
        AWAERN_DRG_GROUPS   = -- First Aw'Aerns in each group. Used to randomize the mobID as the new placeholder.
        {
            16920777,
            16920781,
            16920785,
            16920789,
        },
        AWAERN_DRK_GROUPS   = {
            16920660, -- NE
            16920665, -- SE
            16920646, -- SW
            16920651, -- NW
        },
        JAILER_OF_FORTITUDE = 16921015,
        KFGHRAH_WHM         = 16921016,
        KFGHRAH_BLM         = 16921017,
        IXAERN_DRK          = 16921018,
        JAILER_OF_FAITH     = 16921021,
        IXAERN_DRG          = 16921022,
    },
    npc =
    {
        IXAERN_DRK_QM_POS          =
        {
            {-240, 5.00, 440}, -- Hume-Elvaan
            {-280, 5.00, 240}, -- Elvaan-Galka
            {-560, 5.00, 239}, -- Taru-Mithra
            {-600, 5.00, 440}, -- Mithra-Hume
        },
        JAILER_OF_FORTITUDE_QM_POS =
        {
            {-420.00, 0.00, 755.00}, -- North / Hume tower.
            {-43.00, 0.00, 460.00},  -- NE / Elvaan tower.
            {-260.00, 0.00, 44.821}, -- SE / Galka tower.
            {-580.00, 0.00, 43.00},  -- SW / Tarutaru tower.
            {-796.00, 0.00, 460.00}, -- NW / Mithra tower.
        },
        JAILER_OF_FAITH_QM_POS     =
        {
            {-420.00, 0.00, -157.00}, -- North / Hume tower.
            {-157.00, 0.00, -340.00}, -- NE / Elvaan tower.
            {-260.00, 0.00, -643.00}, -- SE / Galka tower.
            {-580.00, 0.00, -644.00}, -- SW / Tarutaru tower.
            {-683.00, 0.00, -340.00}, -- NW / Mithra tower.
        },
        JAILER_OF_FORTITUDE_QM     = 16921027,
        IXAERN_DRK_QM              = 16921028,
        JAILER_OF_FAITH_QM         = 16921029,
    },
}

return zones[tpz.zone.THE_GARDEN_OF_RUHMET]
