-----------------------------------
-- Wings of the Goddess Helpers
-----------------------------------
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------

xi = xi or {}
xi.wotg = xi.wotg or {}
xi.wotg.helpers = xi.wotg.helpers or {}

xi.wotg.helpers.meetsMission3Reqs = function(player)
    local Q  = xi.quest.id.crystalWar
    local Q1 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.BURDEN_OF_SUSPICION)  == QUEST_COMPLETED
    local Q2 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.WRATH_OF_THE_GRIFFON) == QUEST_COMPLETED
    local Q3 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.A_MANIFEST_PROBLEM)   == QUEST_COMPLETED

    -- TODO: Add one day wait

    return Q1 or Q2 or Q3
end

xi.wotg.helpers.meetsMission8Reqs = function(player)
    local Q  = xi.quest.id.crystalWar
    local Q1 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.FIRE_IN_THE_HOLE)   == QUEST_COMPLETED
    local Q2 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.IN_A_HAZE_OF_GLORY) == QUEST_COMPLETED
    local Q3 = player:getQuestStatus(xi.quest.log_id.CRYSTAL_WAR, Q.A_FEAST_FOR_GNATS)  == QUEST_COMPLETED

    return Q1 or Q2 or Q3
end
