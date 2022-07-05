-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Luca
-- Standard Info NPC
-- POS: -313.4284 -0.0228 -484.1256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(338)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
