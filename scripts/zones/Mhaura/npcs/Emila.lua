-----------------------------------
-- Area: Mhaura
--  NPC: Emila
-- Type: Standard NPC
-- !pos -30.578 -9 26.342 249
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(324)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
