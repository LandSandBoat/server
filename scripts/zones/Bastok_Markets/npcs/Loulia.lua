-----------------------------------
-- Area: Bastok Markets
--  NPC: Loulia
-- Type: Room Renters
-- !pos -176.212 -9 -25.049 235
-----------------------------------
-- Auto-Script: Requires Verification. Validated standard dialog - thrydwolf 12/8/2011
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(487)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
