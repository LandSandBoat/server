-----------------------------------
-- Area: Batallia Downs
--  NPC: Luck Rune
--  Involved in Quest: Mhaura Fortune
-- !pos -362.167 -12.199 157.158 105
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
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
