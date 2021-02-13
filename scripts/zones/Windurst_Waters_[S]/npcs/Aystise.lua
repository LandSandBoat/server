-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Aystise
-- Type: Standard NPC
-- !pos -69.805 -4.5 68.078 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(410)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
