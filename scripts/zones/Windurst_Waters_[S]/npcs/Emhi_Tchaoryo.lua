-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Emhi Tchaoryo
-- Type: Campaign Ops Overseer
-- !pos 10.577 -2.478 32.680 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(307)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
