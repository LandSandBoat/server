-----------------------------------
-- Area: Phanauet Channel
--  NPC: Laiteconce
-- Type: Standard NPC
-- !pos 4.066 -4.5 -10.450 1
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(1)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
