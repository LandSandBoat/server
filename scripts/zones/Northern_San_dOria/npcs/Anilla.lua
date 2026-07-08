-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Anilla
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos 8 0.1 61 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 6)
    then
        player:startEvent(808)
    else
        player:startEvent(586)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 808 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 6, true))
    end
end

return entity
