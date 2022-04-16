--------------------------------------------
--      Dynamis Wings 75 Era Module       --
--------------------------------------------
--------------------------------------------
--       Module Required Scripts          --
--------------------------------------------
require("scripts/mixins/job_special")
require("scripts/globals/battlefield")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
require("scripts/globals/status")
require("scripts/globals/titles")
require("scripts/globals/utils")
require("scripts/globals/zone")
require("scripts/globals/msg")
require("scripts/globals/pathfind")
require("scripts/module_utils")
--------------------------------------------
--       Module Affected Scripts          --
--------------------------------------------
require("scripts/globals/dynamis")
--------------------------------------------

local m = Module:new("wings_75_cap_dynamis")
m:setEnabled(true)

xi = xi or {}
xi.dynamis = xi.dynamis or {}

-- TODO: Port the following cpp functions:
-- GetDynaTimeRemaining (Easy port to LUA)
-- checkHourglassValid (Easy port to LUA)
-- prepareDynamisEntry (Potentially port to LUA)
-- pingDynamis (Unlikely to port to LUA, uses RPC Sync)
-- registerHourglass (Potentially port to LUA)
-- verifyHoldsValidHourglass (Potentially port to LUA)
-- updateHourglassExpireTime 
-- DynamisGetExpiryTimepoint
-- DynamisGetToken (SQL Hook Requires C++)
-- DynamisGetExpiryTimepoint (SQL Hook Requires C++)
-- CallRPCAsync
-- Look over statueOnEngaged

--------------------------------------------
--        Global Dynamis Variables        --
--------------------------------------------
local dynamis_timeless = 4236
local dynamis_perpetual = 4237
local dynamis_min_lvl = 65
local dynamis_reservation_cancel = 180
local dynamis_reentry_days = 3
local dynamis_rentry_hours = 71
local dynamis_win_aoe = false

