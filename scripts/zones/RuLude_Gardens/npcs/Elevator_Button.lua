-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Elevator Button
-- Mog House Enterance
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if xi.moghouse.isRented(player) then
        player:startEvent(75)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
