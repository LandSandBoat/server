-----------------------------------
-- Area: Al Zahbi
--  NPC: Djinabaha
-- Type: AH Manager
-- !pos -17.661 -1 -117.352 48
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(209)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
