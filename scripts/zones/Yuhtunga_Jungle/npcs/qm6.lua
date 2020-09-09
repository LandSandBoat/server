-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: ??? (Beastmen Treasure qm6/chest3)
-- !pos -539.311 -0.168 203.151 123
-----------------------------------
local ID = require("scripts/zones/Yuhtunga_Jungle/IDs")
require("scripts/globals/beastmentreasure")
-----------------------------------

function onTrigger(player, npc)
    tpz.bmt.handleQmOnTrigger(player, npc, ID.text.SOMETHING_IS_BURIED_HERE, ID.text.NOTHING_OUT_OF_ORDINARY, ID.npc.BEASTMEN_TREASURE)
end

function onTrade(player, npc, trade)
    tpz.bmt.handleQmOnTrade(player, npc, trade, ID.npc.BEASTMEN_TREASURE)
end

function onEventFinish(player, csid)
    tpz.bmt.handleQmOnEventFinish(player, csid)
end
