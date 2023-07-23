-----------------------------------
-- Area: Kuftal Tunnel
--  NPC: Hawk Nose
-- Type: Quest NPC
-- !pos .1 -1 .1 174
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(14)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
