-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47n
-- !pos -40.811 -17.492 -140.000 151
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    npc:openDoor(6)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
