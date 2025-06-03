-----------------------------------
-- Area: Port Windurst
-- Machu-Kuchu
-- Warps players to Windurst Walls
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(338)
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        player:setPos(65.534, -7.5, -49.935, 59, 239)
    end
end

return entity
