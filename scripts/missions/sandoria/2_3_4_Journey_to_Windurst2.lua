-----------------------------------
-- Journey to Windurst
-- San d'Oria M2-3 (Part 2)
-----------------------------------
-- !addmission 0 9
-- Kupipi    : !pos 2 0.1 30 242
-- Mourices  : !pos -50.646 -0.501 -27.642 241
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_WINDURST2)

mission.reward = {}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BALGAS_DAIS] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 8 and
                        player:getLocalVar('battlefieldWin') == 96
                    then
                        npcUtil.giveKeyItem(player, xi.ki.KINDRED_CREST)
                        player:delKeyItem(xi.ki.DARK_KEY)
                        player:setMissionStatus(mission.areaId, 9)
                    end
                end,
            },
        },

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 7 then
                        return mission:progressEvent(242, 1, 1, 1, 1, 0)
                    elseif missionStatus == 8 then
                        return mission:event(243)
                    elseif missionStatus == 9 then
                        return mission:progressEvent(246)
                    elseif missionStatus == 10 then
                        return mission:event(247)
                    end
                end,
            },

            onEventFinish =
            {
                [242] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DARK_KEY)
                    player:setMissionStatus(mission.areaId, 8)
                end,

                [246] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 10)
                end,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Mourices'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 8 then
                        return mission:progressEvent(463)
                    elseif missionStatus == 9 or missionStatus == 10 then
                        return mission:progressEvent(467)
                    end
                end,
            },

            onEventFinish =
            {
                [467] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_ABROAD)
                        player:delKeyItem(xi.ki.KINDRED_CREST)
                        player:setMissionStatus(mission.areaId, 11)
                        npcUtil.giveKeyItem(player, xi.ki.KINDRED_REPORT)
                    end
                end,
            },
        },
    },
}

return mission
