-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Pahpe Rauulih
-- Type: Standard NPC
-- !pos -39.740 -4.499 53.223 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(427)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
