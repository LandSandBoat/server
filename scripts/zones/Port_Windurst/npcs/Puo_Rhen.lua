-----------------------------------
-- Area: Port Windurst
--  NPC: Puo Rhen
-- Type: Mission Starter
-- !pos -227.964 -9 187.087 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(72)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
