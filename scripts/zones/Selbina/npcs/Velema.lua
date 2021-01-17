-----------------------------------
-- Area: Selbina
--  NPC: Velema
-- Type: Standard NPC
-- !pos 28.164 -3.947 -12.788 248
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