local entryInfoEra =
{
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
        dynamis_has_enteredVar = "DynaSandoria_dynamis_has_entered",
        hasSeenWinCSVar = "DynaSandoria_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_COMMAND_SCEPTER,
        enterPos = {161.838, -2.000, 161.673, 93, 185},
        reqs = function(player)
            return (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) and
                   (player:getMainLvl() >= dynamis_min_lvl)) or
                   (player:getGMLevel() > 1)
        end,
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
        dynamis_has_enteredVar = "DynaBastok_dynamis_has_entered",
        hasSeenWinCSVar = "DynaBastok_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_EYEGLASS,
        enterPos = {116.482, 0.994, -72.121, 128, 186},
        reqs = function(player)
            return (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) and
                   (player:getMainLvl() >= dynamis_min_lvl)) or
                   (player:getGMLevel() > 1)
        end,
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
        dynamis_has_enteredVar = "DynaWindurst_dynamis_has_entered",
        hasSeenWinCSVar = "DynaWindurst_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_LANTERN,
        enterPos = {-221.988, 1.000, -120.184, 0, 187},
        reqs = function(player)
            return (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) and
                   (player:getMainLvl() >= dynamis_min_lvl)) or
                   (player:getGMLevel() > 1)
        end,
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
        dynamis_has_enteredVar = "DynaJeuno_dynamis_has_entered",
        hasSeenWinCSVar = "DynaJeuno_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_TACTICAL_MAP,
        enterPos = {48.930, 10.002, -71.032, 195, 188},
        reqs = function(player)
            return (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) and
                   (player:getMainLvl() >= dynamis_min_lvl)) or
                   (player:getGMLevel() > 1)
        end,
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
        dynamis_has_enteredVar = "DynaBeaucedine_dynamis_has_entered",
        hasSeenWinCSVar = "DynaBeaucedine_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_INSIGNIA,
        enterPos = {-284.751, -39.923, -422.948, 235, 134},
        reqs = function(player)
            return (player:hasKeyItem(xi.ki.HYDRA_CORPS_COMMAND_SCEPTER) and
                    player:hasKeyItem(xi.ki.HYDRA_CORPS_EYEGLASS) and
                    player:hasKeyItem(xi.ki.HYDRA_CORPS_LANTERN) and
                    player:hasKeyItem(xi.ki.HYDRA_CORPS_TACTICAL_MAP) and
                   (player:getMainLvl() >= dynamis_min_lvl)) or
                   (player:getGMLevel() > 1)
        end,
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
        dynamis_has_enteredVar = "DynaXarcabard_dynamis_has_entered",
        hasSeenWinCSVar = "DynaXarcabard_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_BATTLE_STANDARD,
        enterPos = {569.312, -0.098, -270.158, 90, 135},
        reqs = function(player)
            return (player:hasKeyItem(xi.ki.HYDRA_CORPS_INSIGNIA) and
                   (player:getMainLvl() >= dynamis_min_lvl)) or
                   (player:getGMLevel() > 1)
        end,
    },
    [xi.zone.VALKURM_DUNES] =
    {
        csBit = 7,
        csRegisterGlass = 15,
        csFirst = 33,
        csWin = 39,
        csDyna = 58,
        maxCapacity = 32,
        enabled = true,
        winVar = "DynaValkurm_Win",
        dynamis_has_enteredVar = "DynaValkurm_dynamis_has_entered",
        hasSeenWinCSVar = "DynaValkurm_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_VALKURM_SLIVER,
        enterPos = {100, -8, 131, 47, 39},
        reqs = function(player)
            return (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) and
                    player:getMainLvl() >= dynamis_min_lvl and
                   (player:hasCompletedMission(COP, xi.mission.id.cop.DARKNESS_NAMED) == true)) or
                   (player:getGMLevel() > 1)
        end,
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        csBit = 8,
        csRegisterGlass = 21,
        csFirst = 40,
        csWin = 46,
        csDyna = 22,
        maxCapacity = 32,
        enabled = true,
        winVar = "DynaBuburimu_Win",
        dynamis_has_enteredVar = "DynaBuburimu_dynamis_has_entered",
        hasSeenWinCSVar = "DynaBuburimu_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_BUBURIMU_SLIVER,
        enterPos = {155, -1, -169, 170, 40},
        reqs = function(player)
            return (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) and
                    player:getMainLvl() >= dynamis_min_lvl and
                   (player:hasCompletedMission(COP, xi.mission.id.cop.DARKNESS_NAMED) == true)) or
                   (player:getGMLevel() > 1)
        end,
    },
    [xi.zone.QUFIM_ISLAND] =
    {
        csBit = 9,
        csRegisterGlass = 2,
        csFirst = 22,
        csWin = 28,
        csDyna = 3,
        maxCapacity = 32,
        enabled = true,
        winVar = "DynaQufim_Win",
        dynamis_has_enteredVar = "DynaQufim_dynamis_has_entered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_QUFIM_SLIVER,
        enterPos = {-19, -17, 104, 253, 41},
        reqs = function(player)
            return (player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) and
                    player:getMainLvl() >= dynamis_min_lvl and
                   (player:hasCompletedMission(COP, xi.mission.id.cop.DARKNESS_NAMED) == true)) or
                   (player:getGMLevel() > 1)
        end,
    },
    [xi.zone.TAVNAZIAN_SAFEHOLD] =
    {
        csBit = 10,
        csRegisterGlass = 587,
        csFirst = 614,
        csWin = 615,
        csDyna = 588,
        maxCapacity = 18,
        enabled = false,
        winVar = "DynaTavnazia_Win",
        dynamis_has_enteredVar = "DynaTavnazia_dynamis_has_entered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_TAVNAZIA_SLIVER,
        enterPos = {0.1, -7, -21, 190, 42},
        reqs = function(player)
            return (player:hasKeyItem(xi.ki.DYNAMIS_VALKURM_SLIVER) and
                    player:hasKeyItem(xi.ki.DYNAMIS_QUFIM_SLIVER) and
                    player:hasKeyItem(xi.ki.DYNAMIS_BUBURIMU_SLIVER) and
                    player:getMainLvl() >= dynamis_min_lvl and
                   (player:hasCompletedMission(COP, xi.mission.id.cop.DARKNESS_NAMED) == true)) or
                   (player:getGMLevel() > 1)
        end,
    },
}

local dynaInfoEra =
{
        --[[
    [zone] =
    {
        winVar = Variable for the Win Condition
        dynamis_has_enteredVar = Variable for Previous Entry
        hasSeenWinCSVar = Variable for Win CS
        winKI = Key item for win
        winTitle = Title for win
        entryPos = Coordinates in destination zone (Dynamis Zone)
        ejectPos = Coordinates in originating zone (Non-Dynamis Zone)
        specifiedChildren = Boolean for using specific children spawns.
        updatedRoam = Boolean for using LimitBreak statue roaming paths.
    }
        --]]

    [xi.zone.DYNAMIS_SAN_DORIA] =
    {
        winVar = "DynaSandoria_Win",
        dynamis_has_enteredVar = "DynaSandoria_dynamis_has_entered",
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
        dynamis_has_enteredVar = "DynaBastok_dynamis_has_entered",
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
        dynamis_has_enteredVar = "DynaWindurst_dynamis_has_entered",
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
        dynamis_has_enteredVar = "DynaJeuno_dynamis_has_entered",
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
        dynamis_has_enteredVar = "DynaBeaucedine_dynamis_has_entered",
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
        dynamis_has_enteredVar = "DynaXarcabard_dynamis_has_entered",
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
        dynamis_has_enteredVar = "DynaValkurm_dynamis_has_entered",
        hasSeenWinCSVar = "DynaValkurm_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_VALKURM_SLIVER,
        winTitle = xi.title.DYNAMIS_VALKURM_INTERLOPER,
        winQM = 16937586,
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
        dynamis_has_enteredVar = "DynaBuburimu_dynamis_has_entered",
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
        dynamis_has_enteredVar = "DynaQufim_dynamis_has_entered",
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
        dynamis_has_enteredVar = "DynaTavnazia_dynamis_has_entered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_TAVNAZIA_SLIVER,
        winTitle = xi.title.DYNAMIS_TAVNAZIA_INTERLOPER,
        winQM = nil,
        entryPos = {0.1, -7, -21, 190, xi.zone.DYNAMIS_TAVNAZIA},
        ejectPos = {0  , -7, -23, 195, xi.zone.TAVNAZIAN_SAFEHOLD},
    },
    [xi.zone.TAVNAZIAN_SAFEHOLD] =
    {
        dynaZone = xi.zone.DYNAMIS_TAVNAZIA,
        dynaZoneMessageParam = 10,
    },

}

