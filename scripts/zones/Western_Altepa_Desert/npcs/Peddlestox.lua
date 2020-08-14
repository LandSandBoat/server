-----------------------------------
-- Area: Western Altepa Desert
--  NPC: Peddlestox
-- !pos 512.374 0.019 10.57 125
-- Active on EARTHSDAY in this zone. To test on off-days, setStatus(tpz.status.NORMAL)
-----------------------------------
local ID = require("scripts/zones/Western_Altepa_Desert/IDs")
require("scripts/globals/beastmentreasure")
-----------------------------------

function onTrigger(player)
    tpz.bmt.handleNpcOnTrigger(player, ID.npc.BEASTMEN_TREASURE)
end

function onTrade(player, npc, trade)
    tpz.bmt.handleNpcOnTrade(player, trade, ID.npc.BEASTMEN_TREASURE)
end

function onEventFinish(player, csid, option)
    tpz.bmt.handleNpcOnEventFinish(player, csid)
end
