-----------------------------------
-- Area: Windurst Woods
--  NPC: Chat Manual
-- Type: Tutorial NPC
-- !pos 10.928 1.915 -40.094 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(6106)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
