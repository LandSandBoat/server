-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Khatri
-- Standard Info NPC
-- POS: -324.7060 -0.0232 -485.2488
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(339)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
