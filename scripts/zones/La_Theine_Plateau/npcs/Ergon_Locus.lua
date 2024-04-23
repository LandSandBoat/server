-----------------------------------
-- Area: La Theine Plateau
--  NPC: Ergon Locus ???
-- Involved in quest Dances with Luopans
-- pos 420.399 24.389 28.734
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- DANCES WITH LUOPANS
    if
        player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.DANCES_WITH_LUOPANS) == xi.questStatus.QUEST_ACCEPTED and
        player:getNation() == xi.nation.SANDORIA
    then
        if
            not player:hasKeyItem(xi.ki.FISTFUL_OF_HOMELAND_SOIL) and
            not player:hasKeyItem(xi.ki.LUOPAN)
        then
            npcUtil.giveKeyItem(player, xi.ki.FISTFUL_OF_HOMELAND_SOIL)
        end
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
