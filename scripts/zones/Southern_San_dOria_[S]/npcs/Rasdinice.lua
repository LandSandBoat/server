-----------------------------------
-- Area: Southern SandOria [S]
--  NPC: Rasdinice
-- !pos -8 1 35 80
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:showText(npc, 11637) -- (Couldn't find default text so i threw this in) Perhaps you should first attend to more pressing matters...
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
