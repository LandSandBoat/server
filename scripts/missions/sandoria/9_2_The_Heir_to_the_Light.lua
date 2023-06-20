-----------------------------------
-- The Heir to the Light
-- San d'Oria M9-2
-----------------------------------
-- !addmission 0 23
-- Ambrotien             : !pos 93.419 -0.001 -57.347 230
-- Grilau                : !pos -241.987 6.999 57.887 231
-- Endracion             : !pos -110 1 -34 230
-- (_6h4) Great Hall     : !pos 0 -1 13 233
-- _5a0: Heavy Stone Dr  : !pos -39 4.823 20 190
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/mission')
require('scripts/globals/titles')
require('scripts/globals/zone')
local chateauID = require("scripts/zones/Chateau_dOraguille/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_HEIR_TO_THE_LIGHT)

mission.reward =
{
    rank = 10,
    gil = 100000,
    title = xi.title.SAN_DORIAN_ROYAL_HEIR,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 23 then
        mission:begin(player)
    end
end

mission.sections =
{
    -- Player has no active missions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
                [2009] = handleAcceptMission,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            onEventFinish =
            {
                [1009] = handleAcceptMission,
            },
        },
    },

    -- Player has accepted the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['_6h0'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) > 5 then
                        return mission:progressEvent(3)
                    end
                end,
            },

            ['_6h1'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) > 5 then
                        return mission:progressEvent(5)
                    end
                end,
            },

            ['_6h4'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 5 then
                        return mission:progressEvent(8)
                    end
                end,
            },

            ['Aramaviont'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus > 4 then
                        return mission:progressEvent(14)
                    elseif missionStatus > 1 then
                        return mission:progressEvent(13)
                    end
                end,
            },

            ['Curilla'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus > 3 then
                        return mission:progressEvent(19)
                    elseif missionStatus > 1 then
                        return mission:progressEvent(18)
                    end
                end,
            },

            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 7 then
                        return mission:progressEvent(9)
                    elseif missionStatus > 5 then
                        return mission:progressEvent(30)
                    elseif missionStatus > 4 then
                        return mission:progressEvent(npc, chateauID.text.HEIR_TO_LIGHT_EXTRA)
                    elseif missionStatus > 1 then
                        return mission:progressEvent(29)
                    end
                end,
            },

            ['Milchupain'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus > 4 then
                        return mission:progressEvent(35)
                    elseif missionStatus > 1 then
                        return mission:progressEvent(34)
                    end
                end,
            },

            ['Nachou'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 5 then
                        return mission:progressEvent(6)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(4)
                    end
                end,
            },

            ['Perfaumand'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 5 then
                        return mission:progressEvent(7)
                    elseif missionStatus == 2 then
                        return mission:progressEvent(2)
                    end
                end,
            },

            ['Rahal'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus > 4 then
                        return mission:progressEvent(40)
                    elseif missionStatus > 1 then
                        return mission:progressEvent(39)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return 10
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 6)
                end,

                -- It is possible to obtain the San d'Orian flag after completing this mission
                -- should inventory be full.  Set 'Flag' mission variable should this occur.
                -- 'Option' set after complete for additional dialogue, and cleared on Zoning
                -- into Southern San d'Oria.
                [9] = function(player, csid, option, npc)
                    mission:complete(player)
                    mission:setVar(player, 'Option', 1)

                    if not npcUtil.giveItem(player, xi.items.SAN_DORIAN_FLAG) then
                        mission:setVar(player, 'Flag', 1)
                    end
                end,

                [10] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['_6fc'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) > 5 then
                        return mission:progressEvent(50)
                    end
                end,
            },

            onZoneIn =
            {
                function(player, prevZone)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return 1
                    elseif missionStatus == 4 then
                        return 0
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 5)
                end,

                [1] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,
            },
        },

        [xi.zone.FEIYIN] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 2 then
                        return 23
                    end
                end,
            },

            onEventFinish =
            {
                [23] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                end,
            },
        },

        [xi.zone.QUBIA_ARENA] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 3 and
                        player:getLocalVar('battlefieldWin') == 516
                    then
                        player:setMissionStatus(mission.areaId, 4)
                    end
                end,
            },
        },

        [xi.zone.KING_RANPERRES_TOMB] =
        {
            ['_5a0'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 6 then
                        return mission:progressEvent(14)
                    end
                end,
            },

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 7)
                end,
            },
        },
    },

    -- Player has completed this mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Aramaviont'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 1 then
                        return mission:progressEvent(11)
                    end
                end,
            },

            ['Curilla'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 1 then
                        return mission:progressEvent(20)
                    end
                end,
            },

            ['Halver'] =
            {
                -- If the player's inventory was full on mission complete, give them the
                -- nation flag, and clear the variable.  This could probably be short circuited
                -- with one conditional, but playing it safe.
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Flag') == 1 then
                        if npcUtil.giveItem(player, xi.items.SAN_DORIAN_FLAG) then
                            mission:setVar(player, 'Flag', 0)
                        end
                    end
                end,
            },

            ['Rahal'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 1 then
                        return mission:progressEvent(41)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['_6fc'] =
            {
                onTrigger = function(player, npc)
                    if mission:getVar(player, 'Option') == 1 then
                        return mission:progressEvent(50)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Option') == 1 then
                        return 0
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    mission:setVar(player, 'Option', 0)
                end,
            },
        },
    },
}

return mission
