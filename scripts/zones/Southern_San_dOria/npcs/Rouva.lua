-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rouva
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -17 2 10 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 2)
    then
        player:startEvent(808)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 808 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 2, true))
    end
end

return entity
