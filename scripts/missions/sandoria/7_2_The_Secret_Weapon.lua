-----------------------------------
-- The Secret Weapon
-- San d'Oria M7-2
-----------------------------------
-- !addmission 0 19
-- Ambrotien             : !pos 93.419 -0.001 -57.347 230
-- Grilau                : !pos -241.987 6.999 57.887 231
-- Endracion             : !pos -110 1 -34 230
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_SECRET_WEAPON)

mission.reward =
{
    rank = 8,
    gil = 60000,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 19 then
        mission:begin(player)
    end
end

-- This mission contains up to 3 statuses that are used before the mission is actually accepted, and is blocking
-- for other missions when the requirements are met.  Until those requirements are met, gate guards will default
-- to their typical mission assignment behavior.
mission.sections =
{
    -- Player has no active missions
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId and
                player:getRank(player:getNation()) == 7 and
                player:hasCompletedMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.PRESTIGE_OF_THE_PAPSQUE) and
                xi.mission.getMissionRankPoints(player, mission.missionId)
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) < 2 then
                        return mission:progressEvent(1041)
                    end
                end,
            },

            onEventFinish =
            {
                [1009] = handleAcceptMission,

                [1041] = function(player, csid, option, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) < 2 then
                        return mission:progressEvent(1042)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) < 2 then
                        return mission:progressEvent(1041)
                    end
                end,
            },

            onEventFinish =
            {
                [1009] = handleAcceptMission,
                [2009] = handleAcceptMission,

                [1041] = function(player, csid, option, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,

                [1042] = function(player, csid, option, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        player:setMissionStatus(mission.areaId, 1)
                    end
                end,
            },
        },

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            onTriggerAreaEnter =
            {
                [1] = function(player, triggerArea)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(0)
                    end
                end,
            },

            onEventFinish =
            {
                [0] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,
            },
        },
    },

    -- Player has accepted the mission
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.HORLAIS_PEAK] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        player:getLocalVar('battlefieldWin') == 3
                    then
                        npcUtil.giveKeyItem(player, xi.ki.CRYSTAL_DOWSER)
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:progressEvent(1043)
                    end
                end,
            },

            onEventFinish =
            {
                [1043] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.CRYSTAL_DOWSER)
                    end
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:progressEvent(1044)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        return mission:progressEvent(1043)
                    end
                end,
            },

            onEventFinish =
            {
                [1043] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.CRYSTAL_DOWSER)
                    end
                end,

                [1044] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.CRYSTAL_DOWSER)
                    end
                end,
            },
        },
    },
}

return mission
