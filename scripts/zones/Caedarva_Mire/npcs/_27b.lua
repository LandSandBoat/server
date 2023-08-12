-----------------------------------
-- Area: Caedarva Mire
--  NPC: Engraved Tablet
-- !pos -719 -13 765 79
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(305)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
