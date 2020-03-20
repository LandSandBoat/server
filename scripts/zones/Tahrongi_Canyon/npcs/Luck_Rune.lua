-----------------------------------
-- Area: Tahrongi Canyon
--  NPC: Luck Rune
-- Involved in Quest: Mhaura Fortune
-- !pos -54.755 7.647 -379.945 117
-----------------------------------
local ID = require("scripts/zones/Tahrongi_Canyon/IDs")
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
