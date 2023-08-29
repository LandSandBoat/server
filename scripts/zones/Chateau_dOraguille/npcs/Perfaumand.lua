-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Perfaumand
-- Involved in Quest: Lure of the Wildcat (San d'Oria)
-- !pos -39 -3 69 233
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    -- "Lure of the Wildcat"
    if
        player:getQuestStatus(xi.quest.log_id.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 18)
    then
        player:startEvent(560)

    else
        player:startEvent(522)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 560 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 18, true))
    end
end

return entity
