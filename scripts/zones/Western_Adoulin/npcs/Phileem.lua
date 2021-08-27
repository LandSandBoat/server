-----------------------------------
-- Area: Western Adoulin
--  NPC: Phileem
-- Type: Standard NPC
-- !pos -20 0 -105 256
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard dialogue
    player:startEvent(537)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
