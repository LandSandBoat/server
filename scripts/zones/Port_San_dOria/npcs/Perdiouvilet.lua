-----------------------------------
-- Area: Port San d'Oria
--  NPC: Perdiouvilet
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -59 -5 -29 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 10)
    then
        player:startEvent(750)
    else
        player:startEvent(762)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 750 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 10, true))
    end
end

return entity
