--------------------------------------------
--         Dynamis 75 Era Module          --
--------------------------------------------
--------------------------------------------
--       Module Required Scripts          --
--------------------------------------------
require("scripts/mixins/job_special")
require("scripts/globals/battlefield")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/titles")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/pathfind")
require("modules/module_utils")
--------------------------------------------
--       Module Extended Scripts          --
--------------------------------------------
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_bastok_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_beaucedine_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_buburimu_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_jeuno_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_qufim_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_san_d_oria_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_valkurm_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_windurst_mobs")
require("modules/era/lua_dynamis/mob_spawning_files/dynamis_xarcabard_mobs")
--------------------------------------------
--       Module Affected Scripts          --
--------------------------------------------
require("scripts/globals/dynamis")
--------------------------------------------

local m = Module:new("era_dynamis")

xi = xi or {}
xi.dynamis = xi.dynamis or {}

--------------------------------------------
--        Global Dynamis Variables        --
--------------------------------------------
local dynamis_snapshot_interval = 30 -- Interval to save a snapshot of the instance
local dynamis_last_snapshot = 0 -- Last snapshot time
local dynamis_timeless = 4236
local dynamis_perpetual = 4237
local dynamis_min_lvl = 65
local dynamis_reservation_cancel = 180
local dynamis_reentry_days = 3
local dynamis_rentry_hours = 71
local dynamis_staging_time = 15 -- Extra time added at registration of dynamis in minutes.

local gmFlags =
{
    GM          = 0x04000000,
    GM_SENIOR   = 0x05000000,
    GM_LEAD     = 0x06000000,
    GM_PRODUCER = 0x07000000,
    SENIOR      = 0x01000000, -- Do NOT set these flags. These are here to
    LEAD        = 0x02000000, -- ensure all GM status is removed.
}

local function checkGM(player)
    for _, flag in pairs(gmFlags) do
        if player:checkNameFlags(flag) then
            return true
        end
    end
end

xi.dynamis.dynaIDLookup = -- Used to check for different IDs based on zoneID. Replaces the need to overwrite IDs.lua for each zone.
{
    --------------------------------------------
    --             Starting Zones             --
    --------------------------------------------
    -- [zone] = -- zoneID for array lookup
    -- {
    --     text = -- text for table lookup
    --     {
    --         INFORMATION_RECORDED = , -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
    --         ANOTHER_GROUP = , -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
    --         UNABLE_TO_CONNECT = , -- Unable to connect.≺Prompt≻
    --         CONNECTING_WITH_THE_SERVER = , -- Connecting with server. Please wait.≺Possible Special Code: 00≻
    --     },
    -- },

    [xi.zone.BASTOK_MINES] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            INFORMATION_RECORDED = 11731, -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
            ANOTHER_GROUP = 11736, -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
            UNABLE_TO_CONNECT = 11734, -- Unable to connect.≺Prompt≻
            CONNECTING_WITH_THE_SERVER = 11733, -- Connecting with server. Please wait.≺Possible Special Code: 00≻
        },
    },

    [xi.zone.BEAUCEDINE_GLACIER] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            INFORMATION_RECORDED = 7881, -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
            ANOTHER_GROUP = 7880, -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
            UNABLE_TO_CONNECT = 7878, -- Unable to connect.≺Prompt≻
            CONNECTING_WITH_THE_SERVER = 7877, -- Connecting with server. Please wait.≺Possible Special Code: 00≻
        },
    },

    [xi.zone.BUBURIMU_PENINSULA] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            INFORMATION_RECORDED = 7906, -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
            ANOTHER_GROUP = 7905, -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
            UNABLE_TO_CONNECT = 7903, -- Unable to connect.≺Prompt≻
            CONNECTING_WITH_THE_SERVER = 7902, -- Connecting with server. Please wait.≺Possible Special Code: 00≻
        },
    },

    [xi.zone.QUFIM_ISLAND] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            INFORMATION_RECORDED = 7864, -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
            ANOTHER_GROUP = 7863, -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
            UNABLE_TO_CONNECT = 7861, -- Unable to connect.≺Prompt≻
            CONNECTING_WITH_THE_SERVER = 7860, -- Connecting with server. Please wait.≺Possible Special Code: 00≻
        },
    },

    [xi.zone.RULUDE_GARDENS] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            INFORMATION_RECORDED = 11235, -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
            ANOTHER_GROUP = 11234, -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
            UNABLE_TO_CONNECT = 11232, -- Unable to connect.≺Prompt≻
            CONNECTING_WITH_THE_SERVER = 11231, -- Connecting with server. Please wait.≺Possible Special Code: 00≻
        },
    },

    [xi.zone.SOUTHERN_SAN_DORIA] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            INFORMATION_RECORDED = 7426, -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
            ANOTHER_GROUP = 7425, -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
            UNABLE_TO_CONNECT = 7423, -- Unable to connect.≺Prompt≻
            CONNECTING_WITH_THE_SERVER = 7422, -- Connecting with server. Please wait.≺Possible Special Code: 00≻
        },
    },
    [xi.zone.TAVNAZIAN_SAFEHOLD] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            INFORMATION_RECORDED = 11835, -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
            ANOTHER_GROUP = 11834, -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
            UNABLE_TO_CONNECT = 11832, -- Unable to connect.≺Prompt≻
            CONNECTING_WITH_THE_SERVER = 11831, -- Connecting with server. Please wait.≺Possible Special Code: 00≻
        },
    },
    [xi.zone.VALKURM_DUNES] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            INFORMATION_RECORDED = 7880, -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
            ANOTHER_GROUP = 7879, -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
            UNABLE_TO_CONNECT = 7877, -- Unable to connect.≺Prompt≻
            CONNECTING_WITH_THE_SERVER = 7876, -- Connecting with server. Please wait.≺Possible Special Code: 00≻
        },
    },
    [xi.zone.WINDURST_WALLS] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            INFORMATION_RECORDED = 9095, -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
            ANOTHER_GROUP = 9094, -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
            UNABLE_TO_CONNECT = 9092, -- Unable to connect.≺Prompt≻
            CONNECTING_WITH_THE_SERVER = 9091, -- Connecting with server. Please wait.≺Possible Special Code: 00≻
        },
    },
    [xi.zone.XARCABARD] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            INFORMATION_RECORDED = 7861, -- The time and destination for your foray into Dynamis has been recorded on your <itemID>.
            ANOTHER_GROUP = 7860, -- Another group of player characters is currently occupying Dynamis - ≺Multiple Choice (Parameter 0)≻[Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia].≺Prompt≻
            UNABLE_TO_CONNECT = 7858, -- Unable to connect.≺Prompt≻
            CONNECTING_WITH_THE_SERVER = 7857, -- Connecting with server. Please wait.≺Possible Special Code: 00≻
        },
    },
    --------------------------------------------
    --              Dynamis Zones             --
    --------------------------------------------
    -- [zone] = -- zoneID for array lookup
    -- {
    --     text = -- text for table lookup
    --     {
    --         NO_LONGER_HAVE_CLEARANCE = 7061,
    --     },
    -- },

    [xi.zone.DYNAMIS_BASTOK] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            NO_LONGER_HAVE_CLEARANCE = 7061,
        },
    },

    [xi.zone.DYNAMIS_BEAUCEDINE] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            NO_LONGER_HAVE_CLEARANCE = 7161,
        },
    },
    [xi.zone.DYNAMIS_BUBURIMU] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            NO_LONGER_HAVE_CLEARANCE = 7320,
        },
    },
    [xi.zone.DYNAMIS_JEUNO] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            NO_LONGER_HAVE_CLEARANCE = 7061,
        },
    },
    [xi.zone.DYNAMIS_QUFIM] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            NO_LONGER_HAVE_CLEARANCE = 7320,
        },
    },
    [xi.zone.DYNAMIS_SAN_DORIA] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            NO_LONGER_HAVE_CLEARANCE = 7061,
        },
    },
    [xi.zone.DYNAMIS_TAVNAZIA] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            NO_LONGER_HAVE_CLEARANCE = 7320,
        },
    },
    [xi.zone.DYNAMIS_VALKURM] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            NO_LONGER_HAVE_CLEARANCE = 7320,
        },
    },
    [xi.zone.DYNAMIS_WINDURST] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            NO_LONGER_HAVE_CLEARANCE = 7061,
        },
        vars = -- Global Var Table Cleanup
        {
            xi.dynamis.YING,
            xi.dynamis.YANG,
        }
    },
    [xi.zone.DYNAMIS_XARCABARD] = -- zoneID for array lookup
    {
        text = -- text for table lookup
        {
            NO_LONGER_HAVE_CLEARANCE = 7161,
        },
    },
}

