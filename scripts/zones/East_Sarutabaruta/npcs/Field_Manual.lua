-----------------------------------
-- Area: East Sarutabaruta
--  NPC: Field Manual
-----------------------------------
require("scripts/globals/regimes")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    tpz.regime.bookOnTrigger(player, tpz.regime.type.FIELDS)
end

function onEventUpdate(player, csid, option)
    tpz.regime.bookOnEventUpdate(player, option, tpz.regime.type.FIELDS)
end

function onEventFinish(player, csid, option)
    tpz.regime.bookOnEventFinish(player, option, tpz.regime.type.FIELDS)
end
