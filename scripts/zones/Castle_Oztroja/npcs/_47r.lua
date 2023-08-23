-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47r
-- !pos 20.000 24.168 -25.000 151
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.PROBABLY_WORKS_WITH_SOMETHING_ELSE)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