--[[
    [zone] =
    {
        csBit    = the bit in the Dynamis_Status player variable that records whether player has beaten this dynamis
                this bit number is also given to the start Dynamis event and message.
        csSand   = event ID for cutscene where Cornelia gives you the vial of shrouded sand
        csWin    = event ID for cutscene after you have beaten this Dynamis
        csDyna   = event ID for entering Dynamis
        winVar   = variable used to denote players who have beaten this Dynamis, but not yet viewed the cutscene
        winKI    = key item given as reward for this Dynamis
        enterPos = coordinates where player will be placed when entering this Dynamis
        reqs     = function that returns true if player meets requirements for entering this Dynamis
                minimum level and timer are checked separately
    }
--]]

xi.dynamis.entryInfoEra =
{
    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        csBit = 1,
        csRegisterGlass = 184,
        csSand = 686,
        csWin = 698,
        csDyna = 685,
        maxCapacity = 64,
        enabled = true,
        winVar = "DynaSandoria_Win",
        enteredVar = "DynaSandoria_entered",
        hasSeenWinCSVar = "DynaSandoria_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_COMMAND_SCEPTER,
        enterPos = {161.838, -2.000, 161.673, 93, 185},
        reqs =
        {
            xi.ki.VIAL_OF_SHROUDED_SAND,
        },
    },
    [xi.zone.BASTOK_MINES] =
    {
        csBit = 2,
        csRegisterGlass = 200,
        csSand = 203,
        csWin = 215,
        csDyna = 201,
        maxCapacity = 64,
        enabled = true,
        winVar = "DynaBastok_Win",
        enteredVar = "DynaBastok_entered",
        hasSeenWinCSVar = "DynaBastok_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_EYEGLASS,
        enterPos = {116.482, 0.994, -72.121, 128, 186},
        reqs =
        {
            xi.ki.VIAL_OF_SHROUDED_SAND,
        },
    },
    [xi.zone.WINDURST_WALLS] =
    {
        csBit = 3,
        csRegisterGlass = 451,
        csSand = 455,
        csWin = 465,
        csDyna = 452,
        maxCapacity = 64,
        enabled = true,
        winVar = "DynaWindurst_Win",
        enteredVar = "DynaWindurst_entered",
        hasSeenWinCSVar = "DynaWindurst_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_LANTERN,
        enterPos = {-221.988, 1.000, -120.184, 0, 187},
        reqs =
        {
            xi.ki.VIAL_OF_SHROUDED_SAND,
        },
    },
    [xi.zone.RULUDE_GARDENS] =
    {
        csBit = 4,
        csRegisterGlass = 10011,
        csSand = 10016,
        csWin = 10026,
        csDyna = 10012,
        maxCapacity = 64,
        enabled = true,
        winVar = "DynaJeuno_Win",
        enteredVar = "DynaJeuno_entered",
        hasSeenWinCSVar = "DynaJeuno_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_TACTICAL_MAP,
        enterPos = {48.930, 10.002, -71.032, 195, 188},
        reqs =
        {
            xi.ki.VIAL_OF_SHROUDED_SAND,
        },
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        csBit = 5,
        csRegisterGlass = 118,
        csWin = 134,
        csDyna = 119,
        maxCapacity = 64,
        enabled = true,
        winVar = "DynaBeaucedine_Win",
        enteredVar = "DynaBeaucedine_entered",
        hasSeenWinCSVar = "DynaBeaucedine_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_INSIGNIA,
        enterPos = {-284.751, -39.923, -422.948, 235, 134},
        reqs =
        {
            xi.ki.VIAL_OF_SHROUDED_SAND,
            xi.ki.HYDRA_CORPS_COMMAND_SCEPTER,
            xi.ki.HYDRA_CORPS_EYEGLASS,
            xi.ki.HYDRA_CORPS_LANTERN,
            xi.ki.HYDRA_CORPS_TACTICAL_MAP,
        },
    },
    [xi.zone.XARCABARD] =
    {
        csBit = 6,
        csRegisterGlass = 15,
        csWin = 32,
        csDyna = 16,
        maxCapacity = 64,
        enabled = true,
        winVar = "DynaXarcabard_Win",
        enteredVar = "DynaXarcabard_entered",
        hasSeenWinCSVar = "DynaXarcabard_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_BATTLE_STANDARD,
        enterPos = {569.312, -0.098, -270.158, 90, 135},
        reqs =
        {
            xi.ki.VIAL_OF_SHROUDED_SAND,
            xi.ki.HYDRA_CORPS_INSIGNIA,
        },
    },
    [xi.zone.VALKURM_DUNES] =
    {
        csBit = 7,
        csRegisterGlass = 15,
        csFirst = 33,
        csWin = 39,
        csDyna = 58,
        maxCapacity = 36,
        enabled = true,
        winVar = "DynaValkurm_Win",
        enteredVar = "DynaValkurm_entered",
        hasSeenWinCSVar = "DynaValkurm_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_VALKURM_SLIVER,
        enterPos = {100, -8, 131, 47, 39},
        reqs =
        {
            xi.ki.VIAL_OF_SHROUDED_SAND,
        },
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        csBit = 8,
        csRegisterGlass = 21,
        csFirst = 40,
        csWin = 46,
        csDyna = 22,
        maxCapacity = 36,
        enabled = true,
        winVar = "DynaBuburimu_Win",
        enteredVar = "DynaBuburimu_entered",
        hasSeenWinCSVar = "DynaBuburimu_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_BUBURIMU_SLIVER,
        enterPos = {155, -1, -169, 170, 40},
        reqs =
        {
            xi.ki.VIAL_OF_SHROUDED_SAND,
        },
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        csBit = 9,
        csRegisterGlass = 2,
        csFirst = 22,
        csWin = 28,
        csDyna = 3,
        maxCapacity = 36,
        enabled = true,
        winVar = "DynaQufim_Win",
        enteredVar = "DynaQufim_entered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_QUFIM_SLIVER,
        enterPos = {-19, -17, 104, 253, 41},
        reqs =
        {
            xi.ki.VIAL_OF_SHROUDED_SAND,
        },
    },
    [xi.zone.TAVNAZIAN_SAFEHOLD] =
    {
        csBit = 10,
        csRegisterGlass = 587,
        csFirst = 614,
        csWin = 615,
        csDyna = 588,
        maxCapacity = 18,
        enabled = true,
        winVar = "DynaTavnazia_Win",
        enteredVar = "DynaTavnazia_entered",
        hasSeenWinCSVar = "DynaTavnazia_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_TAVNAZIA_SLIVER,
        enterPos = {0.1, -7, -21, 190, 42},
        reqs =
        {
            xi.ki.VIAL_OF_SHROUDED_SAND,
            xi.ki.DYNAMIS_VALKURM_SLIVER,
            xi.ki.DYNAMIS_QUFIM_SLIVER,
            xi.ki.DYNAMIS_BUBURIMU_SLIVER,
        },
    },
}

--[[
    [zone] =
    {
        winVar = Variable for the Win Condition
        enteredVar = Variable for Previous Entry
        hasSeenWinCSVar = Variable for Win CS
        winKI = Key item for win
        winTitle = Title for win
        entryPos = Coordinates in destination zone (Dynamis Zone)
        ejectPos = Coordinates in originating zone (Non-Dynamis Zone)
        specifiedChildren = Boolean for using specific children spawns.
        updatedRoam = Boolean for using LimitBreak statue roaming paths.
    }
--]]

