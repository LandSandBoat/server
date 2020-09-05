-----------------------------------
-- Area: VeLugannon Palace
--  NPC: qm2 (???)
-- Note: Used to spawn Brigandish Blade
-- !pos 0.1 0.1 -286 177
-----------------------------------
local ID = require("scripts/zones/VeLugannon_Palace/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 16575) and npcUtil.popFromQM(player, npc, ID.mob.BRIGANDISH_BLADE) then
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:startEvent(2)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
