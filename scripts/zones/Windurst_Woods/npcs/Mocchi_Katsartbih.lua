-----------------------------------
-- Area: Windurst Woods
--  NPC: Mocchi Katsartbih
-- Type: Standard NPC
-- !pos -13.225 -4.888 -164.108 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(264)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