xi.dynamis.eyesEra =
{
    NONE    = 0,
    RED     = 1,
    BLUE    = 2,
    GREEN   = 3,
}

xi.dynamis.entryNpcOnTrade = function(player, npc, trade, message_not_reached_level, message_another_group, message_cannot_enter)
    local playerZoneID = player:getZoneID()
    if entryInfoEra[zoneID].enabled == false then return end -- If zone is not enabled, return.
    if (player:getLocalVar(entryInfoEra[zoneID].dynamis_has_enteredVar) == 0) then -- Check if player has entered the Dynamis before.
    if (entryInfoEra[zoneID].reqs == false) then return end end -- Check if player meets all requirements or is a GM.

    local dynamis_time_remaining = GetDynaTimeRemaining(entryInfoEra[zoneID].enterPos[5])
    local dynamis_has_entered = player:getCharVar(entryInfoEra[zoneID].dynamis_has_enteredVar)
    local dynamis_last_reservation = (os.time() / 3600) - player:getCharVar("DynaReservationStart") -- Return Time of Last Reservation in Hours

    if npcUtil.tradeHas(trade, dynamis_timeless, true, false) then -- Check for timeless hourglass to trade for perpetual hourglass
        if dynamis_time_remaining > 0 then
            player:messageSpecial(message_another_group, entryInfoEra[zoneID].csBit)
        elseif player:getGMLevel() > 1 then
            player:startEvent(entryInfoEra[zoneID].csRegisterGlass, entryInfoEra[zoneID].csBit, dynamis_has_entered == 1 and 0 or 1, dynamis_reservation_cancel, dynamis_reentry_days, entryInfoEra[zoneID].maxCapacity, xi.ki.VIAL_OF_SHROUDED_SAND, dynamis_timeless,dynamis_perpetual)
        elseif dynamis_last_reservation < dynamis_rentry_hours then
            player:messageSpecial(message_cannot_enter, (dynamis_rentry_hours - dynamis_last_reservation), entryInfoEra[zoneID].csBit)
        else
            player:startEvent(entryInfoEra[zoneID].csRegisterGlass, entryInfoEra[zoneID].csBit, dynamis_has_entered == 1 and 0 or 1, dynamis_reservation_cancel, dynamis_reentry_days, entryInfoEra[zoneID].maxCapacity, xi.ki.VIAL_OF_SHROUDED_SAND, dynamis_timeless,dynamis_perpetual)
        end
    elseif npcUtil.tradeHas(trade, dynamis_perpetual, true, false) then -- Check for perpetual hourglass to start or enter instance
        local dynamis_glass_valid = player:checkHourglassValid(trade:getItem(0), entryInfoEra[zoneID].enterPos[5])
        if dynamis_glass_valid > 0 then -- 0 = player can't enter, 1 = entering, 2 = re-entering (weakness)
            player:prepareDynamisEntry(trade:getItem(0), dynamis_glass_valid) -- save the hourglass's params to the character while they are viewing the cs
            player:startEvent(entryInfoEra[zoneID].csDyna, entryInfoEra[zoneID].csBit, dynamis_has_entered == 1 and 0 or 1, dynamis_reservation_cancel, dynamis_reentry_days, entryInfoEra[zoneID].maxCapacity, xi.ki.VIAL_OF_SHROUDED_SAND, dynamis_timeless, dynamis_perpetual)
        elseif dynamis_last_reservation < dynamis_rentry_hours then
            player:messageSpecial(message_cannot_enter, (dynamis_rentry_hours - dynamis_last_reservation), entryInfoEra[zoneID].csBit)
        elseif player:getGMLevel() > 1 then
            player:startEvent(entryInfoEra[zoneID].csDyna, entryInfoEra[zoneID].csBit, dynamis_has_entered == 1 and 0 or 1, dynamis_reservation_cancel, dynamis_reentry_days, entryInfoEra[zoneID].maxCapacity, xi.ki.VIAL_OF_SHROUDED_SAND, dynamis_timeless, dynamis_perpetual)
        elseif dynamis_time_remaining > 0 then
            player:messageSpecial(message_another_group, entryInfoEra[zoneID].csBit)
        else
            player:PrintToPlayer("The Perpetual Hourglass' time has run out.", 29)
        end
    end
