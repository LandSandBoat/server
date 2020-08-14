-----------------------------------
-- Area: Xarcabard
--  NPC: Luck Rune
-- Involved in Quest: Mhaura Fortune
-- !pos 576.117 -0.164 -16.935 112
-----------------------------------
local ID = require("scripts/zones/Xarcabard/IDs")
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
