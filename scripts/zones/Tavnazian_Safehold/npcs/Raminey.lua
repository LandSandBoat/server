-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Raminey
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO: Needs verification
    player:startEvent(159)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
