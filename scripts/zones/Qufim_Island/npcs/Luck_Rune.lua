-----------------------------------
-- Area: Qufim Island
--  NPC: Luck Rune
-- Involved in Quest: Mhaura Fortune
-- !pos -612.948 12.573 461.963 126
-----------------------------------
local ID = require("scripts/zones/Qufim_Island/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
