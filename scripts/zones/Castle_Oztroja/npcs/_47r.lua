-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47r
-- !pos 20.000 24.168 -25.000 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.PROBABLY_WORKS_WITH_SOMETHING_ELSE)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
