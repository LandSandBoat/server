-----------------------------------
-- The Davoi Report
-- San d'Oria M2-2
-----------------------------------
-- !addmission 0 4
-- Ambrotien      : !pos 93.419 -0.001 -57.347 230
-- Grilau         : !pos -241.987 6.999 57.887 231
-- Endracion      : !pos -110 1 -34 230
-- Zantaviat      : !pos 215 0.1 -10 149
-- '!'            : !pos 211 2 -104 149
-- Papal Chambers : !pos 131 -11 122 231
-----------------------------------
local southernSandoriaID = zones[xi.zone.SOUTHERN_SAN_DORIA]
local northernSandoriaID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.THE_DAVOI_REPORT)

mission.reward =
{
    rankPoints = 350,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 104 then
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

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.DAVOI] =
        {
            ['Zantaviat'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 0 then
                        return mission:progressEvent(100)
                    elseif player:hasKeyItem(xi.ki.LOST_DOCUMENT) then
                        return mission:progressEvent(104)
                    end
                end,
            },

            -- TODO: Rename this NPC to be a non-special character, and make this NPC unique!
            ['!'] =
            {
                onTrigger = function(player, npc)
                    local xPos = npc:getXPos()

                    if
                        not player:hasKeyItem(xi.ki.LOST_DOCUMENT) and
                        xPos > 210 and xPos < 212
                    then
                        player:setMissionStatus(player:getNation(), 2)
                        return mission:keyItem(xi.ki.LOST_DOCUMENT)
                    end
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [104] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 3)
                    player:delKeyItem(xi.ki.LOST_DOCUMENT)
                    npcUtil.giveKeyItem(player, xi.ki.TEMPLE_KNIGHTS_DAVOI_REPORT)
                end,
            },
        },

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Ambrotien'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        if player:hasCompletedMission(mission.areaId, mission.missionId) then
                            return mission:progressEvent(2006)
                        else
                            return mission:progressEvent(2028, 0, 0, 0, 44)
                        end
                    else
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 44)
                    end
                end,
            },

            ['Endracion'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        if player:hasCompletedMission(mission.areaId, mission.missionId) then
                            return mission:progressEvent(1006)
                        else
                            return mission:progressEvent(1028, 0, 0, 0, 44)
                        end
                    else
                        return mission:messageText(southernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 44)
                    end
                end,
            },

            onEventFinish =
            {
                [1006] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.TEMPLE_KNIGHTS_DAVOI_REPORT)
                    end
                end,

                [2006] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.TEMPLE_KNIGHTS_DAVOI_REPORT)
                    end
                end,
            }
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['_6fc'] =
            {
                onTrigger = function(player, npc)
                    if
                        not player:hasCompletedMission(mission.areaId, mission.missionId) and
                        player:hasKeyItem(xi.ki.TEMPLE_KNIGHTS_DAVOI_REPORT)
                    then
                        return mission:progressEvent(695)
                    end
                end,
            },

            ['Grilau'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 3 then
                        if player:hasCompletedMission(mission.areaId, mission.missionId) then
                            return mission:progressEvent(1006)
                        else
                            return mission:progressEvent(1028, 0, 0, 0, 44)
                        end
                    else
                        return mission:messageText(northernSandoriaID.text.ORIGINAL_MISSION_OFFSET + 44)
                    end
                end,
            },

            onEventFinish =
            {
                [695] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.TEMPLE_KNIGHTS_DAVOI_REPORT)
                    end
                end,

                [1006] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.TEMPLE_KNIGHTS_DAVOI_REPORT)
                    end
                end,
            }
        },
    },
}

return mission
