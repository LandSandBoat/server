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
xi = xi or {}
xi.dynamis = xi.dynamis or {}

--------------------------------------------
--        Global Dynamis Variables        --
--------------------------------------------
local dynamis_timeless = 4236
local dynamis_perpetual = 4237
local dynamis_min_lvl = 65
local dynamis_reservation_cancel = 180
local dynamis_reentry_days = 3
local dynamis_rentry_hours = 71

local entryInfo =
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
        hasEnteredVar = "DynaSandoria_HasEntered",
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
        hasEnteredVar = "DynaBastok_HasEntered",
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
        hasEnteredVar = "DynaWindurst_HasEntered",
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
        hasEnteredVar = "DynaJeuno_HasEntered",
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
        hasEnteredVar = "DynaBeaucedine_HasEntered",
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
        hasEnteredVar = "DynaXarcabard_HasEntered",
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
        hasEnteredVar = "DynaValkurm_HasEntered",
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
        hasEnteredVar = "DynaBuburimu_HasEntered",
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
        hasEnteredVar = "DynaQufim_HasEntered",
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
        hasEnteredVar = "DynaTavnazia_HasEntered",
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

local dynaInfo =
{
        --[[
    [zone] =
    {
        winVar = Variable for the Win Condition
        hasEnteredVar = Variable for Previous Entry
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
        hasEnteredVar = "DynaSandoria_HasEntered",
        hasSeenWinCSVar = "DynaSandoria_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_COMMAND_SCEPTER,
        winTitle = xi.title.DYNAMIS_SAN_DORIA_INTERLOPER,
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
        hasEnteredVar = "DynaBastok_HasEntered",
        hasSeenWinCSVar = "DynaBastok_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_EYEGLASS,
        winTitle = xi.title.DYNAMIS_BASTOK_INTERLOPER,
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
        hasEnteredVar = "DynaWindurst_HasEntered",
        hasSeenWinCSVar = "DynaWindurst_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_LANTERN,
        winTitle = xi.title.DYNAMIS_WINDURST_INTERLOPER,
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
        hasEnteredVar = "DynaJeuno_HasEntered",
        hasSeenWinCSVar = "DynaJeuno_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_TACTICAL_MAP,
        winTitle = xi.title.DYNAMIS_JEUNO_INTERLOPER,
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
        hasEnteredVar = "DynaBeaucedine_HasEntered",
        hasSeenWinCSVar = "DynaBeaucedine_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_INSIGNIA,
        winTitle = xi.title.DYNAMIS_BEAUCEDINE_INTERLOPER,
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
        hasEnteredVar = "DynaXarcabard_HasEntered",
        hasSeenWinCSVar = "DynaXarcabard_HasSeenWinCS",
        winKI = xi.ki.HYDRA_CORPS_BATTLE_STANDARD,
        winTitle = xi.title.DYNAMIS_XARCABARD_INTERLOPER,
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
        hasEnteredVar = "DynaValkurm_HasEntered",
        hasSeenWinCSVar = "DynaValkurm_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_VALKURM_SLIVER,
        winTitle = xi.title.DYNAMIS_VALKURM_INTERLOPER,
        entryPos = {100, -8, 131, 47, xi.zone.DYNAMIS_VALKURM},
        ejectPos = {119, -9, 131, 52, xi.zone.VALKURM_DUNES},
        sjRestriction = true,
    },
    [xi.zone.VALKURM_DUNES] =
    {
        dynaZone = xi.zone.DYNAMIS_VALKURM,
        dynaZoneMessageParam = 7,
    },
    [xi.zone.DYNAMIS_BUBURIMU] =
    {
        winVar = "DynaBuburimu_Win",
        hasEnteredVar = "DynaBuburimu_HasEntered",
        hasSeenWinCSVar = "DynaBuburimu_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_BUBURIMU_SLIVER,
        winTitle = xi.title.DYNAMIS_BUBURIMU_INTERLOPER,
        entryPos = {155, -1, -169, 170, xi.zone.DYNAMIS_BUBURIMU},
        ejectPos = {154, -1, -170, 190, xi.zone.BUBURIMU_PENINSULA},
        sjRestriction = true,
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
        hasEnteredVar = "DynaQufim_HasEntered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_QUFIM_SLIVER,
        winTitle = xi.title.DYNAMIS_QUFIM_INTERLOPER,
        entryPos = {-19, -17, 104, 253, xi.zone.DYNAMIS_QUFIM},
        ejectPos = { 18, -19, 162, 240, xi.zone.QUFIM_ISLAND},
        sjRestriction = true,
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
        hasEnteredVar = "DynaTavnazia_HasEntered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = xi.ki.DYNAMIS_TAVNAZIA_SLIVER,
        winTitle = xi.title.DYNAMIS_TAVNAZIA_INTERLOPER,
        entryPos = {0.1, -7, -21, 190, xi.zone.DYNAMIS_TAVNAZIA},
        ejectPos = {0  , -7, -23, 195, xi.zone.TAVNAZIAN_SAFEHOLD},
    },
    [xi.zone.TAVNAZIAN_SAFEHOLD] =
    {
        dynaZone = xi.zone.DYNAMIS_TAVNAZIA,
        dynaZoneMessageParam = 10,
    },

}

dynamis.eyes =
{
    NONE    = 0,
    RED     = 1,
    BLUE    = 2,
    GREEN   = 3,
}

xi.dynamis.entryNpcOnTrade = function(player, npc, trade, message_not_reached_level, message_another_group, message_cannot_enter)
    local zoneID = player:getZoneID()
    if entryInfo[zoneID].enabled == false then return end -- If zone is not enabled, return.
    if (player:getLocalVar(entryInfo[zoneID].hasEnteredVar) == 0) then -- Check if player has entered the Dynamis before.
    if (entryInfo[zoneID].reqs == false) then return end end -- Check if player meets all requirements or is a GM.

    local remaining = GetDynaTimeRemaining(entryInfo[zoneID].enterPos[5])
    local hasEntered = player:getCharVar(entryInfo[zoneID].hasEnteredVar)
    local timeSinceLastDynaReservation = player:timeSinceLastDynaReservation()


    if npcUtil.tradeHas(trade, dynamis_timeless, true, false) then -- timeless hourglass, attempting to trade for a perpetual hourglass
        if remaining > 0 then
            player:messageSpecial(message_another_group, entryInfo[zoneID].csBit)
        elseif timeSinceLastDynaReservation < dynamis_rentry_hours then
            player:messageSpecial(message_cannot_enter, dynamis_rentry_hours-timeSinceLastDynaReservation, xi.dynamis.entryInfo[zoneID].csBit)
        else
            player:startEvent(xi.dynamis.entryInfo[zoneID].csRegisterGlass,xi.dynamis.entryInfo[zoneID].csBit,hasEntered == 1 and 0 or 1,xi.dynamis.reservation_cancel,xi.dynamis.reentry_days,xi.dynamis.maxchars,xi.ki.VIAL_OF_SHROUDED_SAND,xi.dynamis.timeless,xi.dynamis.perpetual)
        end
    elseif npcUtil.tradeHas(trade, xi.dynamis.perpetual, true, false) then -- perpetual hourglass, attempting to enter a registered instance or start a new one
        local hgValid = player:checkHourglassValid(trade:getItem(0), xi.dynamis.entryInfo[zoneID].enterPos[5])
        if hgValid > 0 then -- 0 = can't enter (wrong glass or didn't wait 71 hours since last dynamis), 1 = entering, 2 = re-entering (weakness)
            player:prepareDynamisEntry(trade:getItem(0), hgValid) -- save the hourglass's params to the character while they are viewing the cs
            player:startEvent(xi.dynamis.entryInfo[zoneID].csDyna,xi.dynamis.entryInfo[zoneID].csBit,hasEntered == 1 and 0 or 1,xi.dynamis.reservation_cancel,xi.dynamis.reentry_days,xi.dynamis.maxchars,xi.ki.VIAL_OF_SHROUDED_SAND,xi.dynamis.timeless,xi.dynamis.perpetual)
        elseif timeSinceLastDynaReservation < 71 then
            player:messageSpecial(message_cannot_enter, 71-timeSinceLastDynaReservation, xi.dynamis.entryInfo[zoneID].csBit)
        elseif remaining > 0 then
            player:messageSpecial(message_another_group, xi.dynamis.entryInfo[zoneID].csBit)
        else
            player:PrintToPlayer("The Perpetual Hourglass' time has run out.", 29)
        end
    end
end

xi.dynamis.entryNpcOnTrigger = function(player, npc, message_default)
    local zoneID = player:getZoneID()
    if xi.dynamis.entryInfo[zoneID].enabled == false then
        player:messageSpecial(message_default)
        return
    end
    if xi.dynamis.entryInfo[zoneID].csSand ~= nil and player:getCharVar("HasSeenXarcabardDynamisCS") == 1 and player:hasKeyItem(xi.ki.VIAL_OF_SHROUDED_SAND) == false then
        player:startEvent(xi.dynamis.entryInfo[zoneID].csSand)
    elseif xi.dynamis.entryInfo[zoneID].csWin ~= nil and player:hasKeyItem(xi.dynamis.entryInfo[zoneID].winKI) and player:getCharVar(xi.dynamis.entryInfo[zoneID].hasSeenWinCSVar) == 0 then
        player:startEvent(xi.dynamis.entryInfo[zoneID].csWin)
    else

        player:messageSpecial(message_default)
    end
end

xi.dynamis.entryNpcOnEventUpdate = function(player, csid, option, message_unable_to_connect)
    local zoneID = player:getZoneID()
    if xi.dynamis.entryInfo[zoneID].enabled == false then return end
    if csid == xi.dynamis.entryInfo[zoneID].csRegisterGlass then -- trade out timeless hourglass for a perpetual hourglass
        -- Do not proceed until we know the Dynamis server is up.
        -- This will prevent us from deleting the expensive hourglass
        -- if we cannot provide the service
        if option == 0 then
            player:setCharVar("DynaPrep_zoneid", xi.dynamis.entryInfo[zoneID].enterPos[5])
            player:setLocalVar("DynamisWaitingForServer", 1)
            player:pingDynamis()
            player:queue(5000, function(player)
                if player:getLocalVar("DynamisWaitingForServer") ~= 0 then
                    player:setLocalVar("DynamisWaitingForServer", 0)
                    player:release()
                    player:messageSpecial(message_unable_to_connect, xi.dynamis.entryInfo[zoneID].csBit)
                end
            end)
        else
            player:release()
        end
    end
end

xi.dynamis.entryNpcOnEventFinish = function(player, csid, option, message_connecting_with_the_server, message_unable_to_connect)
    local zoneID = player:getZoneID()
    if xi.dynamis.entryInfo[zoneID].enabled == false then return end
    if csid == xi.dynamis.entryInfo[zoneID].csDyna then -- enter dynamis
        if option == 0 then
            -- Will call onDynamisServerReply async when the server replies
            player:setLocalVar("DynamisWaitingForServer", 1)
            player:registerDynamis()
            -- In case the Dynamis server failed notify the player
            player:messageSpecial(message_connecting_with_the_server, xi.dynamis.entryInfo[zoneID].csBit)
            player:queue(5000, function(player)
                if player:getLocalVar("DynamisWaitingForServer") ~= 0 then
                    player:setLocalVar("DynamisWaitingForServer", 0)
                    player:messageSpecial(message_unable_to_connect, xi.dynamis.entryInfo[zoneID].csBit)
                    player:queue(1000, function(player)
                        player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
                    end)
                end
            end)
        end
    elseif csid == xi.dynamis.entryInfo[zoneID].csSand then -- get shrouded sand
        npcUtil.giveKeyItem(player, xi.ki.VIAL_OF_SHROUDED_SAND)
    elseif csid == xi.dynamis.entryInfo[zoneID].csWin then -- just saw win cs
        player:setCharVar(xi.dynamis.entryInfo[zoneID].hasSeenWinCSVar, 1)
    end
end

xi.dynamis.entryNpcOnDynamisServerReply = function(player, result, message_information_recorded, message_obtained, message_another_group)
    local zoneID = player:getZoneID()
    if xi.dynamis.entryInfo[zoneID].enabled == false then return end
    player:setLocalVar("DynamisWaitingForServer", 0)
    if result == 2 then
        -- Ping response when trading timeless hourglass
        player:release()
        if player:registerHourglass(xi.dynamis.entryInfo[zoneID].enterPos[5]) == true then
            trade = player:getCurrentTrade()
            if trade ~= nil and npcUtil.tradeHasExactly(trade, dynamis.timeless) then
                player:confirmTrade()
                player:messageSpecial(message_information_recorded, dynamis.perpetual)
                player:messageSpecial(message_obtained, dynamis.perpetual)
            end
        end
    elseif result == 1 then
        -- Entry when trading perpetual hourglass
        local entryPos = xi.dynamis.entryInfo[zoneID].enterPos
        if entryPos == nil then return end
        player:setCharVar(xi.dynamis.entryInfo[zoneID].hasEnteredVar, 1)
        player:setPos(entryPos[1], entryPos[2], entryPos[3], entryPos[4], entryPos[5])
    elseif result == 3 then
        player:messageSpecial(message_another_group, xi.dynamis.entryInfo[zoneID].csBit)
        player:queue(1000, function(player)
            player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
        end)
    else
        player:PrintToPlayer("The Dynamis instance has reached its maximum capacity of 64 registrants.", 29)
        player:queue(1000, function(player)
            player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
        end)
    end
end

dynamis.zoneOnInitialize = function(zone)
    local zoneId = zone:getID()
    if dynamis.dynaInfo[zoneId].sjRestriction == true and dynamis.dynaInfo[zoneId].sjRestrictionNPC ~= nil then
        local sjRestrictionNPC = GetNPCByID(dynamis.dynaInfo[zoneId].sjRestrictionNPC)
        local pos = dynamis.dynaInfo[zoneId].sjRestrictionLocation[math.random(1, dynamis.dynaInfo[zoneId].sjRestrictionNPCNumber)]
        sjRestrictionNPC:setPos(pos)
        sjRestrictionNPC:setStatus(xi.status.NORMAL)
    end
end

dynamis.zoneOnZoneIn = function(player, prevZone)
    local zoneId = player:getZoneID()
    local info = dynamis.dynaInfo[zoneId]
    local ID = zones[zoneId]

    -- usually happens when zoning in with !zone command
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then player:setPos(info.entryPos[1],info.entryPos[2],info.entryPos[3],info.entryPos[4]) end

    if player:verifyHoldsValidHourglass() == true then
        player:updateHourglassExpireTime()
        player:timer(1000, function(player)
            player:messageSpecial(ID.text.DYNAMIS_TIME_UPDATE_2, math.floor(GetDynaTimeRemaining(zoneId)/60), 1)
            if player:dynaCurrencyAutoDropEnabled() == true then player:PrintToPlayer("As the original registrant of this instance, Dynamis currencies will auto-drop to you when possible (use !currency to opt out).",29) end
        end)
        if player:getCharVar("DynaInflictWeakness") == 1 then player:addStatusEffect(xi.effect.WEAKNESS, 1, 3, 60*10) end
            player:setCharVar("DynaInflictWeakness", 0)
        if dynamis.dynaInfo[zoneId].sjRestriction == true then
            if os.time() > player:getCharVar("SJUnlockTime") then
                player:addStatusEffect(xi.effect.SJ_RESTRICTION, 1, 3, 0)
            end
        end

    end

    return -1
end

dynamis.spawnWave = function(mobList, waveNumber)
    local iStart = 4096*4096+(4096*mobList.zoneID)
    local i = iStart
    local iEnd = iStart + 1023

    while i <= iEnd do
        if mobList[i] ~= nil and mobList[i].waves ~= nil and mobList[i].waves[waveNumber] ~= nil and GetMobByID(i):isSpawned() == false then SpawnMob(i) end
        i = i + 1
    end
end

dynamis.statueOnSpawn = function(mob, eyes) -- says statue but this is also called by anything that spawn children mobs (like ahriman)
    mob:setLocalVar("dynaReadyToSpawnChildren", 1)
    if mob:getFamily() >= 92 and mob:getFamily() <= 95 then
        mob:setLocalVar("eyeColor", eyes)
        if eyes >= 2 then
            mob:setUnkillable(true)
        end
    end
end

dynamis.statueOnDeath = function(mob, player, isKiller)
end

dynamis.statueOnEngaged = function(mob, target, mobList, randomChildrenList)
    local zoneId = mob:getZoneID()
    if mob:getFamily() >= 92 and mob:getFamily() <= 95 then
        local eyes = mob:getLocalVar("eyeColor")
        mob:AnimationSub(eyes)
    end

    if mob:getLocalVar("dynaReadyToSpawnChildren") == 0 then return end
    mob:setLocalVar("dynaReadyToSpawnChildren", 0)

    local mobID = mob:getID()
    local specificChildrenList = nil
    local randomChildrenCount = nil
    if mobList[mobID] ~= nil then
        randomChildrenCount = mobList[mobID].randomChildrenCount
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
    i = 1
    if dynamis.dynaInfo[zoneId].specifiedChildren == true then
        while randomChildrenList[randomChildrenCount] ~= nil and randomChildrenCount ~= nil and randomChildrenCount > 0 do
            local originalRoll = math.random(1,#randomChildrenList[randomChildrenCount])
            local roll = originalRoll
            while GetMobByID(randomChildrenList[randomChildrenCount][roll]):isSpawned() == true and roll ~= nil do
                roll = roll + 1
                if roll > #randomChildrenList[randomChildrenCount] then roll = 1 end
                if roll == originalRoll then roll = nil end
            end
            if roll ~= nil then
                local child = GetMobByID(randomChildrenList[randomChildrenCount][roll])
                local home = child:getSpawnPos()
                local randomSpawn = false
                if home.x == 1 and home.y == 1 and home.z == 1 then
                    child:setSpawn(mob:getXPos()+math.random()*6-3, mob:getYPos()-0.3, mob:getZPos()+math.random()*6-3, mob:getRotPos())
                    randomSpawn = true
                end
                SpawnMob(randomChildrenList[randomChildrenCount][roll]):updateEnmity(target)
                if randomSpawn == true then child:setLocalVar("clearSpawnPosOnDeath", 1) end
            else
                break
            end
            randomChildrenCount = randomChildrenCount - 1
        end
    else
        while randomChildrenList ~= nil and randomChildrenCount ~= nil and randomChildrenCount > 0 do
            local originalRoll = math.random(1,#randomChildrenList)
            local roll = originalRoll
            while GetMobByID(randomChildrenList[roll]):isSpawned() == true and roll ~= nil do
                roll = roll + 1
                if roll > #randomChildrenList then roll = 1 end
                if roll == originalRoll then roll = nil end
            end
            if roll ~= nil then
                local child = GetMobByID(randomChildrenList[roll])
                local home = child:getSpawnPos()
                local randomSpawn = false
                if home.x == 1 and home.y == 1 and home.z == 1 then
                    child:setSpawn(mob:getXPos()+math.random()*6-3, mob:getYPos()-0.3, mob:getZPos()+math.random()*6-3, mob:getRotPos())
                    randomSpawn = true
                end
                SpawnMob(randomChildrenList[roll]):updateEnmity(target)
                if randomSpawn == true then child:setLocalVar("clearSpawnPosOnDeath", 1) end
            else
                break
            end
            randomChildrenCount = randomChildrenCount - 1
        end
    end
end

dynamis.mobOnRoamAction = function(mob)
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

dynamis.mobOnDeath = function (mob, mobList, msg)
    if mob:getLocalVar("dynamisMobOnDeathTriggered") == 1 then return end
    mob:setLocalVar("dynamisMobOnDeathTriggered", 1) -- onDeath lua happens once per party member that killed the mob, but we want this to only run once per mob

    local mobID = mob:getID()
    if mobList[mobID] ~= nil and mobList[mobID].timeExtension ~= nil then mob:addTimeToDynamis(mobList[mobID].timeExtension, msg) end
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
    -- miniWave is used when the same mobID needs to be used twice for a waveDefeatRequirement
    local mobID = mob:getID()
    local miniWave = nil
    if mobList[mobID] ~= nil then
        miniWave = mobList[mobID].miniWave
    end
    local forceLink = false
    local i = 1
    local target = mob:getTarget()

    while miniWave ~= nil and miniWave[i] ~= nil do
        if type(miniWave[i]) == "boolean" then forceLink = miniWave[i]
        else
            local child = GetMobByID(miniWave[i])
            if mobList[miniWave[i]].pos == nil then child:setSpawn(mob:getXPos()+math.random()*6-3, mob:getYPos()-0.3, mob:getZPos()+math.random()*6-3, mob:getRotPos()) end
            SpawnMob(miniWave[i])
            if forceLink == true then child:updateEnmity(target) end
        end
        i = i + 1
    end
end

dynamis.mobOnRoam = function(mob)

end

dynamis.qmOnTrade = function(player, npc, trade) -- i think this is for Xarcabard, so remember to update this once we start work on that
    local npcId = npc:getID()
    local zoneId = npc:getZoneID()
    local ID = zones[zoneId]
    local QM = ID.npc.QM

    if QM then
        local info = QM[npcId]

        if info then
            for _, v in pairs(info.trade) do
                if npcUtil.tradeHasExactly(trade, v.item) then
                    local mobId
                    if type(v.mob) == "table" then
                        mobId = v.mob[math.random(#v.mob)]
                    else
                        mobId = v.mob
                    end
                    if mobId and npcUtil.popFromQM(player, npc, mobId, {hide = 0, radius = 2}) then
                        player:confirmTrade()
                    end
                    break
                end
            end
        else
            printf("[dynamis.qmOnTrade] called on in zone %i on npc %i (%s) that does not appear in QM data.", zoneId, npcId, npc:getName())
        end
    else
        printf("[dynamis.qmOnTrade] called on npc %i (%s) in zone %i that does not have a QM group in its IDs.", npcId, npc:getName(), zoneId)
    end
end

dynamis.qmOnTrigger = function(player, npc)
    local npcId = npc:getID()
    local zoneId = npc:getZoneID()
    local ID = zones[zoneId]
    local QM = ID.npc.QM

    if QM then
        local info = QM[npcId]

        if info then
            if info.param then
                player:startEvent(102, unpack(info.param))
            elseif info.trade and #info.trade == 1 and info.trade[1].item and type(info.trade[1].item) == "number" and ID.text.OMINOUS_PRESENCE then
                player:messageSpecial(ID.text.OMINOUS_PRESENCE, info.trade[1].item)
            end
        else
            printf("[dynamis.qmOnTrigger] called on in zone %i on npc %i (%s) that does not appear in QM data.", zoneId, npcId, npc:getName())
        end
    else
        printf("[dynamis.qmOnTrigger] called on npc %i (%s) in zone %i that does not have a QM group in its IDs.", npcId, npc:getName(), zoneId)
    end
end

dynamis.sjQMOnTrigger = function(player, npc)
    local zoneId = npc:getZoneID()

    if dynamis.dynaInfo[zoneId].sjRestriction == true then
        for _, member in pairs(player:getAlliance()) do
            if member:getZoneID() == player:getZoneID() then
                if member:hasStatusEffect(xi.effect.SJ_RESTRICTION) then
                    if member:hasStatusEffect(xi.effect.RERAISE) then -- Check for reraise and store values.
                        member:setLocalVar("had_reraise", 1)
                        member:setLocalVar("reraise_power", member:getStatusEffect(xi.effect.RERAISE):getPower())
                        member:setLocalVar("reraise_duration", member:getStatusEffect(xi.effect.RERAISE):getDuration())
                    end
                    member:delStatusEffect(xi.effect.SJ_RESTRICTION)
                    player:setCharVar("SJUnlockTime", os.time() + 14400) -- Set Immune to reobtaining SJ_Restriction for 4 hours.
                    if member:getLocalVar("had_reraise") == 1 then -- Reapply previous reraise if lost.
                        if not member:hasStatusEffect(xi.effect.RERAISE) then
                            member:addStatusEffect(xi.effect.RERAISE, member:getLocalVar("reraise_power"), 0, member:getLocalVar("reraise_duration"))
                        end
                    end
                end
            end
        end
    end
end

dynamis.setMobStats = function(mob)
    local job = mob:getMainJob()

    mob:setMaxHPP(132)
    mob:setMobType(MOBTYPE_NORMAL)
    mob:setMobLevel(math.random(78,80))
    mob:setTrueDetection(1)

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

dynamis.setNMStats = function(mob)
    local job = mob:getMainJob()
    local zone = mob:getZoneID()

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

dynamis.setStatueStats = function(mob)
    local job = mob:getMainJob()
    local zone = mob:getZoneID()

    mob:setMobType(MOBTYPE_NOTORIOUS)
    mob:setMobLevel(math.random(82,84))
    mob:setMod(xi.mod.STR, -5)
    mob:setMod(xi.mod.VIT, -5)

    mob:setMod(xi.mod.DMGMAGIC, -50)
    mob:setMod(xi.mod.DMGPHYS, -50)

    -- Disabling WHM job trait mods because their job is set to WHM in the DB.
    mob:setMod(xi.mod.MDEF, 0)
    mob:setMod(xi.mod.REGEN, 0)
    mob:setMod(xi.mod.MPHEAL, 0)

    mob:setTrueDetection(1)

end

dynamis.setMegaBossStats = function(mob)
    local job = mob:getMainJob()
    local zone = mob:getZoneID()

    mob:setMobType(MOBTYPE_NOTORIOUS)
    mob:setMobLevel(88)
    mob:setMod(xi.mod.STR, -10)
    mob:setTrueDetection(1)

end

dynamis.setPetStats = function(mob)
    local zone = mob:getZoneID()

    mob:setMobLevel(78)
    mob:setMod(xi.mod.STR, -40)
    mob:setMod(xi.mod.INT, -30)
    mob:setMod(xi.mod.VIT, -20)
    mob:setMod(xi.mod.RATTP, -20)
    mob:setMod(xi.mod.ATTP, -20)
    mob:setMod(xi.mod.DEFP, -5)
    mob:setTrueDetection(1)

end

dynamis.setAnimatedWeaponStats = function(mob)
    local job = mob:getMainJob()
    local zone = mob:getZoneID()

    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.HP_HEAL_CHANCE, 90)
    mob:setMod(xi.mod.STUNRESTRAIT, 75)
    mob:setMod(xi.mod.PARALYZERESTRAIT, 100)
    mob:setMod(xi.mod.SLOWRESTRAIT, 100)
    mob:setMod(xi.mod.SILENCERESTRAIT, 100)
    mob:setMod(xi.mod.LULLABYRESTRAIT, 100)
    mob:setMod(xi.mod.SLEEPRESTRAIT, 100)

end

dynamis.setEyeStats = function(mob)
    local job = mob:getMainJob()
    local zone = mob:getZoneID()

    mob:setMobType(MOBTYPE_NOTORIOUS)
    mob:setMobLevel(math.random(82,84))
    mob:setMod(xi.mod.DEF, 420)
    mob:addMod(xi.mod.MDEF, 150)
    mob:addMod(xi.mod.DMGMAGIC, -25)

end

--------------------------------------------------
-- getDynamisMapList
-- Produces a bitmask for the goblin ancient currency NPCs
--------------------------------------------------

function getDynamisMapList(player)
    local bitmask = 0
    if (player:hasKeyItem(xi.ki.MAP_OF_DYNAMIS_SANDORIA) == true) then
        bitmask = bitmask + 2
    end
    if (player:hasKeyItem(xi.ki.MAP_OF_DYNAMIS_BASTOK) == true) then
        bitmask = bitmask + 4
    end
    if (player:hasKeyItem(xi.ki.MAP_OF_DYNAMIS_WINDURST) == true) then
        bitmask = bitmask + 8
    end
    if (player:hasKeyItem(xi.ki.MAP_OF_DYNAMIS_JEUNO) == true) then
        bitmask = bitmask + 16
    end
    if (player:hasKeyItem(xi.ki.MAP_OF_DYNAMIS_BEAUCEDINE) == true) then
        bitmask = bitmask + 32
    end
    if (player:hasKeyItem(xi.ki.MAP_OF_DYNAMIS_XARCABARD) == true) then
        bitmask = bitmask + 64
    end
    if (player:hasKeyItem(xi.ki.MAP_OF_DYNAMIS_VALKURM) == true) then
        bitmask = bitmask + 128
    end
    if (player:hasKeyItem(xi.ki.MAP_OF_DYNAMIS_BUBURIMU) == true) then
        bitmask = bitmask + 256
    end
    if (player:hasKeyItem(xi.ki.MAP_OF_DYNAMIS_QUFIM) == true) then
        bitmask = bitmask + 512
    end
    if (player:hasKeyItem(xi.ki.MAP_OF_DYNAMIS_TAVNAZIA) == true) then
        bitmask = bitmask + 1024
    end

    return bitmask
end