end

dynamis.entryNpcOnTrigger = function(player, npc, message_default)
    local playerZoneID = player:getZoneID()
    if dynamis.entryInfo[playerZoneID].enabled == false then
        player:messageSpecial(message_default)
        return
    end
    if dynamis.entryInfo[playerZoneID].csSand ~= nil and player:getCharVar("HasSeenXarcabardDynamisCS") == 1 and player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND) == false then
        player:startEvent(dynamis.entryInfo[playerZoneID].csSand)
    elseif dynamis.entryInfo[playerZoneID].csWin ~= nil and player:hasKeyItem(dynamis.entryInfo[playerZoneID].winKI) and player:getCharVar(dynamis.entryInfo[playerZoneID].hasSeenWinCSVar) == 0 then
        player:startEvent(dynamis.entryInfo[playerZoneID].csWin)
    else
        player:messageSpecial(message_default)
    end
end

m:addOverride("xi.dynamis.entryNpcOnTrigger", function(player, npc, message_default)
    local zoneID = player:getZoneID()
    if entryInfoEra[zoneID].enabled == false then
        player:messageSpecial(message_default)
        return
    end
    if entryInfoEra[zoneID].csSand ~= nil and player:getCharVar("HasSeenXarcabardDynamisCS") == 1 and player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) == false then
        player:startEvent(entryInfoEra[zoneID].csSand)
    elseif entryInfoEra[zoneID].csWin ~= nil and player:hasKeyItem(entryInfoEra[zoneID].winKI) and player:getCharVar(entryInfoEra[zoneID].hasSeenWinCSVar) == 0 then
        player:startEvent(entryInfoEra[zoneID].csWin)
    else
        player:messageSpecial(message_default)
    end
end)

xi.dynamis.entryNpcOnEventUpdate = function(player, csid, option, message_unable_to_connect)
    local zoneID = player:getZoneID()
    if entryInfoEra[zoneID].enabled == false then return end
    if csid == entryInfoEra[zoneID].csRegisterGlass then -- trade out timeless hourglass for a perpetual hourglass
        -- Do not proceed until we know the Dynamis server is up.
        -- This will prevent us from deleting the expensive hourglass
        -- if we cannot provide the service
        if option == 0 then
            player:setCharVar("DynaPrep_zoneid", entryInfoEra[zoneID].enterPos[5])
            player:setLocalVar("DynamisWaitingForServer", 1)
            player:pingDynamis()
            player:queue(5000, function(player)
                if player:getLocalVar("DynamisWaitingForServer") ~= 0 then
                    player:setLocalVar("DynamisWaitingForServer", 0)
                    player:release()
                    player:messageSpecial(message_unable_to_connect, entryInfoEra[zoneID].csBit)
                end
            end)
        else
            player:release()
        end
    end
end

m:addOverride("xi.dynamis.entryNpcOnEventFinish", function(player, csid, option, message_connecting_with_the_server, message_unable_to_connect)
    local zoneID = player:getZoneID()
    if entryInfoEra[zoneID].enabled == false then return end
    if csid == entryInfoEra[zoneID].csDyna then -- enter dynamis
        if option == 0 then
            -- Will call onDynamisServerReply async when the server replies
            player:setLocalVar("DynamisWaitingForServer", 1)
            player:registerDynamis()
            -- In case the Dynamis server failed notify the player
            player:messageSpecial(message_connecting_with_the_server, entryInfoEra[zoneID].csBit)
            player:queue(5000, function(player)
                if player:getLocalVar("DynamisWaitingForServer") ~= 0 then
                    player:setLocalVar("DynamisWaitingForServer", 0)
                    player:messageSpecial(message_unable_to_connect, entryInfoEra[zoneID].csBit)
                    player:queue(1000, function(player)
                        player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
                    end)
                end
            end)
        end
    elseif csid == entryInfoEra[zoneID].csSand then -- Give Shrouded Sand KI
        npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_SHROUDED_SAND)
    elseif csid == entryInfoEra[zoneID].csWin then -- Seen Win CS
        player:setCharVar(entryInfoEra[zoneID].hasSeenWinCSVar, 1)
    end
end)

