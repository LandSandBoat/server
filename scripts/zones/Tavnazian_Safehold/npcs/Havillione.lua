-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Havillione
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO: Alternates between 383 and 320
    player:startEvent(320)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
