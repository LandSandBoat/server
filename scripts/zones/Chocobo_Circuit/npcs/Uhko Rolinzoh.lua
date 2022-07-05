-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Uhko Rolinzoh
-- Race Overview
-- pos -90.2532 -15.0901 -132.7964

-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(334)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity