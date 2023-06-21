-----------------------------------
-- The Emissary San d'Oria
-- Bastok M2-3 (Part 2)
-----------------------------------
-- !addmission 1 8
-- Baraka  : !pos 36 -2 -2 231
-- Helaku  : !pos 49 -2 -12 231
-- Halver  : !pos 2 0.1 0.1 233
-----------------------------------
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local chateauID       = require('scripts/zones/Chateau_dOraguille/IDs')
local northSandoriaID = require('scripts/zones/Northern_San_dOria/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY_SANDORIA2)

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
                        local needsHalverTrust = (not player:hasSpell(972) and not player:findItem(xi.items.CIPHER_OF_HALVERS_ALTER_EGO)) and 1 or 0

                        return mission:progressEvent(503, { [7] = needsHalverTrust })
                    elseif missionStatus <= 10 then
                        return mission:messageText(chateauID.text.HALVER_OFFSET + 279)
                    end
                end,
            },

            onEventFinish =
            {
                [503] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 9)

                    if
                        not player:hasSpell(972) and
                        not player:findItem(xi.items.CIPHER_OF_HALVERS_ALTER_EGO)
                    then
                        npcUtil.giveItem(player, xi.items.CIPHER_OF_HALVERS_ALTER_EGO)
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
                        player:setMissionStatus(mission.areaId, 10)
                    end
                end,
            },
        },

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Helaku'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.KINDRED_CREST) then
                        return mission:progressEvent(545)
                    else
                        return mission:messageText(northSandoriaID.text.HELAKU_DIALOG + 16)
                    end
                end,
            },

            ['Shakir'] = mission:event(538),

            onEventFinish =
            {
                [545] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:addMission(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_EMISSARY)
                        player:setMissionStatus(mission.areaId, 11)
                        player:delKeyItem(xi.ki.KINDRED_CREST)
                        npcUtil.giveKeyItem(player, xi.ki.KINDRED_REPORT)
                    end
                end,
            },
        },
    },
}

return mission
