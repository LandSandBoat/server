-----------------------------------
-- Area: Windurst Walls
--  NPC: Enigmatic Footprints
-- Entry NPC for Dynamis Divergence
-----------------------------------
local ID = require("scripts/zones/Windurst_Walls/IDs")
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