xi.dynamis.entryNpcOnDynamisServerReply = function(player, result, message_information_recorded, message_obtained, message_another_group)
    local zoneID = player:getZoneID()
    if entryInfoEra[zoneID].enabled == false then return end
    player:setLocalVar("DynamisWaitingForServer", 0)
    if result == 2 then
        -- Ping response when trading timeless hourglass
        player:release()
        if player:registerHourglass(entryInfoEra[zoneID].enterPos[5]) == true then
            trade = player:getCurrentTrade()
            if trade ~= nil and npcUtil.tradeHasExactly(trade, dynamis_timeless) then
                player:confirmTrade()
                player:messageSpecial(message_information_recorded, dynamis_perpetual)
                player:messageSpecial(message_obtained, dynamis_perpetual)
            end
        end
    elseif result == 1 then
        -- Entry when trading perpetual hourglass
        local entryPos = entryInfoEra[zoneID].enterPos
        if entryPos == nil then return end
        player:setCharVar(entryInfoEra[zoneID].dynamis_has_enteredVar, 1)
        player:setPos(entryPos[1], entryPos[2], entryPos[3], entryPos[4], entryPos[5])
    elseif result == 3 then
        player:messageSpecial(message_another_group, entryInfoEra[zoneID].csBit)
        player:queue(1000, function(player)
            player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
        end)
    else
        player:PrintToPlayer("The Dynamis instance has reached its maximum capacity of".. entryInfoEra[zoneID].maxCapacity .. "registrants.", 29)
        player:queue(1000, function(player)
            player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
        end)
    end
end

m:addOverride("xi.dynamis.zoneOnZoneIn", function(player, prevZone)
    local zoneId = player:getZoneID()
    local info = dynaInfoEra[zoneId]
    local ID = zones[zoneId]

    -- usually happens when zoning in with !zone command
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then player:setPos(info.entryPos[1], info.entryPos[2], info.entryPos[3], info.entryPos[4]) end

    if player:verifyHoldsValidHourglass() == true then
        player:updateHourglassExpireTime()
        player:timer(1000, function(player)
            player:messageSpecial(ID.text.DYNAMIS_TIME_UPDATE_2, math.floor(GetDynaTimeRemaining(zoneId) / 60), 1)
            if player:dynaCurrencyAutoDropEnabled() == true then player:PrintToPlayer("As the original registrant of this instance, Dynamis currencies will auto-drop to you when possible (use !currency to opt out).",29) end
        end)
        if player:getCharVar("DynaInflictWeakness") == 1 then player:addStatusEffect(xi.effect.WEAKNESS, 1, 3, 60 * 10) end
            player:setCharVar("DynaInflictWeakness", 0)
        if dynamis.dynaInfoEra[zoneId].csBit >= 7 then
            if os.time() > player:getCharVar("SJUnlockTime") then
                player:addStatusEffect(xi.effect.SJ_RESTRICTION, 1, 3, 0)
            end
        end

    end

    return -1
end)

xi.dynamis.spawnWave = function(mobList, waveNumber)
    local zoneId = zone:getID()
    local iStart = 4096*4096+(4096*mobList.zoneID)
    local i = iStart
    local iEnd = iStart + 1023

    if waveNumber == 1 then  
        if dynaInfoEra[zoneId].csBit > 7 and dynaInfoEra[zoneId].sjRestrictionNPC ~= nil then
            GetNPCByID(dynaInfoEra[zoneId].sjRestrictionNPC):setPos(dynamis.dynaInfoEra[zoneId].sjRestrictionLocation[math.random(1, dynamis.dynaInfoEra[zoneId].sjRestrictionNPCNumber)])
            GetNPCByID(dynaInfoEra[zoneId].sjRestrictionNPC):setStatus(xi.status.NORMAL)
        end
    end

    while i <= iEnd do
        if mobList[i].waves ~= nil and mobList[i].waves[waveNumber] ~= nil and GetMobByID(i):isSpawned() == false then SpawnMob(i) end
        i = i + 1
    end

end

xi.dynamis.statueOnSpawn = function(mob, eyes) -- Used to spawn mobs off of a single parent
    mob:setLocalVar("dynaReadyToSpawnChildren", 1)
    if mob:getFamily() >= 92 and mob:getFamily() <= 95 then
        mob:setLocalVar("eyeColor", eyes)
        if eyes >= 2 then
            mob:setUnkillable(true)
        end
    end
end

xi.dynamis.statueOnEngaged = function(mob, target, mobList)
    if mob:getFamily() >= 92 and mob:getFamily() <= 95 then
        local eyes = mob:getLocalVar("eyeColor")
        mob:AnimationSub(eyes)
    end

    if mob:getLocalVar("dynaReadyToSpawnChildren") == 0 then return end
    mob:setLocalVar("dynaReadyToSpawnChildren", 0)

    local mobID = mob:getID()
    local specificChildrenList = nil
    if mobList[mobID] ~= nil then
        specificChildrenList = mobList[mobID].specificChildren
    end

    local forceLink = false
    local i = 1
    while specificChildrenList ~= nil and specificChildrenList[i] ~= nil do
        if type(specificChildrenList[i]) == "boolean" then forceLink = specificChildrenList[i]
        else
            local child = GetMobByID(specificChildrenList[i])
            if mobList[specificChildrenList[i]].pos == nil then child:setSpawn(mob:getXPos()+math.random()*6-3, mob:getYPos()-0.3, mob:getZPos()+math.random()*6-3, mob:getRotPos()) end
            SpawnMob(specificChildrenList[i])
            if forceLink == true then child:updateEnmity(target) end
        end
        i = i + 1
    end
