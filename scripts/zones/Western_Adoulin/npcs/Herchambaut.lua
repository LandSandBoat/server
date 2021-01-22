-----------------------------------
-- Area: Western Adoulin
--  NPC: Herchambaut
-- Type: Standard NPC
-- !pos 95 0 -47 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(572)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
