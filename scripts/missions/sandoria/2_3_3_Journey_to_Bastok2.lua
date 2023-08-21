-----------------------------------
-- Journey to Bastok
-- San d'Oria M2-3 (Part 2)
-----------------------------------
-- !addmission 0 8
-- Grohm           : !pos -18 -11 -27 237
-- Pius            : !pos 99 -21 -12 237
-- Savae E Paleade : !pos 23.724 -17.39 -43.360 237
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_TO_BASTOK2)

mission.reward = {}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.METALWORKS] =
        {
            ['Chantain'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus >= 8 and missionStatus <= 10 then
                        return mission:progressEvent(217)
                    end
                end,
            },

            ['Lutia'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus >= 8 and missionStatus <= 10 then
                        return mission:progressEvent(214)
                    end
                end,
            },

            ['Grohm'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 9 then
                        return mission:progressEvent(426)
                    else
                        return mission:progressEvent(427)
                    end
                end,
            },

            ['Pius'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 8 then
                        return mission:progressEvent(355)
                    elseif missionStatus < 11 then
                        return mission:progressEvent(356)
                    end
                end,
            },

            ['Riault'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus >= 8 and missionStatus <= 10 then
                        return mission:progressEvent(211)
                    end
                end,
            },

            ['Savae_E_Paleade'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus >= 8 and missionStatus <= 10 then
                        return mission:progressEvent(208)
                    elseif missionStatus == 11 then
                        return mission:progressEvent(207)
                    end
                end,
            },

            onEventFinish =
            {
                [207] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:addMission(xi.mission.log_id.SANDORIA, xi.mission.id.sandoria.JOURNEY_ABROAD)
                        player:delKeyItem(xi.ki.KINDRED_CREST)
                        npcUtil.giveKeyItem(player, xi.ki.KINDRED_REPORT)
                        player:setMissionStatus(mission.areaId, 11)
                    end
                end,

                [355] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 9)
                end,

                [426] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 10)
                end,
            },
        },

        [xi.zone.WAUGHROON_SHRINE] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 10 and
                        player:getLocalVar('battlefieldWin') == 64
                    then
                        npcUtil.giveKeyItem(player, xi.ki.KINDRED_CREST)
                        player:delKeyItem(xi.ki.DARK_KEY)
                        player:setMissionStatus(mission.areaId, 11)
                    end
                end,
            },
        },
    },
}

return mission
