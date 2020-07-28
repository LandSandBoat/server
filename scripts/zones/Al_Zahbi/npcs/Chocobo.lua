-----------------------------------
-- Area: Al Zahbi
--  NPC: Chocobo
-----------------------------------
local ID = require("scripts/zones/Al_Zahbi/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    npc:showText(npc, ID.text.CHOCOBO_HAPPY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
