-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Frescheque
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(151) -- TODO: Verify, this would occur after "A Bitter Past" if its default
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
