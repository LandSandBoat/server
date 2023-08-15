-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ranna-Brunna
-- !pos 123.085 -8.874 223.734 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(424)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
