-----------------------------------
-- Area: Kazham
--  NPC: Beyzen
-- Type: Event Scene Replayer
-- !pos -53.976 -10.769 -74.771 250
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(278)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
