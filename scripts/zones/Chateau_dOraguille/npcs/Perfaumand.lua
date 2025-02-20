-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Perfaumand
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -39 -3 69 233
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    -- "Lure of the Wildcat"
    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 18)
    then
        player:startEvent(560)

    else
        player:startEvent(522)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 560 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 18, true))
    end
end

return entity
