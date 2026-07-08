-----------------------------------
-- Area: Port San d'Oria
--  NPC: Cherlodeau
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -20 -4 -69 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 12)
    then
        player:startEvent(748)
    else
        player:startEvent(590)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 748 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 12, true))
    end
end

return entity
