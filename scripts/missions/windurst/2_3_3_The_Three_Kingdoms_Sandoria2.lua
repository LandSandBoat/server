-----------------------------------
-- The Three Kingdoms San d'Oria
-- Windurst M2-3 (Part 2)
-----------------------------------
-- !addmission 2 8
-- Kasaroro : !pos -72 -3 34 231
-- Halver   : !pos 2 0.1 0.1 233
-----------------------------------
local chateauID          = zones[xi.zone.CHATEAU_DORAGUILLE]
local northernSandoriaID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS_SANDORIA2)

mission.reward = {}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHATEAU_DORAGUILLE] =
        {
            ['Halver'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 8 then
                        local needsHalverTrust = (not player:hasSpell(xi.magic.spell.HALVER) and not player:findItem(xi.item.CIPHER_OF_HALVERS_ALTER_EGO)) and 1 or 0

                        return mission:progressEvent(504, { [7] = needsHalverTrust })
                    else
                        return mission:messageText(chateauID.text.HALVER_OFFSET + 279)
                    end
                end,
            },

            onEventFinish =
            {
                [504] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 9)

                    if
                        not player:hasSpell(xi.magic.spell.HALVER) and
                        not player:findItem(xi.item.CIPHER_OF_HALVERS_ALTER_EGO)
                    then
                        npcUtil.giveItem(player, xi.item.CIPHER_OF_HALVERS_ALTER_EGO)
                    end
                end,
            },
        },

        [xi.zone.HORLAIS_PEAK] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 9 and
                        player:getLocalVar('battlefieldWin') == 999
                    then
                        npcUtil.giveKeyItem(player, xi.ki.KINDRED_CREST)
                        player:delKeyItem(xi.ki.DARK_KEY)
                        player:setMissionStatus(mission.areaId, 10)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Kasaroro'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 8 then
                        return mission:messageText(northernSandoriaID.text.KASARORO_DIALOG)
                    elseif missionStatus == 10 then
                        return mission:progressEvent(551)
                    end
                end,
            },

            onEventFinish =
            {
                [551] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:addMission(xi.mission.log_id.WINDURST, xi.mission.id.windurst.THE_THREE_KINGDOMS)
                        player:delKeyItem(xi.ki.KINDRED_CREST)
                        npcUtil.giveKeyItem(player, xi.ki.KINDRED_REPORT)
                        player:setMissionStatus(mission.areaId, 11)
                    end
                end,
            },
        },
    },
}

return mission
