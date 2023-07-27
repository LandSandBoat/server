-----------------------------------
-- Area: Windurst Walls
--  NPC: Komulili
-- Warps players to Port Windurst
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
        player:setPos(-111.919, -8.75, 92.093, 62, 240) -- (R)
    end
end

return entity
