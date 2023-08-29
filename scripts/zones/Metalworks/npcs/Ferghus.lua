-----------------------------------
-- Area: Metalworks
--  NPC: Ferghus
-- Starts Quest: Too Many Chefs (1, 86)
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local tooManyChefs = player:getQuestStatus(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TOO_MANY_CHEFS)
    local pFame = player:getFameLevel(xi.quest.fame_area.BASTOK)

    if tooManyChefs == QUEST_AVAILABLE and pFame >= 5 then
        player:startEvent(946) -- Start Quest "Too Many Chefs"
    elseif player:getCharVar('TOO_MANY_CHEFS') == 4 then -- after trade to Leonhardt
        player:startEvent(947)
    else
        player:startEvent(420) -- Standard
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 946 and option == 0 then
        player:addQuest(xi.quest.log_id.BASTOK, xi.quest.id.bastok.TOO_MANY_CHEFS)
        player:setCharVar('TOO_MANY_CHEFS', 1)
    elseif csid == 947 then
        player:setCharVar('TOO_MANY_CHEFS', 5)
    end
end

return entity
