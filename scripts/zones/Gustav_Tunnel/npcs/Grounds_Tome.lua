-----------------------------------
-- Area: Gustav Tunnel
--  NPC: Grounds Tome
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.regime.bookOnTrigger(player, tpz.regime.type.GROUNDS)
end

function onEventUpdate(player, csid, option)
    tpz.regime.bookOnEventUpdate(player, option, tpz.regime.type.GROUNDS)
end

function onEventFinish(player, csid, option)
    tpz.regime.bookOnEventFinish(player, option, tpz.regime.type.GROUNDS)
end
