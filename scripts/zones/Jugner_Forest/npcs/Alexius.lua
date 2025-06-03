-----------------------------------
-- Area: Jugner Forest
--  NPC: Alexius
-- Involved in Quest: A purchase of Arms & Sin Hunting
-- !pos 105 1 382 104
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('sinHunting') == 3 then
        player:startEvent(10)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10 then
        player:setCharVar('sinHunting', 4)
    end
end

return entity
