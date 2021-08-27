-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Perisa-Neburusa
-- Type: Residence Renter
-- !pos 54.651 8.999 -74.372 243
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(76)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
