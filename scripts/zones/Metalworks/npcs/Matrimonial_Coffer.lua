-----------------------------------
-- Area: Metalworks
--  NPC: Matrimonial Coffer
-- Type: NPC
-- !pos 90.079 -20.170 -12.937 237
-----------------------------------
require("scripts/globals/matrimonialcoffer")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.matrimonialcoffer.startEvent(player)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    tpz.matrimonialcoffer.finishEvent(player, csid, option)
end
