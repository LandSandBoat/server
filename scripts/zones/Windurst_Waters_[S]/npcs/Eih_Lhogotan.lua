-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Eih Lhogotan
-- !pos -29.887 -5.999 91.042 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(407)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
