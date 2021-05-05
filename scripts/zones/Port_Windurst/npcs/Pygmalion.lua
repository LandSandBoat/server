-----------------------------------
-- Area: Port Windurst
--  NPC: Pygmalion
-- Type: Standard NPC
-- !pos 228.710 -7 93.314 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10019)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
