-----------------------------------
-- Area: Windurst Woods
--  NPC: Mocchi Katsartbih
-- !pos -13.225 -4.888 -164.108 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(264)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
