-----------------------------------
-- Area: Pashhow Marshlands
--  NPC: Luck Rune
--  Involved in Quest: Mhaura Fortune
-- !pos 573.245 24.999 199.560 109
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands/IDs")
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
