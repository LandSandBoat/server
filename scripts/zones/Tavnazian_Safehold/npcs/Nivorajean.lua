-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Nivorajean
-- Type: Standard NPC
-- !pos 15.890 -22.999 13.322 26
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(221)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
