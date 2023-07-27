-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Cannau
-- Type: Escort NPC
-- !pos 419.838 -56.999 -114.870 195
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(51)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
