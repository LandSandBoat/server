-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47r
-- !pos 20.000 24.168 -25.000 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
-----------------------------------

function onTrigger(player, npc)
    player:messageSpecial(ID.text.PROBABLY_WORKS_WITH_SOMETHING_ELSE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
