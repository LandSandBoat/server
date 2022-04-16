------------------------------------
-- Dynamis
------------------------------------
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
------------------------------------

dynamis = {}

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

-- todo, just put me in dynaInfo
dynamis.entryInfo =
{
    [tpz.zone.SOUTHERN_SAN_DORIA] =
    {
        csBit = 1,
        csRegisterGlass = 184,
        csSand = 686,
        csWin = 698,
        csDyna = 685,
        enabled = true,
        winVar = "DynaSandoria_Win",
        hasEnteredVar = "DynaSandoria_HasEntered",
        hasSeenWinCSVar = "DynaSandoria_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_COMMAND_SCEPTER,
        enterPos = {161.838, -2.000, 161.673, 93, 185},
        reqs = {tpz.ki.VIAL_OF_SHROUDED_SAND}
    },
    [tpz.zone.BASTOK_MINES] =
    {
        csBit = 2,
        csRegisterGlass = 200,
        csSand = 203,
        csWin = 215,
        csDyna = 201,
        enabled = true,
        winVar = "DynaBastok_Win",
        hasEnteredVar = "DynaBastok_HasEntered",
        hasSeenWinCSVar = "DynaBastok_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_EYEGLASS,
        enterPos = {116.482, 0.994, -72.121, 128, 186},
        reqs = {tpz.ki.VIAL_OF_SHROUDED_SAND}
    },
    [tpz.zone.WINDURST_WALLS] =
    {
        csBit = 3,
        csRegisterGlass = 451,
        csSand = 455,
        csWin = 465,
        csDyna = 452,
        enabled = true,
        winVar = "DynaWindurst_Win",
        hasEnteredVar = "DynaWindurst_HasEntered",
        hasSeenWinCSVar = "DynaWindurst_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_LANTERN,
        enterPos = {-221.988, 1.000, -120.184, 0, 187},
        reqs = {tpz.ki.VIAL_OF_SHROUDED_SAND}
    },
    [tpz.zone.RULUDE_GARDENS] =
    {
        csBit = 4,
        csRegisterGlass = 10011,
        csSand = 10016,
        csWin = 10026,
        csDyna = 10012,
        enabled = true,
        winVar = "DynaJeuno_Win",
        hasEnteredVar = "DynaJeuno_HasEntered",
        hasSeenWinCSVar = "DynaJeuno_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_TACTICAL_MAP,
        enterPos = {48.930, 10.002, -71.032, 195, 188},
        reqs = {tpz.ki.VIAL_OF_SHROUDED_SAND}
    },
    [tpz.zone.BEAUCEDINE_GLACIER] =
    {
        csBit = 5,
        csRegisterGlass = 118,
        csWin = 134,
        csDyna = 119,
        enabled = true,
        winVar = "DynaBeaucedine_Win",
        hasEnteredVar = "DynaBeaucedine_HasEntered",
        hasSeenWinCSVar = "DynaBeaucedine_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_INSIGNIA,
        enterPos = {-284.751, -39.923, -422.948, 235, 134},
        reqs =
                {tpz.ki.VIAL_OF_SHROUDED_SAND,
                tpz.ki.HYDRA_CORPS_COMMAND_SCEPTER,
                tpz.ki.HYDRA_CORPS_EYEGLASS,
                tpz.ki.HYDRA_CORPS_LANTERN,
                tpz.ki.HYDRA_CORPS_TACTICAL_MAP}
    },
    [tpz.zone.XARCABARD] =
    {
        csBit = 6,
        csRegisterGlass = 15,
        csWin = 32,
        csDyna = 16,
        enabled = true,
        winVar = "DynaXarcabard_Win",
        hasEnteredVar = "DynaXarcabard_HasEntered",
        hasSeenWinCSVar = "DynaXarcabard_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_BATTLE_STANDARD,
        enterPos = {569.312, -0.098, -270.158, 90, 135},
        reqs =
               {tpz.ki.VIAL_OF_SHROUDED_SAND,
                tpz.ki.HYDRA_CORPS_INSIGNIA}

    },
    [tpz.zone.VALKURM_DUNES] =
    {
        csBit = 7,
        csRegisterGlass = 15,
        csFirst = 33,
        csWin = 39,
        csDyna = 58,
        enabled = false,
        winVar = "DynaValkurm_Win",
        hasEnteredVar = "DynaValkurm_HasEntered",
        hasSeenWinCSVar = "DynaValkurm_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_VALKURM_SLIVER,
        enterPos = {100, -8, 131, 47, 39},
        reqs = {tpz.ki.VIAL_OF_SHROUDED_SAND}


    },
    [tpz.zone.BUBURIMU_PENINSULA] =
    {
        csBit = 8,
        csRegisterGlass = 21,
        csFirst = 40,
        csWin = 46,
        csDyna = 22,
        enabled = false,
        winVar = "DynaBuburimu_Win",
        hasEnteredVar = "DynaBuburimu_HasEntered",
        hasSeenWinCSVar = "DynaBuburimu_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_BUBURIMU_SLIVER,
        enterPos = {155, -1, -169, 170, 40},
        reqs = {tpz.ki.VIAL_OF_SHROUDED_SAND}


    },
    [tpz.zone.QUFIM_ISLAND] =
    {
        csBit = 9,
        csRegisterGlass = 2,
        csFirst = 22,
        csWin = 28,
        csDyna = 3,
        enabled = false,
        winVar = "DynaQufim_Win",
        hasEnteredVar = "DynaQufim_HasEntered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_QUFIM_SLIVER,
        enterPos = {-19, -17, 104, 253, 41},
        reqs = {tpz.ki.VIAL_OF_SHROUDED_SAND}


    },
    [tpz.zone.TAVNAZIAN_SAFEHOLD] =
    {
        csBit = 10,
        csRegisterGlass = 587,
        csFirst = 614,
        csWin = 615,
        csDyna = 588,
        enabled = false,
        winVar = "DynaTavnazia_Win",
        hasEnteredVar = "DynaTavnazia_HasEntered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_TAVNAZIA_SLIVER,
        enterPos = {0.1, -7, -21, 190, 42},
        reqs =
                {tpz.ki.VIAL_OF_SHROUDED_SAND,
                tpz.ki.DYNAMIS_BUBURIMU_SLIVER,
                tpz.ki.DYNAMIS_QUFIM_SLIVER,
                tpz.ki.DYNAMIS_VALKURM_SLIVER}


    },
}

