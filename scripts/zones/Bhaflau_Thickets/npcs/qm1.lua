-----------------------------------
-- Area: Bhaflau Thickets
--  NPC: ??? (Spawn Lividroot Amooshah(ZNM T2))
-- !pos 334 -10 184 52
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2578) and npcUtil.popFromQM(player, npc, ID.mob.LIVIDROOT_AMOOSHAH) then -- Oily Blood
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
