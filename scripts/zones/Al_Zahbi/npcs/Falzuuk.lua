-----------------------------------
-- Area: Al Zahbi
--  NPC: Falzuuk
-- Type: Imperial Gate Guard
-- !pos -60.486 0.999 105.397 48
-----------------------------------
require("scripts/globals/besieged")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.besieged.onTrigger(player, npc, 216)
end

function onEventUpdate(player, csid, option)
    tpz.besieged.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.besieged.onEventFinish(player, csid, option)
end
