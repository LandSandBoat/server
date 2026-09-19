-----------------------------------
--   Dynamis Zone Configuration  --
-----------------------------------
-- This file contains all zone-specific configuration data
-- organized from the original dynamis_system.lua

xi = xi or {}
xi.dynamis = xi.dynamis or {}

-----------------------------------
-- Entry Zone Configuration
-----------------------------------
--[[
    Configuration for non-dynamis zones where players register entry.
    Includes cutscene IDs, entry requirements, and positioning.
--]]

xi.dynamis.entryInfoEra =
{
    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        csBit           = 1,
        csRegisterGlass = 184,
        csVial          = 686,
        csWin           = 698,
        csDyna          = 685,
        maxCapacity     = 64,
        enabled         = true,
        dynaZone        = xi.zone.DYNAMIS_SAN_DORIA,
        winVar          = 'DynaSandoria_Win',
        enteredVar      = 'DynaSandoria_entered',
        hasSeenWinCSVar = 'DynaSandoria_HasSeenWinCS',
        winKI           = xi.keyItem.HYDRA_CORPS_COMMAND_SCEPTER,
        enterPos        = { 161.838, -2.000, 161.673, 93, 185 },
        reqs            = { xi.keyItem.VIAL_OF_SHROUDED_SAND },
    },
    [xi.zone.BASTOK_MINES] =
    {
        csBit           = 2,
        csRegisterGlass = 200,
        csVial          = 203,
        csWin           = 215,
        csDyna          = 201,
        maxCapacity     = 64,
        enabled         = true,
        dynaZone        = xi.zone.DYNAMIS_BASTOK,
        winVar          = 'DynaBastok_Win',
        enteredVar      = 'DynaBastok_entered',
        hasSeenWinCSVar = 'DynaBastok_HasSeenWinCS',
        winKI           = xi.keyItem.HYDRA_CORPS_EYEGLASS,
        enterPos        = { 116.482, 0.994, -72.121, 128, 186 },
        reqs            = { xi.keyItem.VIAL_OF_SHROUDED_SAND },
    },
    [xi.zone.WINDURST_WALLS] =
    {
        csBit           = 3,
        csRegisterGlass = 451,
        csVial          = 455,
        csWin           = 465,
        csDyna          = 452,
        maxCapacity     = 64,
        enabled         = true,
        dynaZone        = xi.zone.DYNAMIS_WINDURST,
        winVar          = 'DynaWindurst_Win',
        enteredVar      = 'DynaWindurst_entered',
        hasSeenWinCSVar = 'DynaWindurst_HasSeenWinCS',
        winKI           = xi.keyItem.HYDRA_CORPS_LANTERN,
        enterPos        = { -221.988, 1.000, -120.184, 0, 187 },
        reqs            = { xi.keyItem.VIAL_OF_SHROUDED_SAND },
    },
    [xi.zone.RULUDE_GARDENS] =
    {
        csBit           = 4,
        csRegisterGlass = 10011,
        csVial          = 10016,
        csWin           = 10026,
        csDyna          = 10012,
        maxCapacity     = 64,
        enabled         = true,
        dynaZone        = xi.zone.DYNAMIS_JEUNO,
        winVar          = 'DynaJeuno_Win',
        enteredVar      = 'DynaJeuno_entered',
        hasSeenWinCSVar = 'DynaJeuno_HasSeenWinCS',
        winKI           = xi.keyItem.HYDRA_CORPS_TACTICAL_MAP,
        enterPos        = { 48.930, 10.002, -71.032, 195, 188 },
        reqs            = { xi.keyItem.VIAL_OF_SHROUDED_SAND },
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        csBit           = 5,
        csRegisterGlass = 118,
        csWin           = 134,
        csDyna          = 119,
        maxCapacity     = 64,
        enabled         = true,
        dynaZone        = xi.zone.DYNAMIS_BEAUCEDINE,
        winVar          = 'DynaBeaucedine_Win',
        enteredVar      = 'DynaBeaucedine_entered',
        hasSeenWinCSVar = 'DynaBeaucedine_HasSeenWinCS',
        winKI           = xi.keyItem.HYDRA_CORPS_INSIGNIA,
        enterPos        = { -284.751, -39.923, -422.948, 235, 134 },
        reqs            =
        {
            xi.keyItem.VIAL_OF_SHROUDED_SAND,
            xi.keyItem.HYDRA_CORPS_COMMAND_SCEPTER,
            xi.keyItem.HYDRA_CORPS_EYEGLASS,
            xi.keyItem.HYDRA_CORPS_LANTERN,
            xi.keyItem.HYDRA_CORPS_TACTICAL_MAP,
        },
    },
    [xi.zone.XARCABARD] =
    {
        csBit           = 6,
        csRegisterGlass = 15,
        csWin           = 32,
        csDyna          = 16,
        maxCapacity     = 64,
        enabled         = true,
        dynaZone        = xi.zone.DYNAMIS_XARCABARD,
        winVar          = 'DynaXarcabard_Win',
        enteredVar      = 'DynaXarcabard_entered',
        hasSeenWinCSVar = 'DynaXarcabard_HasSeenWinCS',
        winKI           = xi.keyItem.HYDRA_CORPS_BATTLE_STANDARD,
        enterPos        = { 569.312, -0.098, -270.158, 90, 135 },
        reqs            =
        {
            xi.keyItem.VIAL_OF_SHROUDED_SAND,
            xi.keyItem.HYDRA_CORPS_INSIGNIA,
        },
    },
    [xi.zone.VALKURM_DUNES] =
    {
        csBit             = 7,
        csRegisterGlass   = 15,
        csFirst           = 33,
        csWin             = 39,
        csDyna            = 58,
        maxCapacity       = 36,
        enabled           = true,
        dynaZone          = xi.zone.DYNAMIS_VALKURM,
        hasSeenFirstCSVar = 'DynamisCop_First',
        winVar            = 'DynaValkurm_Win',
        enteredVar        = 'DynaValkurm_entered',
        hasSeenWinCSVar   = 'DynaValkurm_HasSeenWinCS',
        winKI             = xi.keyItem.DYNAMIS_VALKURM_SLIVER,
        enterPos          = { 100, -8, 131, 47, 39 },
        reqs              = { xi.keyItem.VIAL_OF_SHROUDED_SAND },
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        csBit             = 8,
        csRegisterGlass   = 21,
        csFirst           = 40,
        csWin             = 46,
        csDyna            = 22,
        maxCapacity       = 36,
        enabled           = true,
        dynaZone          = xi.zone.DYNAMIS_BUBURIMU,
        hasSeenFirstCSVar = 'DynamisCop_First',
        winVar            = 'DynaBuburimu_Win',
        enteredVar        = 'DynaBuburimu_entered',
        hasSeenWinCSVar   = 'DynaBuburimu_HasSeenWinCS',
        winKI             = xi.keyItem.DYNAMIS_BUBURIMU_SLIVER,
        enterPos          = { 155, -1, -169, 170, 40 },
        reqs              = { xi.keyItem.VIAL_OF_SHROUDED_SAND },
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        csBit             = 9,
        csRegisterGlass   = 2,
        csFirst           = 22,
        csWin             = 28,
        csDyna            = 3,
        maxCapacity       = 36,
        enabled           = true,
        dynaZone          = xi.zone.DYNAMIS_QUFIM,
        hasSeenFirstCSVar = 'DynamisCop_First',
        winVar            = 'DynaQufim_Win',
        enteredVar        = 'DynaQufim_entered',
        hasSeenWinCSVar   = 'DynaQufim_HasSeenWinCS',
        winKI             = xi.keyItem.DYNAMIS_QUFIM_SLIVER,
        enterPos          = { -19, -17, 104, 253, 41 },
        reqs              = { xi.keyItem.VIAL_OF_SHROUDED_SAND },
    },
    [xi.zone.TAVNAZIAN_SAFEHOLD] =
    {
        csBit             = 10,
        csRegisterGlass   = 587,
        csFirst           = 614,
        csWin             = 615,
        csDyna            = 588,
        maxCapacity       = 18,
        enabled           = true,
        dynaZone          = xi.zone.DYNAMIS_TAVNAZIA,
        hasSeenFirstCSVar = 'DynaTavnazia_First',
        winVar            = 'DynaTavnazia_Win',
        enteredVar        = 'DynaTavnazia_entered',
        hasSeenWinCSVar   = 'DynaTavnazia_HasSeenWinCS',
        winKI             = xi.keyItem.DYNAMIS_TAVNAZIA_SLIVER,
        enterPos          = { 0.1, -7, -21, 190, 42 },
        reqs              =
        {
            xi.keyItem.VIAL_OF_SHROUDED_SAND,
            xi.keyItem.DYNAMIS_VALKURM_SLIVER,
            xi.keyItem.DYNAMIS_QUFIM_SLIVER,
            xi.keyItem.DYNAMIS_BUBURIMU_SLIVER,
        },
    },
}

