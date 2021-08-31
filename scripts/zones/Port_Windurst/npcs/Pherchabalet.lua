-----------------------------------
-- Area: Port Windurst
--  NPC: Pherchabalet
-- Type: Standard NPC
-- !pos 34.683 -5.999 137.447 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(553)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
