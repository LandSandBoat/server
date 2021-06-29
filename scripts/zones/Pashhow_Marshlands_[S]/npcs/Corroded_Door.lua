-----------------------------------
-- Area: Pashhow Marshlands [S] (90)
--  NPC: Corroded Door
-- !pos -385.602 21.970 456.359 90
-----------------------------------
require("scripts/globals/instance")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.instance.onTrigger(player, npc, xi.zones.RUHOTZ_SILVERMINES, 3)
end

entity.onEventUpdate = function(player, csid, option)
    xi.instance.onEventUpdate(player,  csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.instance.onEventFinish(player, csid, option)
end

return entity
