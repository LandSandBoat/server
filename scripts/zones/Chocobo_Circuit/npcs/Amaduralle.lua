-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Amaduralle
-- Standard Info NPC
-- POS:-368.3278 -4.0000 -467.8141
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(241)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
