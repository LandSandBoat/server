-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Narito-Pettito
-- !pos -52.674 -5.999 90.403 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(425)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
