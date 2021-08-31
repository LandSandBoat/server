-----------------------------------
-- Area: Bibiki Bay
--  NPC: Rhalo Davigoh
-- !pos -407 -3 -419 4
-----------------------------------
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(38)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