dynamis.dynaInfo =
{
    [tpz.zone.DYNAMIS_SAN_DORIA] =
    {
        winVar = "DynaSandoria_Win",
        hasEnteredVar = "DynaSandoria_HasEntered",
        hasSeenWinCSVar = "DynaSandoria_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_COMMAND_SCEPTER,
        winTitle = tpz.title.DYNAMIS_SAN_DORIA_INTERLOPER,
        entryPos = {161.838, -2.000, 161.673, 93, tpz.zone.DYNAMIS_SAN_DORIA},
        ejectPos = {161.000, -2.000, 161.000, 94, tpz.zone.SOUTHERN_SAN_DORIA},
        specifiedChildren = true,
        updatedRoam = true,
    },
    [tpz.zone.SOUTHERN_SAN_DORIA] =
    {
        dynaZone = tpz.zone.DYNAMIS_SAN_DORIA,
        dynaZoneMessageParam = 1,
    },
    [tpz.zone.DYNAMIS_BASTOK] =
    {
        winVar = "DynaBastok_Win",
        hasEnteredVar = "DynaBastok_HasEntered",
        hasSeenWinCSVar = "DynaBastok_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_EYEGLASS,
        winTitle = tpz.title.DYNAMIS_BASTOK_INTERLOPER,
        entryPos = {116.482, 0.994, -72.121, 128, tpz.zone.DYNAMIS_BASTOK},
        ejectPos = {112.000, 0.994, -72.000, 127, tpz.zone.BASTOK_MINES},
    },
    [tpz.zone.BASTOK_MINES] =
    {
        dynaZone = tpz.zone.DYNAMIS_BASTOK,
        dynaZoneMessageParam = 2,
    },
    [tpz.zone.DYNAMIS_WINDURST] =
    {
        winVar = "DynaWindurst_Win",
        hasEnteredVar = "DynaWindurst_HasEntered",
        hasSeenWinCSVar = "DynaWindurst_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_LANTERN,
        winTitle = tpz.title.DYNAMIS_WINDURST_INTERLOPER,
        entryPos = {-221.988, 1.000, -120.184, 0 , tpz.zone.DYNAMIS_WINDURST},
        ejectPos = {-217.000, 1.000, -119.000, 94, tpz.zone.WINDURST_WALLS},
    },
    [tpz.zone.WINDURST_WALLS] =
    {
        dynaZone = tpz.zone.DYNAMIS_WINDURST,
        dynaZoneMessageParam = 3,
    },
    [tpz.zone.DYNAMIS_JEUNO] =
    {
        winVar = "DynaJeuno_Win",
        hasEnteredVar = "DynaJeuno_HasEntered",
        hasSeenWinCSVar = "DynaJeuno_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_TACTICAL_MAP,
        winTitle = tpz.title.DYNAMIS_JEUNO_INTERLOPER,
        entryPos = {48.930, 10.002, -71.032, 195, tpz.zone.DYNAMIS_JEUNO},
        ejectPos = {48.930, 10.002, -71.032, 195, tpz.zone.RULUDE_GARDENS},
        updatedRoam = true,
    },
    [tpz.zone.RULUDE_GARDENS] =
    {
        dynaZone = tpz.zone.DYNAMIS_JEUNO,
        dynaZoneMessageParam = 4,
    },
    [tpz.zone.DYNAMIS_BEAUCEDINE] =
    {
        winVar = "DynaBeaucedine_Win",
        hasEnteredVar = "DynaBeaucedine_HasEntered",
        hasSeenWinCSVar = "DynaBeaucedine_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_INSIGNIA,
        winTitle = tpz.title.DYNAMIS_BEAUCEDINE_INTERLOPER,
        entryPos = {-284.751, -39.923, -422.948, 235, tpz.zone.DYNAMIS_BEAUCEDINE},
        ejectPos = {-284.751, -39.923, -422.948, 235, tpz.zone.BEAUCEDINE_GLACIER},
    },
    [tpz.zone.BEAUCEDINE_GLACIER] =
    {
        dynaZone = tpz.zone.DYNAMIS_BEAUCEDINE,
        dynaZoneMessageParam = 5,
    },
    [tpz.zone.DYNAMIS_XARCABARD] =
    {
        winVar = "DynaXarcabard_Win",
        hasEnteredVar = "DynaXarcabard_HasEntered",
        hasSeenWinCSVar = "DynaXarcabard_HasSeenWinCS",
        winKI = tpz.ki.HYDRA_CORPS_BATTLE_STANDARD,
        winTitle = tpz.title.DYNAMIS_XARCABARD_INTERLOPER,
        entryPos = {569.312, -0.098, -270.158, 90, tpz.zone.DYNAMIS_XARCABARD},
        ejectPos = {569.312, -0.098, -270.158, 90, tpz.zone.XARCABARD},
    },
    [tpz.zone.XARCABARD] =
    {
        dynaZone = tpz.zone.DYNAMIS_XARCABARD,
        dynaZoneMessageParam = 6,
    },
    [tpz.zone.DYNAMIS_VALKURM] =
    {
        winVar = "DynaValkurm_Win",
        hasEnteredVar = "DynaValkurm_HasEntered",
        hasSeenWinCSVar = "DynaValkurm_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_VALKURM_SLIVER,
        winTitle = tpz.title.DYNAMIS_VALKURM_INTERLOPER,
        entryPos = {100, -8, 131, 47, tpz.zone.DYNAMIS_VALKURM},
        ejectPos = {119, -9, 131, 52, tpz.zone.VALKURM_DUNES},
        sjRestriction = true,
    },
    [tpz.zone.VALKURM_DUNES] =
    {
        dynaZone = tpz.zone.DYNAMIS_VALKURM,
        dynaZoneMessageParam = 7,
    },
    [tpz.zone.DYNAMIS_BUBURIMU] =
    {
        winVar = "DynaBuburimu_Win",
        hasEnteredVar = "DynaBuburimu_HasEntered",
        hasSeenWinCSVar = "DynaBuburimu_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_BUBURIMU_SLIVER,
        winTitle = tpz.title.DYNAMIS_BUBURIMU_INTERLOPER,
        entryPos = {155, -1, -169, 170, tpz.zone.DYNAMIS_BUBURIMU},
        ejectPos = {154, -1, -170, 190, tpz.zone.BUBURIMU_PENINSULA},
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
    [tpz.zone.BUBURIMU_PENINSULA] =
    {
        dynaZone = tpz.zone.DYNAMIS_BUBURIMU,
        dynaZoneMessageParam = 8,
    },
    [tpz.zone.DYNAMIS_QUFIM] =
    {
        winVar = "DynaQufim_Win",
        hasEnteredVar = "DynaQufim_HasEntered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_QUFIM_SLIVER,
        winTitle = tpz.title.DYNAMIS_QUFIM_INTERLOPER,
        entryPos = {-19, -17, 104, 253, tpz.zone.DYNAMIS_QUFIM},
        ejectPos = { 18, -19, 162, 240, tpz.zone.QUFIM_ISLAND},
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
    [tpz.zone.QUFIM_ISLAND] =
    {
        dynaZone = tpz.zone.DYNAMIS_QUFIM,
        dynaZoneMessageParam = 9,
    },
    [tpz.zone.DYNAMIS_TAVNAZIA] =
    {
        winVar = "DynaTavnazia_Win",
        hasEnteredVar = "DynaTavnazia_HasEntered",
        hasSeenWinCSVar = "DynaQufim_HasSeenWinCS",
        winKI = tpz.ki.DYNAMIS_TAVNAZIA_SLIVER,
        winTitle = tpz.title.DYNAMIS_TAVNAZIA_INTERLOPER,
        entryPos = {0.1, -7, -21, 190, tpz.zone.DYNAMIS_TAVNAZIA},
        ejectPos = {0  , -7, -23, 195, tpz.zone.TAVNAZIAN_SAFEHOLD},
    },
    [tpz.zone.TAVNAZIAN_SAFEHOLD] =
    {
        dynaZone = tpz.zone.DYNAMIS_TAVNAZIA,
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

dynamis.timeless = 4236
dynamis.perpetual = 4237
dynamis.min_lvl = 65
dynamis.reservation_cancel = 180
dynamis.reentry_days = 3
dynamis.maxchars = 64

dynamis.entryNpcOnTrade = function(player, npc, trade, message_not_reached_level, message_another_group, message_cannot_enter)
    local playerZoneID = player:getZoneID()
    if dynamis.entryInfo[playerZoneID].enabled == false then return end
    for i, name in ipairs(dynamis.entryInfo[playerZoneID].reqs) do --requirements for northlands and elsewhere
        if player:hasKeyItem(name) == false then return end
    end
    if dynamis.entryInfo[playerZoneID].csBit >= 7 then --Requirements for dreamlands
        if player:hasCompletedMission(COP, tpz.mission.id.cop.DARKNESS_NAMED) == false then
            return
        end
    end
    if player:getMainLvl() < dynamis.min_lvl then
        player:messageSpecial(message_not_reached_level, dynamis.min_lvl)
        return
    end

    local remaining = GetDynaTimeRemaining(dynamis.entryInfo[playerZoneID].enterPos[5])
    local hasEntered = player:getCharVar(dynamis.entryInfo[playerZoneID].hasEnteredVar)
    local timeSinceLastDynaReservation = player:timeSinceLastDynaReservation()

    if npcUtil.tradeHas(trade, dynamis.timeless, true, false) then -- timeless hourglass, attempting to trade for a perpetual hourglass
        if remaining > 0 then
            player:messageSpecial(message_another_group, dynamis.entryInfo[playerZoneID].csBit)
        elseif timeSinceLastDynaReservation < 71 then
            player:messageSpecial(message_cannot_enter, 71-timeSinceLastDynaReservation, dynamis.entryInfo[playerZoneID].csBit)
        else
            player:startEvent(dynamis.entryInfo[playerZoneID].csRegisterGlass,dynamis.entryInfo[playerZoneID].csBit,hasEntered == 1 and 0 or 1,dynamis.reservation_cancel,dynamis.reentry_days,dynamis.maxchars,tpz.ki.VIAL_OF_SHROUDED_SAND,dynamis.timeless,dynamis.perpetual)
        end
    elseif npcUtil.tradeHas(trade, dynamis.perpetual, true, false) then -- perpetual hourglass, attempting to enter a registered instance or start a new one
        local hgValid = player:checkHourglassValid(trade:getItem(0), dynamis.entryInfo[playerZoneID].enterPos[5])
        if hgValid > 0 then -- 0 = can't enter (wrong glass or didn't wait 71 hours since last dynamis), 1 = entering, 2 = re-entering (weakness)
            player:prepareDynamisEntry(trade:getItem(0), hgValid) -- save the hourglass's params to the character while they are viewing the cs
            player:startEvent(dynamis.entryInfo[playerZoneID].csDyna,dynamis.entryInfo[playerZoneID].csBit,hasEntered == 1 and 0 or 1,dynamis.reservation_cancel,dynamis.reentry_days,dynamis.maxchars,tpz.ki.VIAL_OF_SHROUDED_SAND,dynamis.timeless,dynamis.perpetual)
        elseif timeSinceLastDynaReservation < 71 then
            player:messageSpecial(message_cannot_enter, 71-timeSinceLastDynaReservation, dynamis.entryInfo[playerZoneID].csBit)
        elseif remaining > 0 then
            player:messageSpecial(message_another_group, dynamis.entryInfo[playerZoneID].csBit)
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

dynamis.entryNpcOnEventUpdate = function(player, csid, option, message_unable_to_connect)
    local playerZoneID = player:getZoneID()
    if dynamis.entryInfo[playerZoneID].enabled == false then return end
    if csid == dynamis.entryInfo[playerZoneID].csRegisterGlass then -- trade out timeless hourglass for a perpetual hourglass
        -- Do not proceed until we know the Dynamis server is up.
        -- This will prevent us from deleting the expensive hourglass
        -- if we cannot provide the service
        if option == 0 then
            player:setCharVar("DynaPrep_zoneid", dynamis.entryInfo[playerZoneID].enterPos[5])
            player:setLocalVar("DynamisWaitingForServer", 1)
            player:pingDynamis()
            player:queue(5000, function(player)
                if player:getLocalVar("DynamisWaitingForServer") ~= 0 then
                    player:setLocalVar("DynamisWaitingForServer", 0)
                    player:release()
                    player:messageSpecial(message_unable_to_connect, dynamis.entryInfo[playerZoneID].csBit)
                end
            end)
        else
            player:release()
        end
    end
end

dynamis.entryNpcOnEventFinish = function(player, csid, option, message_connecting_with_the_server, message_unable_to_connect)
    local playerZoneID = player:getZoneID()
    if dynamis.entryInfo[playerZoneID].enabled == false then return end
    if csid == dynamis.entryInfo[playerZoneID].csDyna then -- enter dynamis
        if option == 0 then
            -- Will call onDynamisServerReply async when the server replies
            player:setLocalVar("DynamisWaitingForServer", 1)
            player:registerDynamis()
            -- In case the Dynamis server failed notify the player
            player:messageSpecial(message_connecting_with_the_server, dynamis.entryInfo[playerZoneID].csBit)
            player:queue(5000, function(player)
                if player:getLocalVar("DynamisWaitingForServer") ~= 0 then
                    player:setLocalVar("DynamisWaitingForServer", 0)
                    player:messageSpecial(message_unable_to_connect, dynamis.entryInfo[playerZoneID].csBit)
                    player:queue(1000, function(player)
                        player:setPos(player:getXPos(), player:getYPos(), player:getZPos(), player:getRotPos(), player:getZoneID())
                    end)
                end
            end)
        end
    elseif csid == dynamis.entryInfo[playerZoneID].csSand then -- get shrouded sand
        npcUtil.giveKeyItem(player, tpz.ki.VIAL_OF_SHROUDED_SAND)
    elseif csid == dynamis.entryInfo[playerZoneID].csWin then -- just saw win cs
        player:setCharVar(dynamis.entryInfo[playerZoneID].hasSeenWinCSVar, 1)
    end
end

dynamis.entryNpcOnDynamisServerReply = function(player, result, message_information_recorded, message_obtained, message_another_group)
    local playerZoneID = player:getZoneID()
    if dynamis.entryInfo[playerZoneID].enabled == false then return end
    player:setLocalVar("DynamisWaitingForServer", 0)
    if result == 2 then
        -- Ping response when trading timeless hourglass
        player:release()
        if player:registerHourglass(dynamis.entryInfo[playerZoneID].enterPos[5]) == true then
            trade = player:getCurrentTrade()
            if trade ~= nil and npcUtil.tradeHasExactly(trade, dynamis.timeless) then
                player:confirmTrade()
                player:messageSpecial(message_information_recorded, dynamis.perpetual)
                player:messageSpecial(message_obtained, dynamis.perpetual)
            end
        end
    elseif result == 1 then
        -- Entry when trading perpetual hourglass
        local entryPos = dynamis.entryInfo[playerZoneID].enterPos
        if entryPos == nil then return end
        player:setCharVar(dynamis.entryInfo[playerZoneID].hasEnteredVar, 1)
        player:setPos(entryPos[1], entryPos[2], entryPos[3], entryPos[4], entryPos[5])
    elseif result == 3 then
        player:messageSpecial(message_another_group, dynamis.entryInfo[playerZoneID].csBit)
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
        sjRestrictionNPC:setStatus(tpz.status.NORMAL)
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
        if player:getCharVar("DynaInflictWeakness") == 1 then player:addStatusEffect(tpz.effect.WEAKNESS, 1, 3, 60*10) end
            player:setCharVar("DynaInflictWeakness", 0)
        if dynamis.dynaInfo[zoneId].sjRestriction == true then
            if os.time() > player:getCharVar("SJUnlockTime") then
                player:addStatusEffect(tpz.effect.SJ_RESTRICTION, 1, 3, 0)
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
                if member:hasStatusEffect(tpz.effect.SJ_RESTRICTION) then
                    if member:hasStatusEffect(tpz.effect.RERAISE) then -- Check for reraise and store values.
                        member:setLocalVar("had_reraise", 1)
                        member:setLocalVar("reraise_power", member:getStatusEffect(tpz.effect.RERAISE):getPower())
                        member:setLocalVar("reraise_duration", member:getStatusEffect(tpz.effect.RERAISE):getDuration())
                    end
                    member:delStatusEffect(tpz.effect.SJ_RESTRICTION)
                    player:setCharVar("SJUnlockTime", os.time() + 14400) -- Set Immune to reobtaining SJ_Restriction for 4 hours.
                    if member:getLocalVar("had_reraise") == 1 then -- Reapply previous reraise if lost.
                        if not member:hasStatusEffect(tpz.effect.RERAISE) then
                            member:addStatusEffect(tpz.effect.RERAISE, member:getLocalVar("reraise_power"), 0, member:getLocalVar("reraise_duration"))
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
        [  3] = tpz.jsa.EES_AERN,    -- Aern
        [ 25] = tpz.jsa.EES_ANTICA,  -- Antica
        [115] = tpz.jsa.EES_SHADE,   -- Fomor
        [126] = tpz.jsa.EES_GIGA,    -- Gigas
        [127] = tpz.jsa.EES_GIGA,    -- Gigas
        [128] = tpz.jsa.EES_GIGA,    -- Gigas
        [129] = tpz.jsa.EES_GIGA,    -- Gigas
        [130] = tpz.jsa.EES_GIGA,    -- Gigas
        [133] = tpz.jsa.EES_GOBLIN,  -- Goblin
        [169] = tpz.jsa.EES_KINDRED, -- Kindred
        [171] = tpz.jsa.EES_LAMIA,   -- Lamiae
        [182] = tpz.jsa.EES_MERROW,  -- Merrow
        [184] = tpz.jsa.EES_GOBLIN,  -- Moblin
        [189] = tpz.jsa.EES_ORC,     -- Orc
        [200] = tpz.jsa.EES_QUADAV,  -- Quadav
        [201] = tpz.jsa.EES_QUADAV,  -- Quadav
        [202] = tpz.jsa.EES_QUADAV,  -- Quadav
        [221] = tpz.jsa.EES_SHADE,   -- Shadow
        [222] = tpz.jsa.EES_SHADE,   -- Shadow
        [223] = tpz.jsa.EES_SHADE,   -- Shadow
        [246] = tpz.jsa.EES_TROLL,   -- Troll
        [270] = tpz.jsa.EES_YAGUDO,  -- Yagudo
        [327] = tpz.jsa.EES_GOBLIN,  -- Goblin
        [328] = tpz.jsa.EES_GIGA,    -- Gigas
        [334] = tpz.jsa.EES_ORC,     -- OrcNM
        [335] = tpz.jsa.EES_MAAT,    -- Maat
        [337] = tpz.jsa.EES_QUADAV,  -- QuadavNM
        [358] = tpz.jsa.EES_KINDRED, -- Kindred
        [359] = tpz.jsa.EES_SHADE,   -- Fomor
        [360] = tpz.jsa.EES_YAGUDO,  -- YagudoNM
        [373] = tpz.jsa.EES_GOBLIN,  -- Goblin_Armored
    }

    if     job == tpz.job.WAR then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.MIGHTY_STRIKES
        params.specials.skill.hpp = math.random(55,80)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.MNK then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.HUNDRED_FISTS
        params.specials.skill.hpp = math.random(55,70)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.WHM then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.BENEDICTION
        params.specials.skill.hpp = math.random(40,60)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.BLM then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.MANAFONT
        params.specials.skill.hpp = math.random(55,80)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.RDM then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.CHAINSPELL
        params.specials.skill.hpp = math.random(55,80)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.THF then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.PERFECT_DODGE
        params.specials.skill.hpp = math.random(55,75)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.PLD then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.INVINCIBLE
        params.specials.skill.hpp = math.random(55,75)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.DRK then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.BLOOD_WEAPON
        params.specials.skill.hpp = math.random(55,75)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.BST then
    elseif job == tpz.job.BRD then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.SOUL_VOICE
        params.specials.skill.hpp = math.random(55,80)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.RNG then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = familyEES[mob:getFamily()]
        params.specials.skill.hpp = math.random(55,75)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.SAM then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.MEIKYO_SHISUI
        params.specials.skill.hpp = math.random(55,80)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.NIN then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.MIJIN_GAKURE
        params.specials.skill.hpp = math.random(25,35)
        tpz.mix.jobSpecial.config(mob, params)
    elseif job == tpz.job.DRG then
    elseif job == tpz.job.SMN then
    end

    -- Add Check After Calcs
    mob:setMobMod(tpz.mobMod.CHECK_AS_NM, 2)

end

dynamis.setNMStats = function(mob)
    local job = mob:getMainJob()
    local zone = mob:getZoneID()

    mob:setMobType(tpz.MOBTYPE_NOTORIOUS)
    mob:setMaxHPP(132)
    mob:setMobLevel(math.random(80,82))
    mob:setMod(tpz.mod.STR, -15)
    mob:setMod(tpz.mod.VIT, -5)

    mob:setTrueDetection(1)

    if job == tpz.job.NIN then
        local params = { }
        params.specials = { }
        params.specials.skill = { }
        params.specials.skill.id = tpz.jsa.MIJIN_GAKURE
        params.specials.skill.hpp = math.random(15,25)
        tpz.mix.jobSpecial.config(mob, params)
    end
end

dynamis.setStatueStats = function(mob)
    local job = mob:getMainJob()
    local zone = mob:getZoneID()

    mob:setMobType(tpz.MOBTYPE_NOTORIOUS)
    mob:setMobLevel(math.random(82,84))
    mob:setMod(tpz.mod.STR, -5)
    mob:setMod(tpz.mod.VIT, -5)

    mob:setMod(tpz.mod.DMGMAGIC, -50)
    mob:setMod(tpz.mod.DMGPHYS, -50)

    -- Disabling WHM job trait mods because their job is set to WHM in the DB.
    mob:setMod(tpz.mod.MDEF, 0)
    mob:setMod(tpz.mod.REGEN, 0)
    mob:setMod(tpz.mod.MPHEAL, 0)

    mob:setTrueDetection(1)

end

dynamis.setMegaBossStats = function(mob)
    local job = mob:getMainJob()
    local zone = mob:getZoneID()

    mob:setMobType(tpz.MOBTYPE_NOTORIOUS)
    mob:setMobLevel(88)
    mob:setMod(tpz.mod.STR, -10)
    mob:setTrueDetection(1)

end

dynamis.setPetStats = function(mob)
    local zone = mob:getZoneID()

    mob:setMobLevel(78)
    mob:setMod(tpz.mod.STR, -40)
    mob:setMod(tpz.mod.INT, -30)
    mob:setMod(tpz.mod.VIT, -20)
    mob:setMod(tpz.mod.RATTP, -20)
    mob:setMod(tpz.mod.ATTP, -20)
    mob:setMod(tpz.mod.DEFP, -5)
    mob:setTrueDetection(1)

end

dynamis.setAnimatedWeaponStats = function(mob)
    local job = mob:getMainJob()
    local zone = mob:getZoneID()

    mob:setMobMod(tpz.mobMod.NO_MOVE, 0)
    mob:setMobMod(tpz.mobMod.HP_HEAL_CHANCE, 90)
    mob:setMod(tpz.mod.STUNRESTRAIT, 75)
    mob:setMod(tpz.mod.PARALYZERESTRAIT, 100)
    mob:setMod(tpz.mod.SLOWRESTRAIT, 100)
    mob:setMod(tpz.mod.SILENCERESTRAIT, 100)
    mob:setMod(tpz.mod.LULLABYRESTRAIT, 100)
    mob:setMod(tpz.mod.SLEEPRESTRAIT, 100)

end

dynamis.setEyeStats = function(mob)
    local job = mob:getMainJob()
    local zone = mob:getZoneID()

    mob:setMobType(tpz.MOBTYPE_NOTORIOUS)
    mob:setMobLevel(math.random(82,84))
    mob:setMod(tpz.mod.DEF, 420)
    mob:addMod(tpz.mod.MDEF, 150)
    mob:addMod(tpz.mod.DMGMAGIC, -25)

end

--------------------------------------------------
-- getDynamisMapList
-- Produces a bitmask for the goblin ancient currency NPCs
--------------------------------------------------

function getDynamisMapList(player)
    local bitmask = 0
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_SANDORIA) == true) then
        bitmask = bitmask + 2
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_BASTOK) == true) then
        bitmask = bitmask + 4
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_WINDURST) == true) then
        bitmask = bitmask + 8
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_JEUNO) == true) then
        bitmask = bitmask + 16
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_BEAUCEDINE) == true) then
        bitmask = bitmask + 32
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_XARCABARD) == true) then
        bitmask = bitmask + 64
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_VALKURM) == true) then
        bitmask = bitmask + 128
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_BUBURIMU) == true) then
        bitmask = bitmask + 256
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_QUFIM) == true) then
        bitmask = bitmask + 512
    end
    if (player:hasKeyItem(tpz.ki.MAP_OF_DYNAMIS_TAVNAZIA) == true) then
        bitmask = bitmask + 1024
    end

    return bitmask
end
