-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Lurouillat
-- !pos 44 2 -35 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(350)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
