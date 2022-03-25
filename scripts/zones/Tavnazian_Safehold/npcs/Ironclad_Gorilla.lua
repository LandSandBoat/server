-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Ironclad Gorilla
-- Standard Info NPC
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- First entry into Tavnazian Safehold only shows 305, TODO: Find when 306 comes into play
    -- player:startEvent(306)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
