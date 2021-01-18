-----------------------------------
-- Area: Mhaura
--  NPC: Grimr
-- Type: Standard NPC
-- !pos 31.819 -11.001 22.311 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(120)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
