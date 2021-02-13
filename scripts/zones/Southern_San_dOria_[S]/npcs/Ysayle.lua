-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Ysayle
-- !pos 112 0 100 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(600)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
