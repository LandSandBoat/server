-----------------------------------
-- Area: Yuhtunga Jungle
--  NPC: ??? (Beastmen Treasure qm8/chest5)
-- !pos -361.835 15.695 -399.517 123
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
