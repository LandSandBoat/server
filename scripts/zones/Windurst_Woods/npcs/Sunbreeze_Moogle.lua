-----------------------------------
-- Area: Windurst Woods
--  NPC: Moogle
-- Type: Special Events Moogle
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- 2004 Era event unkown
    player:startEvent(32711)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
