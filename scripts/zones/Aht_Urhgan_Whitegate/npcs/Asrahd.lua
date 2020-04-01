-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Asrahd
-- Type: Imperial Gate Guard
-- !pos 0.011 -1 10.587 50
-----------------------------------
require("scripts/globals/besieged")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.besieged.onTrigger(player, npc, 630)
end

function onEventUpdate(player, csid, option)
    tpz.besieged.onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.besieged.onEventFinish(player, csid, option)
end
