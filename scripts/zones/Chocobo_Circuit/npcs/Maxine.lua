-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Maxine
-- !pos -492.890 0.000 -530.576 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(352)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
