-----------------------------------
-- Area: Port San d'Oria
--  NPC: Parcarin
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -9 -13 -151 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(player:getCharVar('WildcatSandy'), 13)
    then
        player:startEvent(747)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 747 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 13, true))
    end
end

return entity
