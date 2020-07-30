-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: Peddlestox
-- !pos -103.286 0.6 434.866 123
-- Active on WINDSDAY in this zone. To test on off-days, setStatus(tpz.status.NORMAL)
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
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