xi.dynamis.dynaInfoEra =
{
    [xi.zone.DYNAMIS_SAN_DORIA] =
    {
        winVar = "DynaSandoria_Win",
        enteredVar = "DynaSandoria_entered",
        hasSeenWinCSVar = "DynaSandoria_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_COMMAND_SCEPTER,
        winTitle = xi.title.DYNAMIS_SAN_DORIA_INTERLOPER,
        winQM = 17535223,
        entryPos = {161.838, -2.000, 161.673, 93, xi.zone.DYNAMIS_SAN_DORIA},
        ejectPos = {161.000, -2.000, 161.000, 94, xi.zone.SOUTHERN_SAN_DORIA},
        specifiedChildren = true,
        updatedRoam = true,
    },
    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        dynaZone = xi.zone.DYNAMIS_SAN_DORIA,
        dynaZoneMessageParam = 1,
    },
    [xi.zone.DYNAMIS_BASTOK] =
    {
        winVar = "DynaBastok_Win",
        enteredVar = "DynaBastok_entered",
        hasSeenWinCSVar = "DynaBastok_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_EYEGLASS,
        winTitle = xi.title.DYNAMIS_BASTOK_INTERLOPER,
        winQM = 17539322,
        entryPos = {116.482, 0.994, -72.121, 128, xi.zone.DYNAMIS_BASTOK},
        ejectPos = {112.000, 0.994, -72.000, 127, xi.zone.BASTOK_MINES},
    },
    [xi.zone.BASTOK_MINES] =
    {
        dynaZone = xi.zone.DYNAMIS_BASTOK,
        dynaZoneMessageParam = 2,
    },
    [xi.zone.DYNAMIS_WINDURST] =
    {
        winVar = "DynaWindurst_Win",
        enteredVar = "DynaWindurst_entered",
        hasSeenWinCSVar = "DynaWindurst_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_LANTERN,
        winTitle = xi.title.DYNAMIS_WINDURST_INTERLOPER,
        winQM = 17543479,
        entryPos = {-221.988, 1.000, -120.184, 0 , xi.zone.DYNAMIS_WINDURST},
        ejectPos = {-217.000, 1.000, -119.000, 94, xi.zone.WINDURST_WALLS},
    },
    [xi.zone.WINDURST_WALLS] =
    {
        dynaZone = xi.zone.DYNAMIS_WINDURST,
        dynaZoneMessageParam = 3,
    },
    [xi.zone.DYNAMIS_JEUNO] =
    {
        winVar = "DynaJeuno_Win",
        enteredVar = "DynaJeuno_entered",
        hasSeenWinCSVar = "DynaJeuno_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_TACTICAL_MAP,
        winTitle = xi.title.DYNAMIS_JEUNO_INTERLOPER,
        winQM = 17547509,
        entryPos = {48.930, 10.002, -71.032, 195, xi.zone.DYNAMIS_JEUNO},
        ejectPos = {48.930, 10.002, -71.032, 195, xi.zone.RULUDE_GARDENS},
        updatedRoam = true,
    },
    [xi.zone.RULUDE_GARDENS] =
    {
        dynaZone = xi.zone.DYNAMIS_JEUNO,
        dynaZoneMessageParam = 4,
    },
    [xi.zone.DYNAMIS_BEAUCEDINE] =
    {
        winVar = "DynaBeaucedine_Win",
        enteredVar = "DynaBeaucedine_entered",
        hasSeenWinCSVar = "DynaBeaucedine_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_INSIGNIA,
        winTitle = xi.title.DYNAMIS_BEAUCEDINE_INTERLOPER,
        winQM = 17326800,
        entryPos = {-284.751, -39.923, -422.948, 235, xi.zone.DYNAMIS_BEAUCEDINE},
        ejectPos = {-284.751, -39.923, -422.948, 235, xi.zone.BEAUCEDINE_GLACIER},
    },
    [xi.zone.BEAUCEDINE_GLACIER] =
    {
        dynaZone = xi.zone.DYNAMIS_BEAUCEDINE,
        dynaZoneMessageParam = 5,
    },
    [xi.zone.DYNAMIS_XARCABARD] =
    {
        winVar = "DynaXarcabard_Win",
        enteredVar = "DynaXarcabard_entered",
        hasSeenWinCSVar = "DynaXarcabard_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_BATTLE_STANDARD,
        winTitle = xi.title.DYNAMIS_XARCABARD_INTERLOPER,
        winQM = 17330780,
        entryPos = {569.312, -0.098, -270.158, 90, xi.zone.DYNAMIS_XARCABARD},
        ejectPos = {569.312, -0.098, -270.158, 90, xi.zone.XARCABARD},
    },
    [xi.zone.XARCABARD] =
    {
        dynaZone = xi.zone.DYNAMIS_XARCABARD,
        dynaZoneMessageParam = 6,
    },
    [xi.zone.DYNAMIS_VALKURM] =
    {
        winVar = "DynaValkurm_Win",
        enteredVar = "DynaValkurm_entered",
        hasSeenWinCSVar = "DynaValkurm_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_VALKURM_SLIVER,
        winTitle = xi.title.DYNAMIS_VALKURM_INTERLOPER,
        winQM = 16937586,
        sjRestrictionNPC = 16937585,
        entryPos = {100, -8, 131, 47, xi.zone.DYNAMIS_VALKURM},
        ejectPos = {119, -9, 131, 52, xi.zone.VALKURM_DUNES},
    },
    [xi.zone.VALKURM_DUNES] =
    {
        dynaZone = xi.zone.DYNAMIS_VALKURM,
        dynaZoneMessageParam = 7,
    },
    [xi.zone.DYNAMIS_BUBURIMU] =
    {
        winVar = "DynaBuburimu_Win",
        enteredVar = "DynaBuburimu_entered",
        hasSeenWinCSVar = "DynaBuburimu_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_BUBURIMU_SLIVER,
        winTitle = xi.title.DYNAMIS_BUBURIMU_INTERLOPER,
        winQM = 16941677,
        entryPos = {155, -1, -169, 170, xi.zone.DYNAMIS_BUBURIMU},
        ejectPos = {154, -1, -170, 190, xi.zone.BUBURIMU_PENINSULA},
        sjRestrictionNPC = 16941676,
        sjRestrictionNPCNumber = 4,
        sjRestrictionLocation =
        {
            [1] = {-214.161, 15.360, -269.202, 54},
            [2] = {620.425, 7.306, -266.427, 71},
            [3] = {427.460, -0.308, 189.224, 50},
            [4] = {320.489, -0.642, 366.648, 101},
        }
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        dynaZone = xi.zone.DYNAMIS_BUBURIMU,
        dynaZoneMessageParam = 8,
    },
    [xi.zone.DYNAMIS_QUFIM] =
    {
        winVar = "DynaQufim_Win",
        enteredVar = "DynaQufim_entered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_QUFIM_SLIVER,
        winTitle = xi.title.DYNAMIS_QUFIM_INTERLOPER,
        winQM = 16945639,
        entryPos = {-19, -17, 104, 253, xi.zone.DYNAMIS_QUFIM},
        ejectPos = { 18, -19, 162, 240, xi.zone.QUFIM_ISLAND},
        sjRestrictionNPC = 16945638,
        sjRestrictionNPCNumber = 12,
        sjRestrictionLocation =
        {
            [1] = {-264.498, -19.255, 401.465, 54},
            [2] = {-264.655, -19.268, 240.580, 71},
            [3] = {-77.771, -19.068, 258.666, 50},
            [4] = {-137.127, -19.976, 228.789, 101},
            [5] = {-61.647, -19.868, 152.935, 35},
            [6] = {27.973, -20.270, 191.907, 195},
            [7] = {107.445, -20.368, 149.587, 64},
            [8] = {99.884, -19.557, 51.518, 27},
            [9] = {-29.895, -21.095, -57.154, 209},
            [10] = {88.474, -20.621, -49.333, 4},
            [11] = {-192.540, -20.477, -11.055, 151},
            [12] = {-340.976, -20.421, 31.154, 66},
        }
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        dynaZone = xi.zone.DYNAMIS_QUFIM,
        dynaZoneMessageParam = 9,
    },
    [xi.zone.DYNAMIS_TAVNAZIA] =
    {
        winVar = "DynaTavnazia_Win",
        enteredVar = "DynaTavnazia_entered",
        hasSeenWinCSVar = "DynaTavnazia_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_TAVNAZIA_SLIVER,
        winTitle = xi.title.DYNAMIS_TAVNAZIA_INTERLOPER,
        winQM = nil,
        entryPos = {0.1, -7, -21, 190, xi.zone.DYNAMIS_TAVNAZIA},
        ejectPos = {0  , -7, -23, 195, xi.zone.TAVNAZIAN_SAFEHOLD},
        timeExtensions = { 16949396, 16949397 },
    },
    [xi.zone.TAVNAZIAN_SAFEHOLD] =
    {
        dynaZone = xi.zone.DYNAMIS_TAVNAZIA,
        dynaZoneMessageParam = 10,
    },

}

