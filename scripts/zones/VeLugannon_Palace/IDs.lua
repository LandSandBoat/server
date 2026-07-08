-----------------------------------
-- Area: VeLugannon_Palace
-----------------------------------
zones = zones or {}

zones[xi.zone.VELUGANNON_PALACE] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_CANNOT_BE_OBTAINED_TRADE = 6390,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072,  -- Tallying conquest results...
        CHEST_UNLOCKED                = 7239,  -- You unlock the chest!
        EVIL_PRESENCE                 = 7249,  -- You sense an evil presence lurking in the shadows...
        KNIFE_CHANGES_SHAPE           = 7256,  -- The <item> begins to change shape.
        NOTHING_HAPPENS               = 7257,  -- Nothing happens.
        REGIME_REGISTERED             = 10182, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11234, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11235, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11236, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11237, -- You already possess that temporary item.
        NO_COMBINATION                = 11242, -- You were unable to enter a combination.
    },
    mob =
    {
        BRIGANDISH_BLADE = GetFirstID('Brigandish_Blade'),
        DETECTOR         = GetTableOfIDs('Detector'),
        MIMIC            = GetFirstID('Mimic'),
        STEAM_CLEANER    = GetFirstID('Steam_Cleaner'),
        ZIPACNA          = GetFirstID('Zipacna'),
    },
    npc =
    {
        QM1             = GetFirstID('qm1'),
        QM3             = GetFirstID('qm3'),
        Y_DOOR_OFFSET   = GetFirstID('_4x0'),
        B_DOOR_OFFSET   = GetFirstID('_4x8'),
        Y_LITH_OFFSET   = GetTableOfIDs('Monolith')[1],
        B_LITH_OFFSET   = GetTableOfIDs('Monolith')[6],
        TREASURE_COFFER = GetFirstID('Treasure_Coffer'),
    },
    positions =
    {
        curtana =
        {
            [1] =  { -434.320, 16.016, -230.060 },
            [2] =  {     -434,     16,     -210 }, -- Need better cap
            [3] =  { -389.990, 16.016, -274.531 },
            [4] =  { -370.050, 16.014, -194.259 },
            [5] =  { -370.039, 16.014, -274.378 },
            [6] =  { -389.050, 16.014, -274.259 }, -- Guessed based off of the southern duplicate. Needs cap.
            [7] =  { -325.667, 16.013, -209.940 },
            [8] =  { -325.611, 16.013, -229.970 },
            [9] =  {  325.670, 16.016, -209.973 },
            [10] = {  325.368, 16.013, -230.056 }, -- Guessed based off of western duplicate. Needs cap.
            [11] = {  370.070, 16.010, -274.472 },
            [12] = {  370.070, 15.998, -194.742 },
            [13] = {  390.016, 16.014, -274.371 },
            [14] = {      390,     16,     -194 }, -- need better cap
            [15] = {  434.269, 16.018, -209.917 },
            [16] = {  434.368, 16.013, -230.056 },
        }
    },
}

return zones[xi.zone.VELUGANNON_PALACE]
