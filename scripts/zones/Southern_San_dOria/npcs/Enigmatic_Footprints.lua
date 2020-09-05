-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Enigmatic Footprints
-- Entry NPC for Dynamis Divergence
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.TEAR_IN_FABRIC_OF_SPACE)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