local function checkEntryReqs(player, zoneId)
    if
        checkGM(player) or
        (player:getCharVar(xi.dynamis.entryInfoEra[zoneId].enteredVar) ~= 0)
    then
        return true
    end

    if
        player:getMainLvl() < dynamis_min_lvl or
        (xi.dynamis.entryInfoEra[zoneId].csBit >= 7 and not player:hasCompletedMission(xi.mission.log_id.COP, xi.mission.id.cop.DARKNESS_NAMED))
    then
        return false
    end

    local numKIs = #xi.dynamis.entryInfoEra[zoneId].reqs
    local keyItemsPossessed = 0

    for _, ki in pairs(xi.dynamis.entryInfoEra[zoneId].reqs) do
        if player:hasKeyItem(ki) then
            keyItemsPossessed = keyItemsPossessed + 1
        end
    end

    if keyItemsPossessed == numKIs then
        return true
    end

    return false
end

local function cleanupNeeded(zone, zoneMobs)
    local i = 0
    for _, mob in pairs(zoneMobs) do
        if mob:isAlive() then
            return xi.dynamis.cleanupDynamis(zone)
        end
    end
end


local function restoreInstance(zone)
    -- Restore snapshotted variables
    local zoneID = zone:getID()
    local snapshotVariables =
    {
        string.format("[DYNA]Token_%s", zoneID),
        string.format("[DYNA]InstanceID_%s", zoneID),
        string.format("[DYNA]ExpireRoutine_%s", zoneID),
        string.format("[DYNA]Given10MinuteWarning_%s", zoneID),
        string.format("[DYNA]Given3MinuteWarning_%s", zoneID),
        string.format("[DYNA]Given1MinuteWarning_%s", zoneID),
        string.format("[DYNA]CurrentWave_%s", zoneID)
    }

    for _, variable in pairs(snapshotVariables) do
        local value = GetServerVariable(string.format("[SNAPSHOT]%s", variable))
        SetServerVariable(variable, value)
        zone:setLocalVar(variable, value)
    end

    -- Despawn current
    xi.dynamis.despawnAll(zone)

    -- Restore wave enemies
    local instanceID = GetServerVariable(string.format("[DYNA]InstanceID_%s", zoneID))
    local waveNumber = GetServerVariable(string.format("[DYNA]CurrentWave_%s", zoneID))
    if instanceID and instanceID > 0 then
        local mobIndicies = LoadDynamisSnapshot(instanceID)
        xi.dynamis.spawnWaveIndicies(zone, waveNumber or 1, mobIndicies)
    end

end

local function snapshotInstance(zone)
    local zoneID = zone:getID()
    local instanceID = zone:getLocalVar(string.format("[DYNA]InstanceID_%s", zoneID))

    -- Snapshot Mob List
    -- Disabled to ensure stability of release

    -- local mobs = zone:getMobs()
    -- local availableMobList = {}

    -- for _, mob in pairs(mobs) do
    --     if mob:isAlive() then
    --         local index = mob:getLocalVar(string.format("MobIndex_%s", mob:getID()))
    --         if index and index > 0 then
    --             table.insert(availableMobList, index)
    --         end
    --     end
    -- end

    -- Persist to Database
    -- SaveDynamisSnapshot(instanceID, availableMobList)

    -- Snapshot Variables
    local snapshotVariables =
    {
        string.format("[DYNA]Token_%s", zoneID),
        string.format("[DYNA]InstanceID_%s", zoneID),
        string.format("[DYNA]ExpireRoutine_%s", zoneID),
        string.format("[DYNA]Given10MinuteWarning_%s", zoneID),
        string.format("[DYNA]Given3MinuteWarning_%s", zoneID),
        string.format("[DYNA]Given1MinuteWarning_%s", zoneID),
        string.format("[DYNA]CurrentWave_%s", zoneID)
    }

    for _, key in pairs(snapshotVariables) do
        local value = zone:getLocalVar(key)
        SetServerVariable(string.format("[SNAPSHOT]%s", key), value)
    end

    local zoneTimepoint = GetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID))
    local zoneTimeRemaining = xi.dynamis.getDynaTimeRemaining(zoneTimepoint)
    SetServerVariable(string.format("[SNAPSHOT][DYNA]Timepoint_%s", zoneID), zoneTimepoint)
    SetServerVariable(string.format("[SNAPSHOT][DYNA]TimeRemaining_%s", zoneID), zoneTimeRemaining)
end

--------------------------------------------
--      onZoneTick Dynamis Functions      --
--------------------------------------------
xi.dynamis.handleDynamis = function(zone)
    local zoneID = zone:getID()
    local zoneDynamistoken = zone:getLocalVar(string.format("[DYNA]Token_%s", zoneID))
    local zoneTimepoint = GetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID))
    local zoneExpireRoutine = zone:getLocalVar(string.format("[DYNA]ExpireRoutine_%s", zone:getID()))
    local zoneTimeRemaining = xi.dynamis.getDynaTimeRemaining(zoneTimepoint)
    local zone10Min = zone:getLocalVar(string.format("[DYNA]Given10MinuteWarning_%s", zoneID))
    local zone3Min = zone:getLocalVar(string.format("[DYNA]Given3MinuteWarning_%s", zoneID))
    local zone1Min = zone:getLocalVar(string.format("[DYNA]Given1MinuteWarning_%s", zoneID))
    local dreamlands = {xi.zone.DYNAMIS_BUBURIMU, xi.zone.DYNAMIS_QUFIM, xi.zone.DYNAMIS_VALKURM, xi.zone.DYNAMIS_TAVNAZIA}
    local playersInZone = zone:getPlayers()

    for _, player in pairs(playersInZone) do -- Iterates through player list to do stuff.
        if player:getLocalVar("Requires_Initial_Update") == 0 then
            xi.dynamis.updatePlayerHourglass(player, zoneDynamistoken)

            -- This doesn't work right, just disable it
            -- if player:getCharVar(string.format("[DYNA]InflictWeakness_%s", zoneID)) == 1 then -- Should I inflict weakness?
            --     player:addStatusEffect(xi.effect.WEAKNESS, 1, 3, 60 * 10) -- Inflict weakness.
            --     player:setCharVar(string.format("[DYNA]InflictWeakness_%s", zoneID), 0) -- Reset var.
            -- end

            for _, zone_ID in pairs(dreamlands) do
                if zone_ID == zoneID and zone:getLocalVar("SJUnlock") ~= 1 then
                    local savedStatusEffects = {xi.effect.RERAISE, xi.effect.SIGIL, xi.effect.SIGNET, xi.effect.SANCTION, xi.effect.SJ_RESTRICTION, xi.effect.FOOD, xi.effect.BATTLEFIELD}
                    local targetStatusEffects = player:getStatusEffects()
                    for _, targetEffect in pairs(targetStatusEffects) do -- For Each Status Effect on the Player
                        local saveEffect = false -- Default to Remove
                        local effectID = targetEffect:getType()
                        for _, saveEffectID in pairs(savedStatusEffects) do -- Check against each effect in saved effects
                            if effectID == saveEffectID then
                                saveEffect = true -- If match, don't remove and stop searching
                                break
                            end
                        end
                        if saveEffect == false and player:getGMLevel() < 2 then -- Remove effect if player is not a GM.
                            player:delStatusEffectSilent(effectID)
                        end
                    end
                    player:addStatusEffect(xi.effect.SJ_RESTRICTION, 0, 0, 0, 18000) -- Inflict SJ Restriction
                end
            end
            player:setLocalVar("Requires_Initial_Update", 1)
        end

        if not checkGM(player) and player:getLocalVar('[DYNA]NextHourglassCheck') < os.time() then -- GMs can stay in zone until expiry.
            local hasValidHourglass = xi.dynamis.verifyHoldsValidHourglass(player, zoneDynamistoken, zoneTimepoint) -- Checks for a valid hourglass.
            if hasValidHourglass then
                player:setLocalVar('[DYNA]NextHourglassCheck', os.time() + 5)
            end
        end
    end

    for waveNumber, wave in pairs(xi.dynamis.mobList[zoneID].waveDefeatRequirements) do
        local check = 0
        local balance = 0
        local waveSpawned = zone:getLocalVar(string.format("Wave_%i_Spawned", waveNumber))
        for waveNum, var in pairs(wave) do
            check = check + zone:getLocalVar(string.format("%s", var))
            balance = balance + 1
            waveNum = waveNum + 1
        end
        if check == balance then
            if  waveSpawned ~= 1 and waveNumber ~= 1 then
                xi.dynamis.spawnWave(zone, zoneID, waveNumber) -- If not spawn
            end
        end
        waveNumber = waveNumber + 1
    end

    if zoneTimeRemaining <= 0 then -- If now is < 0 minutes remove players and flag cleanup.
        xi.dynamis.ejectAllPlayers(zone) -- Eject players from the zone.
        if zoneExpireRoutine == 0 then
            zone:setLocalVar(string.format("[DYNA]ExpireRoutine_%s", zoneID), (os.time() + 30)) -- Flags zone to start cleanup.
        end
        if zoneExpireRoutine ~= 0 and zoneExpireRoutine <= os.time() then -- Checks to see if 30s passed between start and now.
            xi.dynamis.cleanupDynamis(zone) -- Runs cleanup function.
        end
    end

    if (zone10Min == 0) and (zoneTimeRemaining < (660 * 1000)) then -- If now is < 11 minutes give warning.
        xi.dynamis.dynamisTimeWarning(zone, zoneTimepoint) -- Send time warning.
        zone:setLocalVar(string.format("[DYNA]Given10MinuteWarning_%s", zoneID), 1) -- Sets to true to not give another warning.
    end

    if (zone3Min == 0) and (zoneTimeRemaining < (240 * 1000)) then -- If now is < 4 minutes give warning.
        xi.dynamis.dynamisTimeWarning(zone, zoneTimepoint) -- Send time warning.
        zone:setLocalVar(string.format("[DYNA]Given3MinuteWarning_%s", zoneID), 1) -- Sets to true to not give another warning.
    end

    if (zone1Min == 0) and (zoneTimeRemaining < (120 * 1000)) then -- If now is < 2 minutes give warning.
        xi.dynamis.dynamisTimeWarning(zone, zoneTimepoint) -- Send time warning.
        zone:setLocalVar(string.format("[DYNA]Given1MinuteWarning_%s", zoneID), 1) -- Sets to true to not give another warning.
    end

    if #playersInZone == 0 and zone:getLocalVar(string.format("[DYNA]NoPlayersInZone_%s", zoneID)) == 0 then -- If player count in zone is 0 initiate cooldown for cleanup.
        zone:setLocalVar(string.format("[DYNA]NoPlayersInZone_%s", zoneID), (os.time() + (60 * 15))) -- Give 15 minutes for zone to repopulate.
    else
        zone:setLocalVar(string.format("[DYNA]NoPlayersInZone_%s", zoneID), 0)
    end

    if zone:getLocalVar(string.format("[DYNA]NoPlayersInZone_%s", zoneID)) ~= 0 then
        if zone:getLocalVar(string.format("[DYNA]NoPlayersInZone_%s", zoneID)) <= os.time() then -- If cooldown period eclipses current OS time, cleanup.
            xi.dynamis.cleanupDynamis(zone)
            return
        end
    end

    -- Handle the snapshot
    if
        os.clock() - dynamis_last_snapshot > dynamis_snapshot_interval and
        #playersInZone > 0 and
        #zone:getMobs() > 0
    then
        snapshotInstance(zone)
        dynamis_last_snapshot = os.clock()
    end
