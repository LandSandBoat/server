-----------------------------------
-- Area: Port Windurst
--  NPC: Boronene
-- Type: Moghouse Renter
-- !pos 201.651 -13 229.584 240
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(638)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
