-----------------------------------
-- Area: Metalworks
--  NPC: Invincible Shield
-- Type: Ballista
-- !pos -51.083 -11 2.126 237
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(810)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