end

--------------------------------------------
--         Dynamis Start Functions        --
--------------------------------------------

xi.dynamis.onNewDynamis = function(player)
    local zoneID = xi.dynamis.dynaInfoEra[player:getZoneID()].dynaZone
    local zone = GetZone(zoneID)
    xi.dynamis.spawnWave(zone, zoneID, 1) -- Spawn Wave 1
    if xi.dynamis.dynaInfoEra[zoneID].sjRestrictionNPCNumber then
        local sjNPCLocation = xi.dynamis.dynaInfoEra[zoneID].sjRestrictionLocation[math.random(1, xi.dynamis.dynaInfoEra[zoneID].sjRestrictionNPCNumber)]
        GetNPCByID(xi.dynamis.dynaInfoEra[zoneID].sjRestrictionNPC):setPos(sjNPCLocation[1], sjNPCLocation[2], sjNPCLocation[3])
        GetNPCByID(xi.dynamis.dynaInfoEra[zoneID].sjRestrictionNPC):setStatus(xi.status.NORMAL)
    end
end

--------------------------------------------
--         Dynamis Zone Functions         --
--------------------------------------------

xi.dynamis.addMinutesToDynamis = function(zone, minutes)
    local zoneID = zone:getID()
    local playersInZone = zone:getPlayers()
    local zoneDynamisToken = zone:getLocalVar(string.format("[DYNA]Token_%s", zoneID))
    local prevExpire = GetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID)) -- Determine previous expiration time.
    local targetTime = prevExpire + (60 * minutes)

    -- Update Time Remaining
    SetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID), targetTime)

    -- Update Hourglasses for Players
    for _, player in pairs(playersInZone) do
        player:messageSpecial(zones[zoneID].text.DYNAMIS_TIME_EXTEND, minutes)
        xi.dynamis.updatePlayerHourglass(player, zoneDynamisToken)
    end

    -- Handle Time Limit Warnings
    local timeRemaining = xi.dynamis.getDynaTimeRemaining(expirationTime) -- Gets the time remaining in seconds.
    if timeRemaining > 660 then -- Checks if time remaining > 11 minutes.
        SetServerVariable(string.format("[DYNA]Given10MinuteWarning_%s", zoneID), 0) -- Resets var if time remaining greater than threshold.
    end

    if timeRemaining > 240 then -- Checks if time remaining > 4 minutes.
        SetServerVariable(string.format("[DYNA]Given3MinuteWarning_%s", zoneID), 0) -- Resets var if time remaining greater than threshold.
    end

    if timeRemaining > 120 then -- Checks if time remaining > 2 minutes.
        SetServerVariable(string.format("[DYNA]Given1MinuteWarning_%s", zoneID), 0) -- Resets var if time remaining greater than threshold.
    end
end

xi.dynamis.addTimeToDynamis = function(zone, mobIndex)
    local zoneID = zone:getID()
    if mobIndex ~= nil then
        for _, v in pairs(xi.dynamis.mobList[zoneID].timeExtensionList) do
            if v == mobIndex then
                local timeExtension = xi.dynamis.mobList[zoneID][mobIndex].timeExtension
                local zoneDynamisToken = zone:getLocalVar(string.format("[DYNA]Token_%s", zoneID))
                local prevExpire = GetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID)) -- Determine previous expiration time.
                local expirationTime = prevExpire + (60 * timeExtension) -- Add more time to increase previous expiration point.
                local playersInZone = zone:getPlayers()
                SetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID), expirationTime)

                for _, player in pairs(playersInZone) do
                    player:messageSpecial(zones[zoneID].text.DYNAMIS_TIME_EXTEND, timeExtension) -- Send extension time message.
                    xi.dynamis.updatePlayerHourglass(player, zoneDynamisToken) -- Runs hourglass update function per player.
                end

                local timeRemaining = xi.dynamis.getDynaTimeRemaining(expirationTime) -- Gets the time remaining in seconds.
                if timeRemaining > 660 then -- Checks if time remaining > 11 minutes.
                    SetServerVariable(string.format("[DYNA]Given10MinuteWarning_%s", zoneID), 0) -- Resets var if time remaining greater than threshold.
                end

                if timeRemaining > 240 then -- Checks if time remaining > 4 minutes.
                    SetServerVariable(string.format("[DYNA]Given3MinuteWarning_%s", zoneID), 0) -- Resets var if time remaining greater than threshold.
                end

                if timeRemaining > 120 then -- Checks if time remaining > 2 minutes.
                    SetServerVariable(string.format("[DYNA]Given1MinuteWarning_%s", zoneID), 0) -- Resets var if time remaining greater than threshold.
                end
            end
        end
    else -- Used for Dynamis - Tavnazia
        local zoneDynamisToken = zone:getLocalVar(string.format("[DYNA]Token_%s", zoneID))
        local prevExpire = GetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID)) -- Determine previous expiration time.
        local expirationTime = prevExpire + (1800) -- Add more time to increase previous expiration point.
        local playersInZone = zone:getPlayers()
        SetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID), expirationTime)
        for _, player in pairs(playersInZone) do
            player:messageSpecial(zones[zoneID].text.DYNAMIS_TIME_EXTEND, 30) -- Send extension time message.
            xi.dynamis.updatePlayerHourglass(player, zoneDynamisToken) -- Runs hourglass update function per player.
        end

        local timeRemaining = xi.dynamis.getDynaTimeRemaining(expirationTime) -- Gets the time remaining in seconds.
        if timeRemaining > 660 then -- Checks if time remaining > 11 minutes.
            SetServerVariable(string.format("[DYNA]Given10MinuteWarning_%s", zoneID), 0) -- Resets var if time remaining greater than threshold.
        end

        if timeRemaining > 240 then -- Checks if time remaining > 4 minutes.
            SetServerVariable(string.format("[DYNA]Given3MinuteWarning_%s", zoneID), 0) -- Resets var if time remaining greater than threshold.
        end

        if timeRemaining > 120 then -- Checks if time remaining > 2 minutes.
            SetServerVariable(string.format("[DYNA]Given1MinuteWarning_%s", zoneID), 0) -- Resets var if time remaining greater than threshold.
        end
    end
