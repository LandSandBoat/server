-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Thirkell
-- !pos 102 1 109 80
-- Allied Notes Notorious Monster Proprietor
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(93)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
