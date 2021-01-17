-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Fiaudie
-- !pos -10 1 35 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, 11054) -- (Couldn't find default text so i threw this in) So you feel there may be something amiss with our nation's current battle strategy
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
