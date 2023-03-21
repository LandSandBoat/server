-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Fhaht Beablrucch
-- !pos -311.756 -4.000 -419.103 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(212, 213, 214, 215, 219, 223, 228, 234)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