end

xi.dynamis.statueOnFight = function(mob, target)
    if mob:getHP() == 1 then
        if mob:AnimationSub() == 2 then
            mob:useMobAbility(1124)
        elseif mob:AnimationSub() == 3 then
            mob:useMobAbility(1125)
        end
    end
end

xi.dynamis.onStatueSkillFinished = function(mob, skill)
    if skill:getID() == 1124 or skill:getID() == 1125 then
        mob:setUnkillable(false)
        mob:setHP(0)
    end
end

xi.dynamis.mobOnRoamAction = function(mob)
    local zoneId = mob:getZoneID()
    if dynamis.dynaInfo[zoneId].updatedRoam == true then
        local home = mob:getSpawnPos()
        local location = mob:getPos()
        if location.x == home.x and location.y == home.y and location.z == home.z and location.rot == home.rot then
            mob:setPos(location.x, location.y, location.z, home.rot)
        else
            mob:pathTo(home.x, home.y, home.z)
        end
    else
        local home = mob:getSpawnPos()
        local location = mob:getPos()
        mob:pathTo(home.x, home.y, home.z)
        if location.x == home.x and location.y == home.y and location.z == home.z and location.rot ~= home.rot then
            mob:setPos(location.x, location.y, location.z, home.rot)
        end
    end
end

m:addOverride("xi.dynamis.megaBossOnDeath", function(mob, player, isKiller) 
    local zone = mob:getZoneID()
    local ID = zones[zone]
    xi.dynamis.mobOnDeath(mob, mobList[zone], ID.text.DYNAMIS_TIME_EXTEND)
    local winQM = GetNPCByID(dynaInfoEra[ID].winQM)
    local pos = mob:getPos()
    winQM:setPos(pos.x,pos.y,pos.z,pos.rot)
    winQM:setStatus(xi.status.NORMAL)
    player:addTitle(dynaInfoEra[ID].winTitle)
end)

xi.dynamis.mobOnRoamAction = function(mob)
    local zoneId = mob:getZoneID()
    if dynamis.dynaInfoEra[zoneId].updatedRoam == true then
        local home = mob:getSpawnPos()
        local location = mob:getPos()
        if location.x == home.x and location.y == home.y and location.z == home.z and location.rot == home.rot then
            mob:setPos(location.x, location.y, location.z, home.rot)
        else
            mob:pathTo(home.x, home.y, home.z)
        end
    else
        local home = mob:getSpawnPos()
        local location = mob:getPos()
        mob:pathTo(home.x, home.y, home.z)
        if location.x == home.x and location.y == home.y and location.z == home.z and location.rot ~= home.rot then
            mob:setPos(location.x, location.y, location.z, home.rot)
        end
    end
end

xi.dynamis.mobOnDeath = function (mob, mobList, msg)
    if mob:getLocalVar("dynamisMobOnDeathTriggered") == 1 then return end
    mob:setLocalVar("dynamisMobOnDeathTriggered", 1) -- onDeath lua happens once per party member that killed the mob, but we want this to only run once per mob

    local mobID = mob:getID()
    if mobID ~= nil and mobList[mobID].timeExtension ~= nil then mob:addTimeToDynamis(mobList[mobID].timeExtension, msg) end
    if mob:getLocalVar("clearSpawnPosOnDeath") == 1 then mob:setSpawn(1,1,1,0) end

    local i = 2
    local j = 1
    local mobFound = false
    while mobList.waveDefeatRequirements[i] ~= nil and mobFound == false do
        while mobList.waveDefeatRequirements[i][j] ~= nil do
            if mobList.waveDefeatRequirements[i][j] == mobID then
                mobFound = true
                i = i - 1
                break
            end
            j = j + 1
        end
        j = 1
        i = i + 1
    end

    if mobFound == true then
        -- print(string.format("mob's defeat is a requirement for wave number %u",i))
        mob:setLocalVar("dynaIsDefeatedForWaveReq", 1)
        local allReqsMet = true
        while mobList.waveDefeatRequirements[i][j] ~= nil do
            if GetMobByID(mobList.waveDefeatRequirements[i][j]):getLocalVar("dynaIsDefeatedForWaveReq") == 0 then
                allReqsMet = false
                break
            end
            j = j + 1
        end
        if allReqsMet == true then dynamis.spawnWave(mobList, i) end
    end
end

xi.dynamis.mobOnRoam = function(mob) end