-----------------------------------
-- Dynamis Zone Configuration
-----------------------------------
--[[
    Configuration for dynamis zones themselves.
    Includes positioning, NPCs, special handling.
--]]

-- TODOs:
-- Fix all the winQM IDs after DATs are done
xi.dynamis.dynaInfoEra =
{
    [xi.zone.DYNAMIS_SAN_DORIA] =
    {
        winVar          = 'DynaSandoria_Win',
        enteredVar      = 'DynaSandoria_entered',
        hasSeenWinCSVar = 'DynaSandoria_HasSeenWinCS',
        winKI           = xi.keyItem.HYDRA_CORPS_COMMAND_SCEPTER,
        winTitle        = xi.title.DYNAMIS_SAN_DORIA_INTERLOPER,
        winQM           = 17535486,
        entryPos        = { 161.838, -2.000, 161.673, 93, xi.zone.DYNAMIS_SAN_DORIA },
        ejectPos        = { 161.000, -2.000, 161.000, 94, xi.zone.SOUTHERN_SAN_DORIA },
    },
    [xi.zone.DYNAMIS_BASTOK] =
    {
        winVar          = 'DynaBastok_Win',
        enteredVar      = 'DynaBastok_entered',
        hasSeenWinCSVar = 'DynaBastok_HasSeenWinCS',
        winKI           = xi.keyItem.HYDRA_CORPS_EYEGLASS,
        winTitle        = xi.title.DYNAMIS_BASTOK_INTERLOPER,
        winQM           = 17539610,
        entryPos        = { 116.482, 0.994, -72.121, 128, xi.zone.DYNAMIS_BASTOK },
        ejectPos        = { 112.000, 0.994, -72.000, 127, xi.zone.BASTOK_MINES },
    },
    [xi.zone.DYNAMIS_WINDURST] =
    {
        winVar          = 'DynaWindurst_Win',
        enteredVar      = 'DynaWindurst_entered',
        hasSeenWinCSVar = 'DynaWindurst_HasSeenWinCS',
        winKI           = xi.keyItem.HYDRA_CORPS_LANTERN,
        winTitle        = xi.title.DYNAMIS_WINDURST_INTERLOPER,
        winQM           = 17543676,
        entryPos        = { -221.988, 1.000, -120.184, 0, xi.zone.DYNAMIS_WINDURST },
        ejectPos        = { -217.000, 1.000, -119.000, 94, xi.zone.WINDURST_WALLS },
    },
    [xi.zone.DYNAMIS_JEUNO] =
    {
        winVar          = 'DynaJeuno_Win',
        enteredVar      = 'DynaJeuno_entered',
        hasSeenWinCSVar = 'DynaJeuno_HasSeenWinCS',
        winKI           = xi.keyItem.HYDRA_CORPS_TACTICAL_MAP,
        winTitle        = xi.title.DYNAMIS_JEUNO_INTERLOPER,
        winQM           = 17547777,
        entryPos        = { 48.930, 10.002, -71.032, 195, xi.zone.DYNAMIS_JEUNO },
        ejectPos        = { 48.930, 10.002, -71.032, 195, xi.zone.RULUDE_GARDENS },
    },
    [xi.zone.DYNAMIS_BEAUCEDINE] =
    {
        winVar            = 'DynaBeaucedine_Win',
        enteredVar        = 'DynaBeaucedine_entered',
        hasSeenWinCSVar   = 'DynaBeaucedine_HasSeenWinCS',
        winKI             = xi.keyItem.HYDRA_CORPS_INSIGNIA,
        winTitle          = xi.title.DYNAMIS_BEAUCEDINE_INTERLOPER,
        winQM             = 17326616,
        entryPos          = { -284.751, -39.923, -422.948, 235, xi.zone.DYNAMIS_BEAUCEDINE },
        ejectPos          = { -284.751, -39.923, -422.948, 235, xi.zone.BEAUCEDINE_GLACIER },
    },
    [xi.zone.DYNAMIS_XARCABARD] =
    {
        winVar            = 'DynaXarcabard_Win',
        enteredVar        = 'DynaXarcabard_entered',
        hasSeenWinCSVar   = 'DynaXarcabard_HasSeenWinCS',
        winKI             = xi.keyItem.HYDRA_CORPS_BATTLE_STANDARD,
        winTitle          = xi.title.DYNAMIS_XARCABARD_INTERLOPER,
        winQM             = 17330839,
        entryPos          = { 569.312, -0.098, -270.158, 90, xi.zone.DYNAMIS_XARCABARD },
        ejectPos          = { 569.312, -0.098, -270.158, 90, xi.zone.XARCABARD },
    },
    [xi.zone.DYNAMIS_VALKURM] =
    {
        winVar            = 'DynaValkurm_Win',
        enteredVar        = 'DynaValkurm_entered',
        hasSeenWinCSVar   = 'DynaValkurm_HasSeenWinCS',
        winKI             = xi.keyItem.DYNAMIS_VALKURM_SLIVER,
        winTitle          = xi.title.DYNAMIS_VALKURM_INTERLOPER,
        winQM             = 16937394,
        entryPos          = { 100, -8, 131, 47, xi.zone.DYNAMIS_VALKURM },
        ejectPos          = { 119, -9, 131, 52, xi.zone.VALKURM_DUNES },
    },
    [xi.zone.DYNAMIS_BUBURIMU] =
    {
        winVar                 = 'DynaBuburimu_Win',
        enteredVar             = 'DynaBuburimu_entered',
        hasSeenWinCSVar        = 'DynaBuburimu_HasSeenWinCS',
        winKI                  = xi.keyItem.DYNAMIS_BUBURIMU_SLIVER,
        winTitle               = xi.title.DYNAMIS_BUBURIMU_INTERLOPER,
        winQM                  = 16941489,
        entryPos               = { 155, -1, -169, 170, xi.zone.DYNAMIS_BUBURIMU },
        ejectPos               = { 154, -1, -170, 190, xi.zone.BUBURIMU_PENINSULA },
        sjRestrictionNPC       = 16941496,
        sjRestrictionLocation  =
        {
            [1] = { -214.161, 15.360, -269.202, 54  },
            [2] = {  620.425,  7.306, -266.427, 71  },
            [3] = {  427.460, -0.308,  189.224, 50  },
            [4] = {  320.489, -0.642,  366.648, 101 },
        }
    },
    [xi.zone.DYNAMIS_QUFIM] =
    {
        winVar                 = 'DynaQufim_Win',
        enteredVar             = 'DynaQufim_entered',
        hasSeenWinCSVar        = 'DynaQufim_HasSeenWinCS',
        winKI                  = xi.keyItem.DYNAMIS_QUFIM_SLIVER,
        winTitle               = xi.title.DYNAMIS_QUFIM_INTERLOPER,
        winQM                  = 16945563,
        entryPos               = { -19, -17, 104, 253, xi.zone.DYNAMIS_QUFIM },
        ejectPos               = { 18, -19, 162, 240, xi.zone.QUFIM_ISLAND },
        sjRestrictionNPC       = 16945564,
        sjRestrictionLocation  =
        {
            [1]  = { -264.498, -19.255, 401.465, 54  },
            [2]  = { -264.655, -19.268, 240.580, 71  },
            [3]  = {  -77.771, -19.068, 258.666, 50  },
            [4]  = { -137.127, -19.976, 228.789, 101 },
            [5]  = {  -61.647, -19.868, 152.935, 35  },
            [6]  = {   27.973, -20.270, 191.907, 195 },
            [7]  = {  107.445, -20.368, 149.587, 64  },
            [8]  = {   99.884, -19.557,  51.518, 27  },
            [9]  = {  -29.895, -21.095, -57.154, 209 },
            [10] = {   88.474, -20.621, -49.333, 4   },
            [11] = { -192.540, -20.477, -11.055, 151 },
            [12] = { -340.976, -20.421,  31.154, 66  },
        }
    },
    [xi.zone.DYNAMIS_TAVNAZIA] =
    {
        winVar            = 'DynaTavnazia_Win',
        enteredVar        = 'DynaTavnazia_entered',
        hasSeenWinCSVar   = 'DynaTavnazia_HasSeenWinCS',
        winKI             = xi.keyItem.DYNAMIS_TAVNAZIA_SLIVER,
        qmTitle           = xi.title.DYNAMIS_TAVNAZIA_INTERLOPER,
        winTitle          = xi.title.NIGHTMARE_AWAKENER,
        csTitle           = xi.title.CONFRONTER_OF_NIGHTMARES,
        winQM             = 16949653,
        entryPos          = { 0.1, -7, -21, 190, xi.zone.DYNAMIS_TAVNAZIA },
        ejectPos          = { 0, -7, -23, 195, xi.zone.TAVNAZIAN_SAFEHOLD },
        timeExtensions    = { 16949654, 16949655 },
    },
}

