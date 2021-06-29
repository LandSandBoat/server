-----------------------------------
-- Area: North Gustaberg [S] (88)
--  NPC: Stonehoused_Adit
-- !pos -434.655 36.708 279.983 88
-----------------------------------
require("scripts/globals/instance")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.instance.onTrigger(player, npc, xi.zones.RUHOTZ_SILVERMINES, 203)
end

entity.onEventUpdate = function(player, csid, option)
    xi.instance.onEventUpdate(player,  csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.instance.onEventFinish(player, csid, option)
end

return entity
