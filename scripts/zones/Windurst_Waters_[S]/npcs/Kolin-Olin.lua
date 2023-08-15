-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Kolin-Olin
-- !pos 9.981 -2.478 33.786 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(306)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
