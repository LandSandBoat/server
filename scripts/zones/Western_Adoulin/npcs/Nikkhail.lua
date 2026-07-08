-----------------------------------
-- Area: Western Adoulin
--  NPC: Nikkhail
--  Involved With Quest: 'A Thirst for the Ages'
-- !pos -101 3 9 256
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local atfta = player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.A_THIRST_FOR_THE_AGES)
    local atftaNeedKI = player:getCharVar('ATFTA_Status') < 2 and not player:hasKeyItem(xi.ki.COPY_OF_THE_ALLIANCE_AGREEMENT)
    local soaMission = player:getCurrentMission(xi.mission.log_id.SOA)

    if soaMission >= xi.mission.id.soa.LIFE_ON_THE_FRONTIER then
        if atfta == xi.questStatus.QUEST_ACCEPTED and atftaNeedKI then
            -- Progresses Quest: 'A Thirst for the Ages'
            player:startEvent(5053)
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5053 then
        npcUtil.giveKeyItem(player, xi.ki.COPY_OF_THE_ALLIANCE_AGREEMENT)
    end
end

return entity
