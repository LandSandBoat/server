-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Phairupegiont
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -46 0.1 76 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 8)
    then
        player:startEvent(806)
    else
        player:startEvent(663)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 806 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 8, true))
    end
end

return entity
