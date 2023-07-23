-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Ironclad Gorilla
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- First entry into Tavnazian Safehold only shows 305,
    -- 306 first observed in One to be Feared, verify if it persists.
    -- player:startEvent(306)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
