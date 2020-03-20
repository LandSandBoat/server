-----------------------------------
-- Area: Nashmau
--  NPC: Nabihwah
-- Type: Imperial Gate Guard
-- !pos 9.988 -7 68.585 53
-----------------------------------
require("scripts/globals/besieged")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.besieged.onTrigger(player, npc, 253)
end

function onEventUpdate(player, csid, option)
    tpz.besieged.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.besieged.onEventFinish(player, csid, option)
end
