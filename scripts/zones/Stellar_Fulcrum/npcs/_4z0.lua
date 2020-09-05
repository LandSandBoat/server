-----------------------------------
-- Area: Stellar Fulcrum
-- Door: Qe'Lov Gate
-- !pos -520 -4 17 179
-------------------------------------

require("scripts/globals/bcnm")

function onTrade(player, npc, trade)
    TradeBCNM(player, npc, trade)
end

function onTrigger(player, npc)
    EventTriggerBCNM(player, npc)
end

function onEventUpdate(player, csid, option, extras)
    EventUpdateBCNM(player, csid, option, extras)
end

function onEventFinish(player, csid, option)
    EventFinishBCNM(player, csid, option)
end
