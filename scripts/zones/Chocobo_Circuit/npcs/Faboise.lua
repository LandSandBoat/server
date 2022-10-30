-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Faboise
-- !pos -270.953 -4.000 -495.218 70
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
