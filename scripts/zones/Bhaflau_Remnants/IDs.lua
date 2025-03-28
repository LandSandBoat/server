-----------------------------------
-- Area: Bhaflau_Remnants
-----------------------------------
zones = zones or {}

zones[xi.zone.BHAFLAU_REMNANTS] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395, -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6400, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS           = 7002, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024, -- Your party is unable to participate because certain members' levels are restricted.
        TEMP_ITEM                     = 7062, -- Obtained temporary item: <item>.
        CELL_OFFSET                   = 7227, -- Main Weapon/Sub-Weapon restriction removed.
        HAVE_TEMP_ITEM                = 7249, -- You already have that temporary item.
        SALVAGE_START                 = 7250, -- You feel an incredible pressure bearing down on you. This area appears to be blanketed in some sort of intense psionic field...
        TIME_TO_COMPLETE              = 7422, -- You have <number> [minute/minutes] (Earth time) to complete this mission.
        MISSION_FAILED                = 7423, -- The mission has failed. Leaving area.
        TIME_REMAINING_MINUTES        = 7427, -- ime remaining: <number> [minute/minutes] (Earth time).
        TIME_REMAINING_SECONDS        = 7428, -- ime remaining: <number> [second/seconds] (Earth time).
        PARTY_FALLEN                  = 7430, -- ll party members have fallen in battle. Mission failure in <number> [minute/minutes].
        DOOR_IS_SEALED                = 7441, -- The door is sealed...
        SOCKET_TRIGGER                = 7445, -- You hear a ragged sighing from beneath the floor...
        SLOT_TRIGGER                  = 7446, -- You hear a scuttering sound from beneath the floor...
    },
    mob =
    {
        ARCHAIC_CHARIOT    = GetTableOfIDs('Archaic_Chariot'),
        ARCHAIC_GEARS      = GetTableOfIDs('Archaic_Gears'),
        ARCHAIC_GEAR       = GetTableOfIDs('Archaic_Gear'),
        BIFRONS            = GetTableOfIDs('Bifrons'),
        BLACK_PUDDING      = GetTableOfIDs('Black_Pudding'),
        CARMINE_ERUCA      = GetTableOfIDs('Carmine_Eruca'),
        DEMENTED_JALAWAA   = GetFirstID('Demented_Jalawaa'),
        EMPATHIC_FLAN      = GetTableOfIDs('Empathic_Flan'),
        FLUX_FLAN          = GetFirstID('Flux_Flan'),
        LONG_BOWED_CHARIOT = GetFirstID('Long-Bowed_Chariot'),
        MAD_BOMBER         = GetFirstID('Mad_Bomber'),
        REACTION_RAMPART   = GetTableOfIDs('Reactionary_Rampart'),
        TROLL_CAMEIST      = GetTableOfIDs('Troll_Cameist'),
        TROLL_ENGRAVER     = GetTableOfIDs('Troll_Engraver'),
        TROLL_GEMOLOGIST   = GetTableOfIDs('Troll_Gemologist'),
        TROLL_IRONWORKER   = GetTableOfIDs('Troll_Ironworker'),
        TROLL_LAPIDARIST   = GetTableOfIDs('Troll_Lapidarist'),
        TROLL_SMELTER      = GetTableOfIDs('Troll_Smelter'),
        TROLL_STONEWORKER  = GetTableOfIDs('Troll_Stoneworker'),
        SULFUR_SCORPION    = GetTableOfIDs('Sulfur_Scorpion'),
        WAMOURACAMPA       = GetTableOfIDs('Wamouracampa'),
        WANDERING_WAMOURA  = GetTableOfIDs('Wandering_Wamoura'),
    },
    npc =
    {
        ARMOURY_CRATE        = GetTableOfIDs('Armoury_Crate'),
        DOOR_1_0             = GetFirstID('_230'),
        DOOR_1_CENTER_1      = GetFirstID('_239'),
        DOOR_1_CENTER_2      = GetFirstID('_23a'),
        DOOR_1_EAST_ENTRANCE = GetFirstID('_231'),
        DOOR_1_EAST_EXIT_1   = GetFirstID('_236'),
        DOOR_1_EAST_EXIT_2   = GetFirstID('_237'),
        DOOR_1_EAST_EXIT_3   = GetFirstID('_238'),
        DOOR_1_WEST_ENTRANCE = GetFirstID('_232'),
        DOOR_1_WEST_EXIT_1   = GetFirstID('_233'),
        DOOR_1_WEST_EXIT_2   = GetFirstID('_234'),
        DOOR_1_WEST_EXIT_3   = GetFirstID('_235'),
        DOOR_2_EAST_ENTRANCE = GetFirstID('_23c'),
        DOOR_2_NE_ENTRANCE   = GetFirstID('_23f'),
        DOOR_2_NE_EXIT       = GetFirstID('_23j'),
        DOOR_2_NW_ENTRANCE   = GetFirstID('_23d'),
        DOOR_2_NW_EXIT       = GetFirstID('_23h'),
        DOOR_2_SE_ENTRANCE   = GetFirstID('_23g'),
        DOOR_2_SE_EXIT       = GetFirstID('_23k'),
        DOOR_2_SW_ENTRANCE   = GetFirstID('_23e'),
        DOOR_2_SW_EXIT       = GetFirstID('_23i'),
        DOOR_2_WEST_ENTRANCE = GetFirstID('_23b'),
        DOOR_3_EAST_EXIT     = GetFirstID('_23p'),
        DOOR_3_NE_ENTRANCE   = GetFirstID('_23o'),
        DOOR_3_NORTH_CENTER  = GetFirstID('_23s'),
        DOOR_3_NW_ENTRANCE   = GetFirstID('_23n'),
        DOOR_3_SOUTH_CENTER  = GetFirstID('_23r'),
        DOOR_3_SE_ENTRANCE   = GetFirstID('_23q'),
        DOOR_3_SW_ENTRANCE   = GetFirstID('_23l'),
        DOOR_3_WEST_EXIT     = GetFirstID('_23m'),
        DOOR_4_EAST_EXIT     = GetFirstID('_23u'),
        DOOR_4_WEST_EXIT     = GetFirstID('_23t'),
        DOOR_5_1             = GetFirstID('_23v'),
        DOOR_5_2             = GetFirstID('_23x'),
        DORMANT_RAMPART      = GetTableOfIDs('Dormant_Rampart'),
        SLOT                 = GetFirstID('Slot'),
        SOCKET               = GetFirstID('Socket'),
    },
    pos =
    {
        [1] =
        {
            [1] =
            {
                enter = { -340, 0, -530, 192 },
                exit  = { 420, 16, -291,  64 },
            },
            [2] =
            {
                enter = { -340, 0, -530, 192 },
                exit  = { 451, 16, -460, 255 },
            },
            [3] =
            {
                enter = { -340, 0, -530, 192 },
                exit  = { 260, 16, -291,  64 },
            },
            [4] =
            {
                enter = { -340, 0, -530, 192 },
                exit  = { 229, 16, -460, 129 },
            },
        },
        [2] =
        {
            [1] =
            {
                enter = { -340, 0, -233, 64 },
                exit  = {  309, -4, 260,  0 },
            },
            [2] =
            {
                enter = { -340, 0, -233, 64 },
                exit  = { 340, -4, 229, 197 },
            },
            [3] =
            {
                enter = { -340, 0, -233, 64 },
                exit  = { 371, -4, 260, 126 },
            },
            [4] =
            {
                enter = { -340, 0, -233, 64 },
                exit  = { 340, -4,  291, 63 },
            },
        },
        [3] =
        {
            [1] =
            {
                enter = { 260, 0.5, 114 , 192 },
                exit  = { -300, -4, -420,   0 },
            },
            [2] =
            {
                enter = { 260, 0.5,  114, 192 },
                exit  = { -380, -4, -420, 128 },
            },
        },
        [4] =
        {
            [1] =
            {
                enter = { 420,  0, 114, 192 },
                exit  = { -300, 0, -75, 192 },
            },
            [2] =
            {
                enter = { 420, 0, 114, 192 },
                exit  = { -315, -4, 20,  0 },
            },
            [3] =
            {
                enter = {  420,  0, 114, 192 },
                exit  = { -220, -4, 125, 192 },
            },
            [4] =
            {
                enter = { 420,  0, 114, 192 },
                exit  = { -300, 0, 195,  64 },
            },
            [5] =
            {
                enter = {  420, 0, 114, 192 },
                exit  = { -380, 0, -75, 192 },
            },
            [6] =
            {
                enter = {  420, 0, 114, 192 },
                exit  = { -365, -4, 20, 128 },
            },
            [7] =
            {
                enter = {  420,  0, 114, 192 },
                exit  = { -460, -4, 125, 192 },
            },
            [8] =
            {
                enter = {  420, 0, 114, 192 },
                exit  = { -380, 0, 195,  64 },
            },
        },
    },
}

return zones[xi.zone.BHAFLAU_REMNANTS]
