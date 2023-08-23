-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Nivorajean
-- !pos 15.890 -22.999 13.322 26
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- TODO: Default cycles between 221 and 382, 382 in Default
    player:startEvent(221)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
