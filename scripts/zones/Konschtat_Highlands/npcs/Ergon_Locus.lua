-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Ergon Locus ???
-- Involved in quest Dances with Luopans
-- pos 220.041 24.451 309.234
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- DANCES WITH LUOPANS
    if
        player:getQuestStatus(xi.questLog.ADOULIN, xi.quest.id.adoulin.DANCES_WITH_LUOPANS) == xi.questStatus.QUEST_ACCEPTED and
        player:getNation() == xi.nation.BASTOK
    then
        if
            not player:hasKeyItem(xi.ki.FISTFUL_OF_HOMELAND_SOIL) and
            not player:hasKeyItem(xi.ki.LUOPAN)
        then
            npcUtil.giveKeyItem(player, xi.ki.FISTFUL_OF_HOMELAND_SOIL)
        end
    end
end

return entity
