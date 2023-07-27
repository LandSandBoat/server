-----------------------------------
-- Area: VeLugannon Palace
--  NPC: Door (Yellow)
-- !pos 80.000 -2.974 460.000 177
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
