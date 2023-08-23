-----------------------------------
-- The Emissary Windurst
-- Bastok M2-3 (Part 2)
-----------------------------------
-- !addmission 1 9
-- Kupipi    : !pos 2 0.1 30 242
-- Melek     : !pos -80.6 -5.5 157.3 240
-----------------------------------
local portWindurstID = zones[xi.zone.PORT_WINDURST]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_WINDURST2)

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
                        return mission:progressEvent(242, 1, 1, 1, 1, xi.nation.BASTOK)
                    elseif missionStatus == 8 then
                        return mission:event(243)
                    elseif missionStatus == 9 then
                        return mission:progressEvent(244)
                    elseif missionStatus == 10 then
                        return mission:event(245)
                    end
                end,
            },

            onEventFinish =
            {
                [242] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.DARK_KEY)
                    player:setMissionStatus(mission.areaId, 8)
                end,

                [244] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 10)
                end,
            },
        },

        [xi.zone.PORT_WINDURST] =
        {
            ['Ada'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 7 then
                        return mission:progressEvent(63)
                    end
                end,
            },

            ['Gold_Skull'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 7 then
                        return mission:progressEvent(62)
                    elseif missionStatus == 8 then
                        return mission:messageText(portWindurstID.text.GOLD_SKULL_DIALOG + 27)
                    elseif missionStatus == 9 then
                        return mission:progressEvent(57)
                    end
                end,
            },

            ['Josef'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 7 then
                        return mission:progressEvent(65)
                    end
                end,
            },

            ['Melek'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 7 then
                        return mission:progressEvent(64)
                    elseif missionStatus == 8 then
                        return mission:messageText(portWindurstID.text.MELEK_DIALOG_A)
                    elseif player:hasKeyItem(xi.ki.KINDRED_CREST) then
                        return mission:progressEvent(66)
                    end
                end,
            },

            onEventFinish =
            {
                [66] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY)
                        player:delKeyItem(xi.ki.KINDRED_CREST)
                        player:setMissionStatus(mission.areaId, 10)
                        npcUtil.giveKeyItem(player, xi.ki.KINDRED_REPORT)
                    end
                end,
            },
        },
    },
}

return mission
