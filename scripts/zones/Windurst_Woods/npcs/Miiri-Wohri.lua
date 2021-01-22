-----------------------------------
-- Area: Windurst Woods
--  NPC: Miiri-Wohri
-- Type: Standard NPC
-- !pos 106.766 -6 -30.492 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(111)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
