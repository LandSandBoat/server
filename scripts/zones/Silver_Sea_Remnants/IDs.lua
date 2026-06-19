-----------------------------------
-- Area: Silver_Sea_Remnants
-----------------------------------
zones = zones or {}

zones[xi.zone.SILVER_SEA_REMNANTS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CELL_OFFSET                   = 7231, -- Main Weapon/Sub-Weapon restriction removed.

        -- Check all these IDs
        -- FULL_INVENTORY_AFTER_TRADE    = 6389, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        -- KEYITEM_LOST                  = 6397, -- Lost key item: <keyitem>.
        -- TEMP_ITEM                     = 7064, -- Obtained temporary item: <item>!SALVAGE_START                 = 7253, -- You feel an incredible pressure bearing down on you. This area appears to be blanketed in some sort of intense psionic field...
        -- TIME_TO_COMPLETE              = 7425, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        -- MISSION_FAILED                = 7426, -- The mission has failed. Leaving area.
        -- TIME_REMAINING_MINUTES        = 7430, -- Time remaining: <number> [minute/minutes] (Earth time).
        -- TIME_REMAINING_SECONDS        = 7431, -- Time remaining: <number> [second/seconds] (Earth time).
        -- PARTY_FALLEN                  = 7433, -- All party members have fallen in battle. Mission failure in <number> [minute/minutes].
        -- DOOR_IS_SEALED                = 7444, -- The door is sealed...
        -- DOOR_IS_SEALED_MYSTERIOUS     = 7446, -- The door is sealed by some mysterious force...
        -- SOCKET_TRIGGER                = 7448, -- You hear a ragged sighing from beneath the floor...
        -- SLOT_TRIGGER                  = 7449, -- You hear a scuttering sound from beneath the floor...
    },
    mob =
    {
        [1] = -- 1st Floor
        {
            [1] = -- E Path
            {
                mobs_start = 17088513,
                mobs_end   = 17088533,
            },
            [2] = -- W Path
            {
                mobs_start = 17088534,
                mobs_end   = 17088556,
                hammerblow = GetFirstID('Hammerblow_Majanun'),
            },
            [3] = -- Central Room
            {
                mobs_start = 17088558,
                mobs_end   = 17088573,
            },
        },
    },
    npc =
    {
        [0] = -- Chests
        {
            TEMP_ITEMS_BOX =
            {
                -- Will do after base functionality of SSR is done as SSR isn't implemented at all.
            },
            STATIC_ITEMS_BOX =
            {
                -- Will do after base functionality of SSR is done as SSR isn't implemented at all.
            }
        },
        [1] = -- 1st Floor
        {
            [2] =
            {
                ARMOURY_CRATE = GetFirstID('Armoury_Crate'),
                DOOR1         = GetFirstID('_240'), -- Starting Door
                DOOR2         = GetFirstID('_241'), -- W Door
                DOOR3         = GetFirstID('_242'), -- E Door
            },
        },
    },
    drops =
    {
        [1] = -- Floor 1 E Path
        {
            [0] = -- COR
            {
                { xi.item.OPACUS_CELL, xi.item.OPACUS_CELL, xi.item.OPACUS_CELL, xi.item.RADIATUS_CELL, xi.item.RADIATUS_CELL },
                { xi.item.HUMILUS_CELL, xi.item.HUMILUS_CELL, xi.item.HUMILUS_CELL, xi.item.PILEUS_CELL, xi.item.PILEUS_CELL },
            },
            [1] = -- MNK
            {
                { xi.item.INCUS_CELL, xi.item.INCUS_CELL, xi.item.INCUS_CELL, xi.item.PANNUS_CELL, xi.item.PANNUS_CELL },
                { xi.item.PRAECIPITATIO_CELL, xi.item.PRAECIPITATIO_CELL, xi.item.PRAECIPITATIO_CELL, xi.item.STRATUS_CELL, xi.item.STRATUS_CELL },
            },
            [2] = -- RDM
            {
                { xi.item.UNDULATUS_CELL, xi.item.UNDULATUS_CELL, xi.item.UNDULATUS_CELL, xi.item.CIRROCUMULUS_CELL, xi.item.CIRROCUMULUS_CELL },
                { xi.item.CUMULUS_CELL, xi.item.CUMULUS_CELL, xi.item.CUMULUS_CELL, xi.item.SPISSATUS_CELL, xi.item.SPISSATUS_CELL },
            },
            [3] = -- RNG
            {
                { xi.item.DUPLICATUS_CELL, xi.item.DUPLICATUS_CELL, xi.item.DUPLICATUS_CELL, xi.item.CASTELLANUS_CELL, xi.item.CASTELLANUS_CELL },
                { xi.item.CONGESTUS_CELL, xi.item.CONGESTUS_CELL, xi.item.CONGESTUS_CELL, xi.item.VIRGA_CELL, xi.item.VIRGA_CELL },
            },
        },
        [2] = -- Floor 1 W Path
        {
            [1] = -- RDM
            {
                { xi.item.HUMILUS_CELL, xi.item.HUMILUS_CELL, xi.item.HUMILUS_CELL, xi.item.SPISSATUS_CELL },
                { xi.item.CUMULUS_CELL, xi.item.CUMULUS_CELL, xi.item.CUMULUS_CELL, xi.item.STRATUS_CELL },
            },
            [2] = -- MNK
            {
                { xi.item.INCUS_CELL, xi.item.INCUS_CELL, xi.item.INCUS_CELL, xi.item.RADIATUS_CELL },
                { xi.item.PRAECIPITATIO_CELL, xi.item.PRAECIPITATIO_CELL, xi.item.PRAECIPITATIO_CELL, xi.item.CONGESTUS_CELL },
            },
            [3] = -- COR
            {
                { xi.item.OPACUS_CELL, xi.item.OPACUS_CELL, xi.item.OPACUS_CELL, xi.item.PANNUS_CELL },
            },
            [4] = -- RNG
            {
                { xi.item.DUPLICATUS_CELL, xi.item.DUPLICATUS_CELL, xi.item.DUPLICATUS_CELL, xi.item.UNDULATUS_CELL },
            },
            [5] = -- RDM
            {
                { xi.item.HUMILUS_CELL, xi.item.HUMILUS_CELL, xi.item.HUMILUS_CELL, xi.item.SPISSATUS_CELL },
                { xi.item.CUMULUS_CELL, xi.item.CUMULUS_CELL, xi.item.CUMULUS_CELL, xi.item.STRATUS_CELL },
            },
            [6] = -- MNK
            {
                { xi.item.INCUS_CELL, xi.item.INCUS_CELL, xi.item.INCUS_CELL, xi.item.RADIATUS_CELL },
                { xi.item.PRAECIPITATIO_CELL, xi.item.PRAECIPITATIO_CELL, xi.item.PRAECIPITATIO_CELL, xi.item.CONGESTUS_CELL },
            },
        },
        [3] = -- General Cell Pools
        {
            CELLS = -- All cells (1F both paths, 2F NE/SW/SE, 3F, 4F)
            {
                xi.item.INCUS_CELL,
                xi.item.CASTELLANUS_CELL,
                xi.item.CUMULUS_CELL,
                xi.item.RADIATUS_CELL,
                xi.item.STRATUS_CELL,
                xi.item.CIRROCUMULUS_CELL,
                xi.item.UNDULATUS_CELL,
                xi.item.VIRGA_CELL,
                xi.item.DUPLICATUS_CELL,
                xi.item.OPACUS_CELL,
                xi.item.PRAECIPITATIO_CELL,
                xi.item.PANNUS_CELL,
                xi.item.FRACTUS_CELL,
                xi.item.CONGESTUS_CELL,
                xi.item.NIMBUS_CELL,
                xi.item.VELUM_CELL,
                xi.item.PILEUS_CELL,
                xi.item.MEDIOCRIS_CELL,
                xi.item.HUMILUS_CELL,
                xi.item.SPISSATUS_CELL,
            },
        },
    },
}

return zones[xi.zone.SILVER_SEA_REMNANTS]
