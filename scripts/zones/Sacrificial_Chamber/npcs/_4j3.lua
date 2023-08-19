-----------------------------------
-- Area: Sacrificial Chamber
--  NPC: Mahogany Door
-- !pos 19 -1 -4 163
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.bcnm.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.bcnm.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, extras)
    xi.bcnm.onEventUpdate(player, csid, option, extras)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.bcnm.onEventFinish(player, csid, option, npc)
end

return entity
