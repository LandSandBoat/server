-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Latteaune
-- Type: Event Scene Replayer
-- !pos -16.426 -28.889 109.626 26
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(100)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
