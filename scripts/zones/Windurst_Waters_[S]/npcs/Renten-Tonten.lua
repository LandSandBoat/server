-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Renten-Tonten
-- Type: Standard NPC
-- !pos 133.840 -6.75 173.305 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(421)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
