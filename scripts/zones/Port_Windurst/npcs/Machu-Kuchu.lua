-----------------------------------
-- Area: Port Windurst
-- Machu-Kuchu
-- Warps players to Windurst Walls
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(338)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        player:setPos(65.534, -7.5, -49.935, 59, 239) -- Retail packet capped
    end
end

return entity
