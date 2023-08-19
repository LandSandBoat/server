-----------------------------------
-- Area: Jade Sepulcher
--  NPC: Ornamental Door
-- Involved in Missions: TOAU-29
-- !pos 299 0 -199 67
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
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
