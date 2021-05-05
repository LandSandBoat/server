-----------------------------------
-- Area: Metalworks
--  NPC: Chantain
-- Type: Consulate Representative
-- !pos 21.729 -17 -30.888 237
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(203)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
