-----------------------------------
-- Area: Sacrificial Chamber
--  NPC: Mahogany Door
-- !pos -331 0.1 -300 163
-----------------------------------
local ID = require("scripts/zones/Sacrificial_Chamber/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.DOOR_SHUT)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
