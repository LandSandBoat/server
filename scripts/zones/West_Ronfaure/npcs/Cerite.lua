-----------------------------------
-- Area: West Ronfaure
--  NPC: Cerite
-- !pos -263.577 -72.999 425.885 100
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(50)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