-----------------------------------
-- Zone Message ID Lookup
-----------------------------------
--[[
    Maps zone IDs to message constants for dynamis entry/status.
    Allows centralized messages instead of per-zone hardcoding.
--]]

xi.dynamis.dynaIDLookup =
{
    [xi.zone.BASTOK_MINES] =
    {
        text =
        {
            UNABLE_TO_CONNECT           = zones[xi.zone.BASTOK_MINES].text.YOU_CANNOT_ENTER_DYNAMIS - 7,
            ANOTHER_GROUP               = zones[xi.zone.BASTOK_MINES].text.YOU_CANNOT_ENTER_DYNAMIS - 5,
            INFORMATION_RECORDED        = zones[xi.zone.BASTOK_MINES].text.YOU_CANNOT_ENTER_DYNAMIS - 4,
        },
        entryZone = xi.zone.BASTOK_MINES,
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        text =
        {
            UNABLE_TO_CONNECT           = zones[xi.zone.BEAUCEDINE_GLACIER].text.YOU_CANNOT_ENTER_DYNAMIS - 7,
            ANOTHER_GROUP               = zones[xi.zone.BEAUCEDINE_GLACIER].text.YOU_CANNOT_ENTER_DYNAMIS - 5,
            INFORMATION_RECORDED        = zones[xi.zone.BEAUCEDINE_GLACIER].text.YOU_CANNOT_ENTER_DYNAMIS - 4,
        },
        entryZone = xi.zone.BEAUCEDINE_GLACIER,
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        text =
        {
            UNABLE_TO_CONNECT           = zones[xi.zone.BUBURIMU_PENINSULA].text.YOU_CANNOT_ENTER_DYNAMIS - 7,
            ANOTHER_GROUP               = zones[xi.zone.BUBURIMU_PENINSULA].text.YOU_CANNOT_ENTER_DYNAMIS - 5,
            INFORMATION_RECORDED        = zones[xi.zone.BUBURIMU_PENINSULA].text.YOU_CANNOT_ENTER_DYNAMIS - 4,
        },
        entryZone = xi.zone.BUBURIMU_PENINSULA,
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        text =
        {
            UNABLE_TO_CONNECT           = zones[xi.zone.QUFIM_ISLAND].text.YOU_CANNOT_ENTER_DYNAMIS - 7,
            ANOTHER_GROUP               = zones[xi.zone.QUFIM_ISLAND].text.YOU_CANNOT_ENTER_DYNAMIS - 5,
            INFORMATION_RECORDED        = zones[xi.zone.QUFIM_ISLAND].text.YOU_CANNOT_ENTER_DYNAMIS - 4,
        },
        entryZone = xi.zone.QUFIM_ISLAND,
    },
    [xi.zone.RULUDE_GARDENS] =
    {
        text =
        {
            UNABLE_TO_CONNECT           = zones[xi.zone.RULUDE_GARDENS].text.YOU_CANNOT_ENTER_DYNAMIS - 7,
            ANOTHER_GROUP               = zones[xi.zone.RULUDE_GARDENS].text.YOU_CANNOT_ENTER_DYNAMIS - 5,
            INFORMATION_RECORDED        = zones[xi.zone.RULUDE_GARDENS].text.YOU_CANNOT_ENTER_DYNAMIS - 4,
        },
        entryZone = xi.zone.RULUDE_GARDENS,
    },
    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        text =
        {
            UNABLE_TO_CONNECT           = zones[xi.zone.SOUTHERN_SAN_DORIA].text.YOU_CANNOT_ENTER_DYNAMIS - 7,
            ANOTHER_GROUP               = zones[xi.zone.SOUTHERN_SAN_DORIA].text.YOU_CANNOT_ENTER_DYNAMIS - 5,
            INFORMATION_RECORDED        = zones[xi.zone.SOUTHERN_SAN_DORIA].text.YOU_CANNOT_ENTER_DYNAMIS - 4,
        },
        entryZone = xi.zone.SOUTHERN_SAN_DORIA,
    },
    [xi.zone.TAVNAZIAN_SAFEHOLD] =
    {
        text =
        {
            UNABLE_TO_CONNECT           = zones[xi.zone.TAVNAZIAN_SAFEHOLD].text.YOU_CANNOT_ENTER_DYNAMIS - 7,
            ANOTHER_GROUP               = zones[xi.zone.TAVNAZIAN_SAFEHOLD].text.YOU_CANNOT_ENTER_DYNAMIS - 5,
            INFORMATION_RECORDED        = zones[xi.zone.TAVNAZIAN_SAFEHOLD].text.YOU_CANNOT_ENTER_DYNAMIS - 4,
        },
        entryZone = xi.zone.TAVNAZIAN_SAFEHOLD,
    },
    [xi.zone.VALKURM_DUNES] =
    {
        text =
        {
            UNABLE_TO_CONNECT           = zones[xi.zone.VALKURM_DUNES].text.YOU_CANNOT_ENTER_DYNAMIS - 7,
            ANOTHER_GROUP               = zones[xi.zone.VALKURM_DUNES].text.YOU_CANNOT_ENTER_DYNAMIS - 5,
            INFORMATION_RECORDED        = zones[xi.zone.VALKURM_DUNES].text.YOU_CANNOT_ENTER_DYNAMIS - 4,
        },
        entryZone = xi.zone.VALKURM_DUNES,
    },
    [xi.zone.WINDURST_WALLS] =
    {
        text =
        {
            UNABLE_TO_CONNECT           = zones[xi.zone.WINDURST_WALLS].text.YOU_CANNOT_ENTER_DYNAMIS - 7,
            ANOTHER_GROUP               = zones[xi.zone.WINDURST_WALLS].text.YOU_CANNOT_ENTER_DYNAMIS - 5,
            INFORMATION_RECORDED        = zones[xi.zone.WINDURST_WALLS].text.YOU_CANNOT_ENTER_DYNAMIS - 4,
        },
        entryZone = xi.zone.WINDURST_WALLS,
    },
    [xi.zone.XARCABARD] =
    {
        text =
        {
            UNABLE_TO_CONNECT           = zones[xi.zone.XARCABARD].text.YOU_CANNOT_ENTER_DYNAMIS - 7,
            ANOTHER_GROUP               = zones[xi.zone.XARCABARD].text.YOU_CANNOT_ENTER_DYNAMIS - 5,
            INFORMATION_RECORDED        = zones[xi.zone.XARCABARD].text.YOU_CANNOT_ENTER_DYNAMIS - 4,
        },
        entryZone = xi.zone.XARCABARD,
    },
    -- Dynamis Zones
    [xi.zone.DYNAMIS_BASTOK] =
    {
        text = { NO_LONGER_HAVE_CLEARANCE = zones[xi.zone.DYNAMIS_BASTOK].text.MEMBERS_LEVELS_ARE_RESTRICTED + 49 },
        entryZone = xi.zone.BASTOK_MINES,
    },
    [xi.zone.DYNAMIS_SAN_DORIA] =
    {
        text = { NO_LONGER_HAVE_CLEARANCE = zones[xi.zone.DYNAMIS_SAN_DORIA].text.MEMBERS_LEVELS_ARE_RESTRICTED + 49 },
        entryZone = xi.zone.SOUTHERN_SAN_DORIA,
    },
    [xi.zone.DYNAMIS_WINDURST] =
    {
        text = { NO_LONGER_HAVE_CLEARANCE = zones[xi.zone.DYNAMIS_WINDURST].text.MEMBERS_LEVELS_ARE_RESTRICTED + 49 },
        entryZone = xi.zone.WINDURST_WALLS,
    },
    [xi.zone.DYNAMIS_JEUNO] =
    {
        text = { NO_LONGER_HAVE_CLEARANCE = zones[xi.zone.DYNAMIS_JEUNO].text.MEMBERS_LEVELS_ARE_RESTRICTED + 49 },
        entryZone = xi.zone.RULUDE_GARDENS,
    },
    [xi.zone.DYNAMIS_BEAUCEDINE] =
    {
        text = { NO_LONGER_HAVE_CLEARANCE = zones[xi.zone.DYNAMIS_BEAUCEDINE].text.MEMBERS_LEVELS_ARE_RESTRICTED + 49 },
        entryZone = xi.zone.BEAUCEDINE_GLACIER,
    },
    [xi.zone.DYNAMIS_XARCABARD] =
    {
        text = { NO_LONGER_HAVE_CLEARANCE = zones[xi.zone.DYNAMIS_XARCABARD].text.MEMBERS_LEVELS_ARE_RESTRICTED + 49 },
        entryZone = xi.zone.XARCABARD,
    },
    [xi.zone.DYNAMIS_VALKURM] =
    {
        text = { NO_LONGER_HAVE_CLEARANCE = zones[xi.zone.DYNAMIS_VALKURM].text.MEMBERS_LEVELS_ARE_RESTRICTED + 309 },
        entryZone = xi.zone.VALKURM_DUNES,
    },
    [xi.zone.DYNAMIS_BUBURIMU] =
    {
        text = { NO_LONGER_HAVE_CLEARANCE = zones[xi.zone.DYNAMIS_BUBURIMU].text.MEMBERS_LEVELS_ARE_RESTRICTED + 309 },
        entryZone = xi.zone.BUBURIMU_PENINSULA,
    },
    [xi.zone.DYNAMIS_QUFIM] =
    {
        text = { NO_LONGER_HAVE_CLEARANCE = zones[xi.zone.DYNAMIS_QUFIM].text.MEMBERS_LEVELS_ARE_RESTRICTED + 309 },
        entryZone = xi.zone.QUFIM_ISLAND,
    },
    [xi.zone.DYNAMIS_TAVNAZIA] =
    {
        text = { NO_LONGER_HAVE_CLEARANCE = zones[xi.zone.DYNAMIS_TAVNAZIA].text.MEMBERS_LEVELS_ARE_RESTRICTED + 309 },
        entryZone = xi.zone.TAVNAZIAN_SAFEHOLD,
    },
}
