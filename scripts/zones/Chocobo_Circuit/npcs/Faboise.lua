-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Faboise
-- Standard Info NPC
-- Pos -269.0847 -4.0000 -496.0561
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(239)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
