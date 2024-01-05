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
        PARTY_MEMBERS_HAVE_FALLEN     = 7411, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7418, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        CONQUEST_BASE                 = 7435, -- Tallying conquest results...
        TUCHULCHA_SANDPIT             = 7754, -- Tuchulcha retreats beneath the soil!
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
            TUCHULCHA_ID      = 16810001,
            SWIFT_HUNTER_ID   = 16810002,
            SHREWD_HUNTER_ID  = 16810003,
            ARMORED_HUNTER_ID = 16810004,
            -- List of positions used to set
            -- (1) Tuchulcha's location after using sand pit
            -- (2) The starting position of the hunters
            ant_positions =
            {
                { -517,    0, -521, 171 },
                { -534,    0, -460, 171 },
                { -552,  2.2, -440, 171 },
                { -572, -3.6, -464, 171 },
                { -573,  2.2, -427, 171 },
                { -562,    0, -484, 171 },
                { -593,    0, -480, 171 },
                { -610, -1.5, -490, 171 },
            },
        },
        [2] =
        {
            TUCHULCHA_ID      = 16810007,
            SWIFT_HUNTER_ID   = 16810008,
            SHREWD_HUNTER_ID  = 16810009,
            ARMORED_HUNTER_ID = 16810010,
            ant_positions =
            {
                {   43,    0,  40, 7 },
                {   26,    0, 100, 7 },
                {    7,  2.2, 118, 7 },
                {  -13, -3.6,  95, 7 },
                {  -13,  2.2, 133, 7 },
                { -2.3,    0,  76, 7 },
                {  -33,    0,  79, 7 },
                {  -54, -1.5,  67, 7 },
            },
        },
        [3] =
        {
            TUCHULCHA_ID      = 16810013,
            SWIFT_HUNTER_ID   = 16810014,
            SHREWD_HUNTER_ID  = 16810015,
            ARMORED_HUNTER_ID = 16810016,
            ant_positions =
            {
                { 522,    0, 521, 240 },
                { 506,    0, 580, 240 },
                { 466,  2.2, 614, 240 },
                { 467, -3.6,  57, 240 },
                { 488,  2.2, 598, 240 },
                { 478,    0, 557, 240 },
                { 446,    0, 558, 240 },
                { 430, -1.5, 550, 240 },
            },
        },
    },
    shellWeDance =
    {
        [1] =
        {
            PARATA_ID        = 16810024,
            BLADMALL_ID      = 16810025,
            PARATA_PET_IDS   = { 16810026, 16810027, 16810028 },
            BLADMALL_PET_IDS = { 16810029, 16810030, 16810031 },
        },
        [2] =
        {
            PARATA_ID        = 16810033,
            BLADMALL_ID      = 16810034,
            PARATA_PET_IDS   = { 16810035, 16810036, 16810037 },
            BLADMALL_PET_IDS = { 16810038, 16810039, 16810040 },
        },
        [3] =
        {
            PARATA_ID        = 16810042,
            BLADMALL_ID      = 16810043,
            PARATA_PET_IDS   = { 16810044, 16810045, 16810046 },
            BLADMALL_PET_IDS = { 16810047, 16810048, 16810049 },
        },
    },
}

return zones[xi.zone.BONEYARD_GULLY]
