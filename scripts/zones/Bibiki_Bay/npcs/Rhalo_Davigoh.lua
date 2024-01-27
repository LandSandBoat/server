-----------------------------------
-- Area: Bibiki Bay
--  NPC: Rhalo Davigoh
-- !pos -407 -3 -419 4
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(38)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
