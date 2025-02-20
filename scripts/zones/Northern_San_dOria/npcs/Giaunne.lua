-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Giaunne
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -13 0 36 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 5)
    then
        player:startEvent(805)
    else
        player:startEvent(667)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 805 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 5, true))
    end
end

return entity
