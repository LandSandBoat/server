-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Raginmund
-- Involved in Quest: Too Many Chefs
-- Location L-10
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('TOO_MANY_CHEFS') == 2 then
        player:startEvent(112) -- part 3 Too Many Chefs
    else
        player:startEvent(111) -- standard
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 112 then
        player:setCharVar('TOO_MANY_CHEFS', 3)
    end
end

return entity
