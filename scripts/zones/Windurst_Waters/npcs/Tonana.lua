-----------------------------------
-- Area: Windurst Waters
--  NPC: Tonana
-- Warps players to Windurst Woods
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(571)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if option == 1 then
        player:setPos(108.744, -4.999, -134.094, 222, 241) -- (Retail packet captured)
    end
end

return entity
