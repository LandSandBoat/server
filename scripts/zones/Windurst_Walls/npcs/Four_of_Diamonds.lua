-----------------------------------
-- Area: Windurst Walls
--  NPC: Four of Diamonds
-- !pos -187.184 -3.545 151.092 239
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(267)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
