-----------------------------------
-- Area: Konschtat Highlands
--  NPC: Signpost
-- !pos 387 32 386 108
-----------------------------------
local ID = require("scripts/zones/Konschtat_Highlands/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.SIGNPOST2)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