m:addOverride("xi.dynamis.qmOnTrigger", function(player, npc)
    local zoneId = npc:getZoneID()
    if dynamis_win_aoe == true then -- Used to bypass normal KI mechanic which was causing issues on Topaz.
        local currTime = os.time()
        if npc:getLocalVar("lastActivation") + 5 > currTime then return end
        npc:setLocalVar("lastActivation", currTime)
        
        local nearbyPlayers = npc:getPlayersInRange(50)
        if nearbyPlayers == nil then return end -- If no players, ignore.
        local ID = zones[zoneId]
        
        for _,v in ipairs(nearbyPlayers) do -- Loop to do KI hand-outs
            if v:hasKeyItem(dynaInfoEra[zoneId].winKI) == false then
                v:addKeyItem(dynaInfoEra[zoneId].winKI)
                v:messageSpecial(ID.text.KEYITEM_OBTAINED, dynaInfoEra[zoneId].winKI)
            end
        end
    else -- Normal QM behavior
        player:addKeyItem(dynaInfoEra[zoneId].winKI)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, dynaInfoEra[zoneId].winKI)
    end
end)

xi.dynamis.sjQMOnTrigger = function(player, npc)
    local zoneId = npc:getZoneID()

    if dynamis.dynaInfoEra[zoneId].sjRestriction == true then
        for _, member in pairs(player:getAlliance()) do
            if member:getZoneID() == player:getZoneID() and member:hasStatusEffect(xi.effect.SJ_RESTRICTION) == true then
                if member:hasStatusEffect(xi.effect.RERAISE) then -- Check for reraise and store values.
                    member:setLocalVar("had_reraise", 1)
                    member:setLocalVar("reraise_power", member:getStatusEffect(xi.effect.RERAISE):getPower())
                    member:setLocalVar("reraise_duration", member:getStatusEffect(xi.effect.RERAISE):getDuration())
                end
                member:delStatusEffect(xi.effect.SJ_RESTRICTION)
                player:setCharVar("SJUnlockTime", os.time() + 14400) -- Set Immune to reobtaining SJ_Restriction for 4 hours.
                if member:getLocalVar("had_reraise") == 1 and member:hasStatusEffect(xi.effect.RERAISE) == false then -- Reapply previous reraise if lost.
                        member:addStatusEffect(xi.effect.RERAISE, member:getLocalVar("reraise_power"), 0, member:getLocalVar("reraise_duration"))
                end
            end
        end
    end
end

xi.dynamis.setMobStats = function(mob)
    local job = mob:getMainJob()

    local familyEES =
    {
        [  3] = xi.jsa.EES_AERN,    -- Aern
        [ 25] = xi.jsa.EES_ANTICA,  -- Antica
        [115] = xi.jsa.EES_SHADE,   -- Fomor
        [126] = xi.jsa.EES_GIGA,    -- Gigas
        [127] = xi.jsa.EES_GIGA,    -- Gigas
        [128] = xi.jsa.EES_GIGA,    -- Gigas
        [129] = xi.jsa.EES_GIGA,    -- Gigas
        [130] = xi.jsa.EES_GIGA,    -- Gigas
        [133] = xi.jsa.EES_GOBLIN,  -- Goblin
        [169] = xi.jsa.EES_KINDRED, -- Kindred
        [171] = xi.jsa.EES_LAMIA,   -- Lamiae
        [182] = xi.jsa.EES_MERROW,  -- Merrow
        [184] = xi.jsa.EES_GOBLIN,  -- Moblin
        [189] = xi.jsa.EES_ORC,     -- Orc
        [200] = xi.jsa.EES_QUADAV,  -- Quadav
        [201] = xi.jsa.EES_QUADAV,  -- Quadav
        [202] = xi.jsa.EES_QUADAV,  -- Quadav
        [221] = xi.jsa.EES_SHADE,   -- Shadow
        [222] = xi.jsa.EES_SHADE,   -- Shadow
        [223] = xi.jsa.EES_SHADE,   -- Shadow
        [246] = xi.jsa.EES_TROLL,   -- Troll
        [270] = xi.jsa.EES_YAGUDO,  -- Yagudo
        [327] = xi.jsa.EES_GOBLIN,  -- Goblin
        [328] = xi.jsa.EES_GIGA,    -- Gigas
        [334] = xi.jsa.EES_ORC,     -- OrcNM
        [335] = xi.jsa.EES_MAAT,    -- Maat
        [337] = xi.jsa.EES_QUADAV,  -- QuadavNM
        [358] = xi.jsa.EES_KINDRED, -- Kindred
        [359] = xi.jsa.EES_SHADE,   -- Fomor
        [360] = xi.jsa.EES_YAGUDO,  -- YagudoNM
        [373] = xi.jsa.EES_GOBLIN,  -- Goblin_Armored
    }

    mob:setMaxHPP(132)
    mob:setMobType(MOBTYPE_NORMAL)
    mob:setMobLevel(math.random(78,80))
    mob:setTrueDetection(1)

    if     job == xi.job.WAR then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.MIGHTY_STRIKES
        params.specials.skill.hpp = math.random(55,80)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.MNK then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.HUNDRED_FISTS
        params.specials.skill.hpp = math.random(55,70)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.WHM then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.BENEDICTION
        params.specials.skill.hpp = math.random(40,60)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.BLM then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.MANAFONT
        params.specials.skill.hpp = math.random(55,80)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.RDM then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.CHAINSPELL
        params.specials.skill.hpp = math.random(55,80)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.THF then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.PERFECT_DODGE
        params.specials.skill.hpp = math.random(55,75)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.PLD then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.INVINCIBLE
        params.specials.skill.hpp = math.random(55,75)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.DRK then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.BLOOD_WEAPON
        params.specials.skill.hpp = math.random(55,75)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.BST then
    elseif job == xi.job.BRD then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.SOUL_VOICE
        params.specials.skill.hpp = math.random(55,80)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.RNG then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = familyEES[mob:getFamily()]
        params.specials.skill.hpp = math.random(55,75)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.SAM then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.MEIKYO_SHISUI
        params.specials.skill.hpp = math.random(55,80)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.NIN then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.MIJIN_GAKURE
        params.specials.skill.hpp = math.random(25,35)
        xi.mix.jobSpecial.config(mob, params)
    elseif job == xi.job.DRG then
    elseif job == xi.job.SMN then
    end

    -- Add Check After Calcs
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 2)

