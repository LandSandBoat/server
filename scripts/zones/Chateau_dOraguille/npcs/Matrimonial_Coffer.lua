-----------------------------------
-- Area: Chateau d'Oraguille
--  NPC: Matrimonial Coffer
-- Type: NPC
-- !pos -7.777 0.000 3.013 233
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
