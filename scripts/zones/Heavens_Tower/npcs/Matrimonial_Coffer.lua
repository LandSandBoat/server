-----------------------------------
-- Area: Heavens Tower
--  NPC: Matrimonial Coffer
-- Type: NPC
-- !pos -5.955 0.249 24.360 242
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