end

xi.dynamis.ejectAllPlayers = function(zone)
    playersInZone = zone:getPlayers()
    for _, player in pairs(playersInZone) do
        xi.dynamis.ejectPlayer(player) -- Runs the ejectPlayer function per player.
    end
end

xi.dynamis.getDynaTimeRemaining = function(zoneTimePoint)
    return (zoneTimePoint - os.time()) -- Returns difference.
end

xi.dynamis.cleanupDynamis = function(zone)
    local zoneID = zone:getID()
    SetServerVariable(string.format("[DYNA]RegisteredPlayers_%s", zoneID), 0)
    SetServerVariable(string.format("[DYNA]Token_%s", zoneID), 0)
    SetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID), 0)
    SetServerVariable(string.format("[DYNA]Given10MinuteWarning_%s", zoneID), 0)
    SetServerVariable(string.format("[DYNA]Given3MinuteWarning_%s", zoneID), 0)
    SetServerVariable(string.format("[DYNA]Given1MinuteWarning_%s", zoneID), 0)
    SetServerVariable(string.format("[DYNA]OriginalRegistrant_%s", zoneID), 0)
    zone:resetLocalVars()
    xi.dynamis.ejectAllPlayers(zone) -- Remove Players (This is precautionary but not necessary.)
    xi.dynamis.despawnAll(zone) -- Despawns all mobs / npcs in zone
end

xi.dynamis.restoreDynamis = function(zone)
    restoreInstance(zone)
end

xi.dynamis.despawnAll = function(zone)
    -- Cleanup Zone
    local mobsInZone = zone:getMobs()
    local npcsInZone = zone:getNPCs()
    for _, mobEntity in pairs(mobsInZone) do
        DisallowRespawn(mobEntity:getID(), true) -- Stop respawns, used since we are not editing DB.
        mobEntity:setUnkillable(false)
        DespawnMob(mobEntity:getID()) -- Despawn
    end
    for _, npcEntity in pairs(npcsInZone) do
        npcEntity:setStatus(xi.status.DISAPPEAR)
    end
end

xi.dynamis.dynamisTimeWarning = function(zone, zoneTimepoint)
    local zoneID = zone:getID()
    local playersInZone = zone:getPlayers()
    local timeRemaining = math.floor((xi.dynamis.getDynaTimeRemaining(zoneTimepoint) / 60)) -- Get time remaining, convert to minutes, floor value.
    local ID = zones[zoneID]
    for _, player in pairs(playersInZone) do
        if player:getLocalVar("Received_Warning") ~= 1 then
            if timeRemaining <= 2 then
                player:messageSpecial(ID.text.DYNAMIS_TIME_UPDATE_1, timeRemaining, 1) -- Send 1 minute warning.
            else
                player:messageSpecial(ID.text.DYNAMIS_TIME_UPDATE_2, timeRemaining, 1) -- Send [3/10] minutes warning.
            end
            player:setLocalVar("Received_Warning", 1)
        end
    end
end

