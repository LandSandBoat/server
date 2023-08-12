-----------------------------------
-- Area: Selbina
--  NPC: Gabwaleid
-- Involved in Quest: Riding on the Clouds
-- !pos -17 -7 11 248
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(600)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
