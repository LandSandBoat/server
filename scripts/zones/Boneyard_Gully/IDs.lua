-----------------------------------
-- Area: Boneyard_Gully
-----------------------------------
zones = zones or {}

zones[xi.zone.BONEYARD_GULLY] =
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
        CONQUEST_BASE                 = 7432, -- Tallying conquest results...
        TUCHULCHA_SANDPIT             = 7751, -- Tuchulcha retreats beneath the soil!
    },
    mob =
    {
    },
    npc =
    {
    },
    sheepInAntlionsClothing =
    {
        [1] =
        {
            TUCHULCHA_ID      = GetFirstID("Tuchulcha"),
            SWIFT_HUNTER_ID   = GetFirstID("Swift_Hunter"),
            SHREWD_HUNTER_ID  = GetFirstID("Shrewd_Hunter"),
            ARMORED_HUNTER_ID = GetFirstID("Armored_Hunter"),
            -- List of positions used to set
            -- (1) Tuchulcha's location after using sand pit
            -- (2) The starting position of the hunters
            ant_positions =
            {
                { -517, 1.8, -521, 171 },
                { -534, 1.8, -460, 171 },
                { -552, 4.0, -440, 171 },
                { -572, -1.8, -464, 171 },
                { -573, 4.0, -427, 171 },
                { -562, 1.8, -484, 171 },
                { -593, 1.8, -480, 171 },
            },
        },
        [2] =
        {
            TUCHULCHA_ID      = GetFirstID("Tuchulcha") + 6,
            SWIFT_HUNTER_ID   = GetFirstID("Swift_Hunter") + 6,
            SHREWD_HUNTER_ID  = GetFirstID("Shrewd_Hunter") + 6,
            ARMORED_HUNTER_ID = GetFirstID("Armored_Hunter") + 6,
            ant_positions =
            {
                { 43, 1.8, 40, 7 },
                { 26, 1.8, 100, 7 },
                { 7, 4.0, 118, 7 },
                { -13, -1.8, 95, 7 },
                { -13, 4.0, 133, 7 },
                { -2.3, 1.8, 76, 7 },
                { -33, 1.8, 79, 7 },
            },
        },
        [3] =
        {
            TUCHULCHA_ID      = GetFirstID("Tuchulcha") + 12,
            SWIFT_HUNTER_ID   = GetFirstID("Swift_Hunter") + 12,
            SHREWD_HUNTER_ID  = GetFirstID("Shrewd_Hunter") + 12,
            ARMORED_HUNTER_ID = GetFirstID("Armored_Hunter") + 12,
            ant_positions =
            {
                { 522, 1.8, 521, 240 },
                { 506, 1.8, 580, 240 },
                { 466, 4.0, 614, 240 },
                { 467, -1.8, 574, 240 },
                { 488, 4.0, 598, 240 },
                { 478, 1.8, 557, 240 },
                { 446, 1.8, 558, 240 },
            },
        },
    },
    shellWeDance =
    {
        [1] =
        {
            PARATA_ID        = GetFirstID("Parata"),
            BLADMALL_ID      = GetFirstID("Bladmall"),
            PARATA_PET_IDS   = GetTableOfIDs("Nepionic_Parata", 3),
            BLADMALL_PET_IDS = GetTableOfIDs("Nepionic_Bladmall", 3),
        },
        [2] =
        {
            PARATA_ID        = GetFirstID("Parata") + 9,
            BLADMALL_ID      = GetFirstID("Bladmall") + 9,
            PARATA_PET_IDS   =
            {
                GetFirstID("Nepionic_Parata") + 8,
                GetFirstID("Nepionic_Parata") + 9,
                GetFirstID("Nepionic_Parata") + 10
            },
            BLADMALL_PET_IDS =
            {
                GetFirstID("Nepionic_Bladmall") + 8,
                GetFirstID("Nepionic_Bladmall") + 9,
                GetFirstID("Nepionic_Bladmall") + 10
            },
        },
        [3] =
        {
            PARATA_ID        = GetFirstID("Parata") + 18,
            BLADMALL_ID      = GetFirstID("Bladmall") + 18,
            PARATA_PET_IDS   =
            {
                GetFirstID("Nepionic_Parata") + 16,
                GetFirstID("Nepionic_Parata") + 17,
                GetFirstID("Nepionic_Parata") + 18
            },
            BLADMALL_PET_IDS =
            {
                GetFirstID("Nepionic_Bladmall") + 16,
                GetFirstID("Nepionic_Bladmall") + 17,
                GetFirstID("Nepionic_Bladmall") + 18
            },
        },
    },
}

return zones[xi.zone.BONEYARD_GULLY]