--------------------------------------------
--        Dynamis Player Functions        --
--------------------------------------------
xi.dynamis.registerDynamis = function(player)
    local zoneID = player:getZoneID()
    local zone = GetZone(xi.dynamis.dynaInfoEra[zoneID].dynaZone)
    local zoneMobs = zone:getMobs()
    cleanupNeeded(zone, zoneMobs)

    local instanceID = RegisterDynamisInstance(zoneID, player:getID())

    local expirationTime = os.time() + (60 * (60 + dynamis_staging_time)) -- Amount of time to extend timepoint by. 60 minutes by default for fresh zones.

    if zoneID == xi.zone.TAVNAZIAN_SAFEHOLD then
        expirationTime = os.time() + 60 * 15 -- Initial time for Dyna Tav should only be 15 minutes
    end

    SetServerVariable(string.format("[DYNA]Token_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), (xi.dynamis.dynaInfoEra[zoneID].dynaZone + expirationTime)) -- Sets Dynamis Token Based on original expiration time and zone ID
    SetServerVariable(string.format("[DYNA]Timepoint_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), expirationTime) -- Sets original timepoint which dynamis will expire.
    SetServerVariable(string.format("[DYNA]RegTimepoint_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), os.time()) -- Sets last registered time.
    SetServerVariable(string.format("[DYNA]OriginalRegistrant_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), player:getID())
    SetServerVariable(string.format("[DYNA]InstanceID_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), instanceID)
    xi.dynamis.onNewDynamis(player) -- Start spawning wave 1.

    local dynamisToken = GetServerVariable(string.format("[DYNA]Token_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone))
    zone:setLocalVar(string.format("[DYNA]Token_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), dynamisToken)
    zone:setLocalVar(string.format("[DYNA]InstanceID_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), instanceID)
    zone:setLocalVar(string.format("[DYNA]CurrentWave_%s", zoneID), 1)
    player:getZone():setLocalVar(string.format("[DYNA]Token_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), dynamisToken)
    player:getZone():setLocalVar(string.format("[DYNA]InstanceID_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), instanceID)
end

xi.dynamis.registerPlayer = function(player)
    local zoneID = player:getZoneID()
    local instanceID = GetServerVariable(string.format("[DYNA]InstanceID_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone))

    player:setCharVar(string.format("[DYNA]PlayerRegisterKey_%s", (xi.dynamis.dynaInfoEra[zoneID].dynaZone)), math.random(1,100)) -- Obfuscate player registration value with dynamis token + player's zone ID info. (Ensures the player is counted as new registrant if token is different.)
    player:setCharVar(string.format("[DYNA]PlayerRegistered_%s", (xi.dynamis.dynaInfoEra[zoneID].dynaZone)), (GetServerVariable(string.format("[DYNA]Token_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone)) + player:getCharVar(string.format("[DYNA]PlayerRegisterKey_%s", (xi.dynamis.dynaInfoEra[zoneID].dynaZone)))))
    player:setCharVar(string.format("[DYNA]PlayerZoneToken_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), GetServerVariable(string.format("[DYNA]Token_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone))) -- Give the player a copy of the token value.
    player:setCharVar(string.format("[DYNA]PlayerRegisterTime_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), GetServerVariable(string.format("[DYNA]RegTimepoint_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone)))
    player:setCharVar("DynaReservationStart", os.time())

    AddDynamisParticipant(instanceID, player:getID())
end

xi.dynamis.isPlayerLockedOut = function(player)
    local lockedOut = false
    local lockoutTime = dynamis_rentry_hours * 60 * 60
    local playerRes = player:getCharVar('DynaReservationStart')

    if os.time() - playerRes < lockoutTime then
        lockedOut = true
    end

    return lockedOut
end

xi.dynamis.isPlayerRegistered = function(player, dynamisToken)
    local zoneID = player:getZoneID()
    local registerID = player:getCharVar(string.format("[DYNA]PlayerRegistered_%s", (xi.dynamis.dynaInfoEra[zoneID].dynaZone))) -- Get player's registered ID.

    if (registerID - dynamisToken) == player:getCharVar(string.format("[DYNA]PlayerRegisterKey_%s", (xi.dynamis.dynaInfoEra[zoneID].dynaZone))) then -- If the remainder is the player's zoneID then they are already registered.
        return true -- Treat as previous registrant.
    else
        return false -- Treat as new registrant.
    end
end

xi.dynamis.ejectPlayer = function(player, forceEject)
    local zoneID = player:getZoneID()
    if forceEject == nil then
        forceEject = false
    end

    if player:getCurrentRegion() == xi.region.DYNAMIS then
        if player:getLocalVar("Received_Eject_Warning") ~= 1 then
            player:delStatusEffectSilent(xi.effect.BATTLEFIELD)
            if not forceEject then
                player:timer(2000, function(playerArg) playerArg:messageSpecial(xi.dynamis.dynaIDLookup[zoneID].text.NO_LONGER_HAVE_CLEARANCE, 0, 30) end) -- Wait 1 second, send no clearance message.
                player:setLocalVar("Received_Eject_Warning", 1)
                player:timer(30000, function(playerArg)
                    playerArg:setCharVar(string.format("[DYNA]EjectPlayer_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), -1) -- Reset player's eject timer.
                    playerArg:disengage() -- Force disengage.
                    playerArg:timer(2000, function(playerArg) player:startCutscene(100) end) -- Wait 2 seconds then play exit CS.
                end)
            else
                player:timer(2000, function(playerArg) playerArg:messageSpecial(xi.dynamis.dynaIDLookup[zoneID].text.NO_LONGER_HAVE_CLEARANCE, 0, 0)
                    playerArg:setCharVar(string.format("[DYNA]EjectPlayer_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), -1) -- Reset player's eject timer.
                    playerArg:disengage() -- Force disengage.
                    playerArg:timer(4000, function(playerArg) player:startCutscene(100) end) -- Wait 2 seconds then play exit CS.
                end) -- Wait 1 second, send no clearance message.
            end
        end
    end
end

xi.dynamis.verifyHoldsValidHourglass = function(player, zoneDynamistoken, zoneTimepoint)
    local zoneID = player:getZoneID()

    if player:validateHourglass(zoneDynamistoken) == true then
        return true
    else
        if checkGM(player) then
            player:setCharVar(string.format("[DYNA]EjectPlayer_%s", zoneID), zoneTimepoint) -- Player is a GM and can bypass the hourglass requirement.
        elseif player:getCharVar(string.format("[DYNA]PlayerZoneToken_%s", player:getZoneID())) ~= zoneDynamistoken then
            xi.dynamis.ejectPlayer(player, true)
        else
            xi.dynamis.ejectPlayer(player)
        end

        return false
    end

    return false
end

xi.dynamis.verifyTradeHourglass = function(player, trade)
    local zoneID = player:getZoneID()
    local dynamisToken = GetServerVariable(string.format("[DYNA]Token_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone))
    if player:validateHourglass(dynamisToken) and xi.dynamis.isPlayerRegistered(player, dynamisToken) == false then -- If signature doesn't have time then new hourglass.
        return 1 -- New Registrant's Hourglass
    elseif player:validateHourglass(dynamisToken) and xi.dynamis.isPlayerRegistered(player, dynamisToken) == true then
        return 2 -- Previous Registrant's Hourglass
    else
        return 3 -- Not valid.
    end
end

xi.dynamis.updatePlayerHourglass = function(player, zoneDynamisToken)
    local zoneID = player:getZoneID()
    local zoneTimepoint = GetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID))

    player:updateHourglass(zoneDynamisToken, zoneTimepoint)
end

--------------------------------------------
--          Dynamis NPC Functions         --
--------------------------------------------

xi.dynamis.entryNpcOnTrade = function(player, npc, trade)
    local zoneID = npc:getZoneID()
    if xi.dynamis.entryInfoEra[zoneID].enabled == false then return end -- If zone is not enabled, return.
    if (player:getLocalVar(xi.dynamis.entryInfoEra[zoneID].enteredVar) == 0) then -- Check if player has entered the Dynamis before.
        if not checkEntryReqs(player, zoneID) then return end end -- Check if player meets all requirements or is a GM.

    local zoneTimepoint = GetServerVariable(string.format("[DYNA]Timepoint_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone))
    local dynamis_time_remaining = xi.dynamis.getDynaTimeRemaining(zoneTimepoint) -- Get time remaining of Dynamis
    local entered = player:getCharVar(xi.dynamis.entryInfoEra[zoneID].enteredVar)

    local lockedOut = false
    local lockoutTime = dynamis_rentry_hours * 60 * 60
    local playerRes = player:getCharVar('DynaReservationStart')

    if os.time() - playerRes < lockoutTime then
        lockedOut = true
    end

    if entered == nil then
        entered = 0
    end

    if npcUtil.tradeHasExactly(trade, {dynamis_timeless}) then -- Check for timeless hourglass to trade for perpetual hourglass to start instance
        if dynamis_time_remaining > 0 then -- Check if another group is present.
            player:messageSpecial(xi.dynamis.dynaIDLookup[zoneID].text.ANOTHER_GROUP, xi.dynamis.entryInfoEra[zoneID].csBit)
        elseif checkGM(player) then -- If no other group, if GM bypass lockout and start new dynamis.
            player:startEvent(xi.dynamis.entryInfoEra[zoneID].csRegisterGlass, xi.dynamis.entryInfoEra[zoneID].csBit, entered == 1 and 0 or 1, dynamis_reservation_cancel, dynamis_reentry_days, xi.dynamis.entryInfoEra[zoneID].maxCapacity, xi.ki.VIAL_OF_SHROUDED_SAND, dynamis_timeless, dynamis_perpetual)
        elseif lockedOut then -- Still in lockout period.
            local span = os.time() - playerRes
            span = span / 60
            player:messageSpecial(zones[zoneID].text.YOU_CANNOT_ENTER_DYNAMIS, math.ceil(span), xi.dynamis.entryInfoEra[zoneID].csBit)
        else -- Proceed in starting new dynamis.
            player:startEvent(xi.dynamis.entryInfoEra[zoneID].csRegisterGlass, xi.dynamis.entryInfoEra[zoneID].csBit, entered == 1 and 0 or 1, dynamis_reservation_cancel, dynamis_reentry_days, xi.dynamis.entryInfoEra[zoneID].maxCapacity, xi.ki.VIAL_OF_SHROUDED_SAND, dynamis_timeless, dynamis_perpetual)
        end
    elseif npcUtil.tradeHasExactly(trade, {dynamis_perpetual}) then -- Check for perpetual hourglass to  enter instance
        local dynaCapacity = GetServerVariable(string.format("[DYNA]RegisteredPlayers_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone))
        if checkGM(player) then -- Don't register GMs.
            xi.dynamis.registerPlayer(player)
            player:startEvent(xi.dynamis.entryInfoEra[zoneID].csDyna, xi.dynamis.entryInfoEra[zoneID].csBit, entered == 1 and 0 or 1, dynamis_reservation_cancel, dynamis_reentry_days, xi.dynamis.entryInfoEra[zoneID].maxCapacity, xi.ki.VIAL_OF_SHROUDED_SAND, dynamis_timeless, dynamis_perpetual)
        else
            local dynamis_glass_valid = xi.dynamis.verifyTradeHourglass(player, trade)
            if dynamis_glass_valid == 2 then -- Allow previous registrant into the zone.
                player:startEvent(xi.dynamis.entryInfoEra[zoneID].csDyna, xi.dynamis.entryInfoEra[zoneID].csBit, entered == 1 and 0 or 1, dynamis_reservation_cancel, dynamis_reentry_days, xi.dynamis.entryInfoEra[zoneID].maxCapacity, xi.ki.VIAL_OF_SHROUDED_SAND, dynamis_timeless, dynamis_perpetual)
                player:setCharVar(string.format("[DYNA]InflictWeakness_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), 1) -- Tell dynamis to inflict weakness.
            elseif lockedOut then -- If in lockout, deny.
                local span = os.time() - playerRes
                span = span / 60
                player:messageSpecial(zones[zoneID].text.YOU_CANNOT_ENTER_DYNAMIS, math.ceil(span), xi.dynamis.entryInfoEra[zoneID].csBit)
            elseif dynamis_glass_valid == 1 then -- Initiate new registrant procedure.
                if dynaCapacity <= xi.dynamis.entryInfoEra[zoneID].maxCapacity then -- If not at max capacity, allow in.
                    xi.dynamis.registerPlayer(player)
                    player:startEvent(xi.dynamis.entryInfoEra[zoneID].csDyna, xi.dynamis.entryInfoEra[zoneID].csBit, entered == 1 and 0 or 1, dynamis_reservation_cancel, dynamis_reentry_days, xi.dynamis.entryInfoEra[zoneID].maxCapacity, xi.ki.VIAL_OF_SHROUDED_SAND, dynamis_timeless, dynamis_perpetual)
                    player:setCharVar(string.format("[DYNA]InflictWeakness_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), 0) -- Tell dynamis to not inflict weakness.
                    SetServerVariable(string.format("[DYNA]RegisteredPlayers_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone), dynaCapacity + 1) -- Increment registered players by 1.
                else
                    player:PrintToPlayer("The Dynamis instance has reached its maximum capacity of".. xi.dynamis.entryInfoEra[zoneID].maxCapacity .. "registrants.", 29) -- Let player know max registration has taken place.
                end
            else
                if dynamis_time_remaining > 0 then
                    player:messageSpecial(xi.dynamis.dynaIDLookup[zoneID].text.ANOTHER_GROUP, xi.dynamis.entryInfoEra[zoneID].csBit) -- There is another group in dynamis.
                else
                    player:PrintToPlayer("The Perpetual Hourglass' time has run out.", 29) -- Something is invalid, fail to time has run out.
                end
            end
        end
    end
end

m:addOverride("xi.dynamis.entryNpcOnTrigger", function(player, npc)
    local zoneID = player:getZoneID()
    if xi.dynamis.entryInfoEra[zoneID].enabled == false then -- If not enabled give default message.
        player:messageSpecial(zones[player:getZoneID()].text.DYNA_NPC_DEFAULT_MESSAGE)
        return
    end

    if xi.dynamis.entryInfoEra[zoneID].csSand ~= nil and player:getCharVar("Dynamis_Status") == 1 and not player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) then -- If player does not have sand, start CS to give sand.
        player:startEvent(xi.dynamis.entryInfoEra[zoneID].csSand)
    elseif xi.dynamis.entryInfoEra[zoneID].csWin ~= nil and player:hasKeyItem(xi.dynamis.entryInfoEra[zoneID].winKI) and player:getCharVar(xi.dynamis.entryInfoEra[zoneID].hasSeenWinCSVar) == 0 then -- If player hasn't seen win CS play win CS.
        player:startEvent(xi.dynamis.entryInfoEra[zoneID].csWin)
    else
        player:messageSpecial(zones[zoneID].text.DYNA_NPC_DEFAULT_MESSAGE) -- Just play default message otherwise.
    end
end)

xi.dynamis.entryNpcOnEventUpdate = function(player, csid, option)
    local zoneID = player:getZoneID()
    if xi.dynamis.entryInfoEra[zoneID].enabled == false then return end -- If not enabled return.
    if csid == xi.dynamis.entryInfoEra[zoneID].csRegisterGlass then -- If dynamis register glass cs.
        if option == 0 then -- If completes the cutscene.
            xi.dynamis.registerDynamis(player) -- Trigger the generation of a token, timepoint, and start spawning wave 1.
            player:timer(5000, function(playerArg)
                playerArg:tradeComplete()
                local dynaZone = GetZone(xi.dynamis.dynaInfoEra[zoneID].dynaZone)
                local dynamisToken = dynaZone:getLocalVar(string.format("[DYNA]Token_%s", xi.dynamis.dynaInfoEra[zoneID].dynaZone))
                playerArg:createHourglass(xi.dynamis.dynaInfoEra[zoneID].dynaZone, dynamisToken, playerArg:getID()) -- Create initial perpetual.
                playerArg:messageSpecial(xi.dynamis.dynaIDLookup[zoneID].text.INFORMATION_RECORDED, dynamis_perpetual) -- Send player the recorded message.
                playerArg:messageSpecial(zones[zoneID].text.ITEM_OBTAINED, dynamis_perpetual) -- Give player a message stating the perpetual has been obtained.
                playerArg:release(1)
            end)
        else
            player:release(1) -- Failed to complete CS.
            player:messageSpecial(xi.dynamis.dynaIDLookup[zoneID].text.UNABLE_TO_CONNECT)
        end
    end
end

m:addOverride("xi.dynamis.entryNpcOnEventFinish", function(player, csid, option)
    local zoneID = player:getZoneID()
    if xi.dynamis.entryInfoEra[zoneID].enabled == false then return end
    if csid == xi.dynamis.entryInfoEra[zoneID].csDyna then -- enter dynamis
        if option == 0 then
            local entryPos = xi.dynamis.entryInfoEra[zoneID].enterPos
            if entryPos == nil then return end -- If entryPos isn't there, don't teleport.
            player:messageSpecial(xi.dynamis.dynaIDLookup[player:getZoneID()].text.CONNECTING_WITH_THE_SERVER) -- Just to mimic what we have previously had.
            player:setCharVar(xi.dynamis.entryInfoEra[zoneID].enteredVar, 1) -- Mark the player as having entered at least once.
            player:timer(5000, function(player) player:setPos(entryPos[1], entryPos[2], entryPos[3], entryPos[4], entryPos[5]) end)
        end
    elseif csid == xi.dynamis.entryInfoEra[zoneID].csSand then -- Give Shrouded Sand KI
        npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_SHROUDED_SAND)
    elseif csid == xi.dynamis.entryInfoEra[zoneID].csWin then -- Seen Win CS
        player:setCharVar(xi.dynamis.entryInfoEra[zoneID].hasSeenWinCSVar, 1)
    end
end)

xi.dynamis.sjQMOnTrigger = function(npc)
    local zone = npc:getZone()
    local playersInZone = zone:getPlayers()
    for _, playerEntity in pairs(playersInZone) do
        if  playerEntity:hasStatusEffect(xi.effect.SJ_RESTRICTION) then -- Does player have SJ restriction?
            playerEntity:delStatusEffect(xi.effect.SJ_RESTRICTION) -- Remove SJ restriction
        end
    end
    zone:setLocalVar("SJUnlock", 1)
end

xi.dynamis.timeExtensionOnTrigger = function(player, npc)
    local zone = player:getZone()
    xi.dynamis.addTimeToDynamis(zone, nil) -- Add Time
    for _, member in pairs(zone:getPlayers()) do
        member:changeMusic(0, 227) -- 0 Background Music (Sunbreeze Music)
        member:changeMusic(1, 227) -- 1 Background Music (Sunbreeze Music)
    end

    if npc:getID() == 16949396 then
        zone:setLocalVar("qmOne", 1)
    elseif npc:getID() == 16949397 then
        zone:setLocalVar("qmTwo", 1)
    end

    npc:setStatus(xi.status.DISAPPEAR)
end

m:addOverride("xi.dynamis.qmOnTrigger", function(player, npc) -- Override standard qmOnTrigger()
    local zoneId = npc:getZoneID()
    if not player:hasKeyItem(xi.dynamis.dynaInfoEra[zoneId].winKI) then
        npcUtil.giveKeyItem(player, xi.dynamis.dynaInfoEra[zoneId].winKI)
    end
end)

--------------------------------------------
--      Dynamis Player/Zone Functions     --
--------------------------------------------

xi.dynamis.zoneOnZoneInEra = function(player, prevZone)
    local zoneID = player:getZoneID()
    local zoneTimepoint = GetServerVariable(string.format("[DYNA]Timepoint_%s", zoneID))
    local info = xi.dynamis.dynaInfoEra[zoneID]
    local ID = zones[zoneID]

    -- usually happens when zoning in with !zone command
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then player:setPos(info.entryPos[1], info.entryPos[2], info.entryPos[3], info.entryPos[4]) end -- If player is in void, move player to entry.

    player:timer(5000, function(playerArg)
        local timepoint = xi.dynamis.getDynaTimeRemaining(zoneTimepoint)
        playerArg:addStatusEffectEx(xi.effect.BATTLEFIELD, 0, 1, 0, 0, true)
        playerArg:messageSpecial(ID.text.DYNAMIS_TIME_UPDATE_2, math.floor(utils.clamp(timepoint, 0, timepoint) / 60), 1) -- Send message letting player know how long they have.
    end)

    return -1
end

xi.dynamis.zoneOnZoneOut = function(player)
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        player:delStatusEffectSilent(xi.effect.BATTLEFIELD)
    end
end

-- Disable Base LSB Additional Functions
m:addOverride("xi.dynamis.somnialThresholdOnTrigger", function(player,npc) end)
m:addOverride("xi.dynamis.somnialThresholdOnEventFinish", function(player,npc) end)
m:addOverride("xi.dynamis.timeExtensionOnDeath", function(mob, player, optParams) end)
m:addOverride("xi.dynamis.refillStatueOnSpawn", function(mob) end)
m:addOverride("xi.dynamis.refillStatueOnSDeath", function(mob, player, optParams) end)
m:addOverride("xi.dynamis.qmOnTrade", function(player, npc, trade) end) -- Not used...  Era Dynamis does not have QM pops.
m:addOverride("xi.dynamis.getExtensions", function(player) end)

return m
