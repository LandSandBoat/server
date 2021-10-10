-----------------------------------
-- While the Cat is Away
-- Wings of the Goddess Mission 5
-----------------------------------
-- !addmission 5 4
-- SOUTHERN_SAN_DORIA_S : !zone 80
-- EAST_RONFAURE_S      : !zone 81
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/maws')
require('scripts/globals/missions')
require('scripts/globals/quests')
require('scripts/settings/main')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.WHILE_THE_CAT_IS_AWAY)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.A_TIMESWEPT_BUTTERFLY },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.EAST_RONFAURE_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.SOUTHERN_SAN_DORIA_S then
                        return 7
                    end
                end,
            },

            onEventUpdate =
            {
                function(player, csid, option)
                    if csid == 7 then
                        local sandyFlag = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.BURDEN_OF_SUSPICION) == QUEST_COMPLETED and 1 or 0
                        local bastokFlag = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.WRATH_OF_THE_GRIFFON) == QUEST_COMPLETED and 1 or 0
                        local windyFlag = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, xi.quest.id.crystalWar.A_MANIFEST_PROBLEM) == QUEST_COMPLETED and 1 or 0
                        local rovFlag = player:getMissionStatus(xi.mission.log_id.ROV, xi.mission.id.rov.GANGED_UP_ON) == QUEST_ACCEPTED and 1 or 0

                        player:updateEvent(sandyFlag, bastokFlag, windyFlag, rovFlag)
                    end
                end,
            },

            onEventFinish =
            {
                [7] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
