-----------------------------------
-- Cait Sith
-- Wings of the Goddess Mission 3
-----------------------------------
-- TODO:
-- !addmission 4 0
-- Cavernous Maws:
-- Batallia Downs       : !pos -48 0.1 435 105
-- Rolanberry Fields    : !pos -198 8 361 110
-- Sauromugue Champaign : !pos 369 8 -227 120
-----------------------------------
require("scripts/globals/keyitems")
require('scripts/globals/maws')
require('scripts/globals/missions')
require('scripts/globals/quests')
require('scripts/globals/settings')
require('scripts/globals/titles')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WOTG, xi.mission.id.wotg.CAIT_SITH)

mission.reward =
{
    nextMission = { xi.mission.log_id.WOTG, xi.mission.id.wotg.THE_QUEEN_OF_THE_DANCE },
    title = xi.title.CAIT_SITHS_ASSISTANT,
}

local meetsMission3Reqs = function(player)
    local Q  = xi.quest.id.crystalWar
    local Q1 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.BURDEN_OF_SUSPICION)  == QUEST_COMPLETED
    local Q2 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.WRATH_OF_THE_GRIFFON) == QUEST_COMPLETED
    local Q3 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.A_MANIFEST_PROBLEM)   == QUEST_COMPLETED

    -- TODO: Add one day wait

    return Q1 or Q2 or Q3
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                   meetsMission3Reqs(player)
        end,

        [xi.zone.SOUTHERN_SAN_DORIA_S] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if prevZone == xi.zone.EAST_RONFAURE_S then
                        return mission:event(510)
                    end
                end,
            },

            onEventFinish =
            {
                [510] = function(player, csid, option, npc)
                    if mission:complete() then
                        return mission:event(514)
                    end
                end,
            },
        },
    },
}

return mission
