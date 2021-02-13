-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Choh Moui
-- !pos 30 2 -86 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(506)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