end

xi.dynamis.setNMStats = function(mob)
    local job = mob:getMainJob()

    mob:setMobType(MOBTYPE_NOTORIOUS)
    mob:setMaxHPP(132)
    mob:setMobLevel(math.random(80,82))
    mob:setMod(xi.mod.STR, -15)
    mob:setMod(xi.mod.VIT, -5)
    mob:setTrueDetection(1)

    if job == xi.job.NIN then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = xi.jsa.MIJIN_GAKURE
        params.specials.skill.hpp = math.random(15,25)
        xi.mix.jobSpecial.config(mob, params)
    end
end

xi.dynamis.setStatueStats = function(mob)
    mob:setMobType(MOBTYPE_NOTORIOUS)
    mob:setMobLevel(math.random(82,84))
    mob:setMod(xi.mod.STR, -5)
    mob:setMod(xi.mod.VIT, -5)
    mob:setMod(xi.mod.DMGMAGIC, -50)
    mob:setMod(xi.mod.DMGPHYS, -50)
    mob:setTrueDetection(1)
    -- Disabling WHM job trait mods because their job is set to WHM in the DB.
    mob:setMod(xi.mod.MDEF, 0)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.MPHEAL, 0)
end

xi.dynamis.setMegaBossStats = function(mob)
    mob:setMobType(MOBTYPE_NOTORIOUS)
    mob:setMobLevel(88)
    mob:setMod(xi.mod.STR, -10)
    mob:setTrueDetection(1)
end

xi.dynamis.setPetStats = function(mob)
    mob:setMobLevel(78)
    mob:setMod(xi.mod.STR, -40)
    mob:setMod(xi.mod.INT, -30)
    mob:setMod(xi.mod.VIT, -20)
    mob:setMod(xi.mod.RATTP, -20)
    mob:setMod(xi.mod.ATTP, -20)
    mob:setMod(xi.mod.DEFP, -5)
    mob:setTrueDetection(1)
end

xi.dynamis.setAnimatedWeaponStats = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.HP_HEAL_CHANCE, 90)
    mob:setMod(xi.mod.STUNRESTRAIT, 75)
    mob:setMod(xi.mod.PARALYZERESTRAIT, 100)
    mob:setMod(xi.mod.SLOWRESTRAIT, 100)
    mob:setMod(xi.mod.SILENCERESTRAIT, 100)
    mob:setMod(xi.mod.LULLABYRESTRAIT, 100)
    mob:setMod(xi.mod.SLEEPRESTRAIT, 100)
end

xi.dynamis.setEyeStats = function(mob)
    mob:setMobType(MOBTYPE_NOTORIOUS)
    mob:setMobLevel(math.random(82,84))
    mob:setMod(xi.mod.DEF, 420)
    mob:addMod(xi.mod.MDEF, 150)
    mob:addMod(xi.mod.DMGMAGIC, -25)
end

-- Disable Base LSB Additional Functions
m:addOverride("xi.dynamis.zoneOnInitialize", function(zone) end)
m:addOverride("xi.dynamis.somnialThresholdOnTrigger", function(player,npc) end)
m:addOverride("xi.dynamis.somnialThresholdOnEventFinish", function(player,npc) end)
m:addOverride("xi.dynamis.timeExtensionOnDeath", function(mob, player, isKiller) end)
m:addOverride("xi.dynamis.refillStatueOnSpawn", function(mob) end)
m:addOverride("xi.dynamis.refillStatueOnSDeath", function(mob, player, isKiller) end)
m:addOverride("xi.dynamis.qmOnTrade", function(player, npc, trade) end) -- Not used...  Era Dynamis does not have QM pops.
m:addOverride("xi.dynamis.getExtensions", function(player) end)
