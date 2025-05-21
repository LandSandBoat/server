-----------------------------------
-- Area: Metalworks
--  NPC: Ferghus
-- Starts Quest: Too Many Chefs (1, 86)
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local tooManyChefs = player:getQuestStatus(xi.questLog.BASTOK, xi.quest.id.bastok.TOO_MANY_CHEFS)
    local pFame = player:getFameLevel(xi.fameArea.BASTOK)

    if tooManyChefs == xi.questStatus.QUEST_AVAILABLE and pFame >= 5 then
        player:startEvent(946) -- Start Quest "Too Many Chefs"
    elseif player:getCharVar('TOO_MANY_CHEFS') == 4 then -- after trade to Leonhardt
        player:startEvent(947)
    else
        player:startEvent(420) -- Standard
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 946 and option == 0 then
        player:addQuest(xi.questLog.BASTOK, xi.quest.id.bastok.TOO_MANY_CHEFS)
        player:setCharVar('TOO_MANY_CHEFS', 1)
    elseif csid == 947 then
        player:setCharVar('TOO_MANY_CHEFS', 5)
    end
end

return entity
