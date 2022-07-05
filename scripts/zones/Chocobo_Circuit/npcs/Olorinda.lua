-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Olorinda
-- Race Overview
-- pos -114.7143 -14.500 -132.5795

-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(333)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity