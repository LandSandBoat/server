-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pahpe Rauulih
-- !pos -39.740 -4.499 53.223 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(427)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
