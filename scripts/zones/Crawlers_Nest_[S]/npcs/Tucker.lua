-----------------------------------
-- Area: Crawlers' Nest [S]
--  NPC: Tucker
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    player:startEvent(14) -- doesn't want your trade dialog
end

entity.onTrigger = function(player, npc)
    player:startEvent(15) -- rolanberry history dialog
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
