-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Luck Rune
--  Involved in Quest: Mhaura Fortune
-- !pos -95.486 11.188 418.153 123
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
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
