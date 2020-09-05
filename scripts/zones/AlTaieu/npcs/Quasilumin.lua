-----------------------------------
-- Area: Al'Taieu
--  NPC: Quasilumin
-- Type: Standard NPC
-- !pos -27.443 -1 -636.850 33
-----------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:showText(npc, ID.text.QUASILUMIN_01)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
