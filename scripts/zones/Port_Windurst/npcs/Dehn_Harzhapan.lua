-----------------------------------
-- Area: Port Windurst
--  NPC: Dehn Harzhapan
-- Type: Standard NPC
-- !pos -7.974 -7 152.633 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(10018)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
