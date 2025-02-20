-----------------------------------
-- Area: Port San d'Oria
--  NPC: Rugiette
-- Involved in Quests: Riding on the Clouds, Lure of the Wildcat (San d'Oria)
-- !pos 71 -9 -73 232
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local wildcatSandy = player:getCharVar('WildcatSandy')

    if
        player:getQuestStatus(xi.questLog.SANDORIA, xi.quest.id.sandoria.LURE_OF_THE_WILDCAT) == xi.questStatus.QUEST_ACCEPTED and
        not utils.mask.getBit(wildcatSandy, 14)
    then
        player:startEvent(746)
    else
        player:startEvent(601)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 746 then
        player:setCharVar('WildcatSandy', utils.mask.setBit(player:getCharVar('WildcatSandy'), 14, true))
    end
end

return entity
