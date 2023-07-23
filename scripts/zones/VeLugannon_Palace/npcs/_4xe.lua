-----------------------------------
-- Area: VeLugannon Palace
--  NPC: Door (Blue)
-- !pos -60.000 -2.974 -360.000 177
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    return 0
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
