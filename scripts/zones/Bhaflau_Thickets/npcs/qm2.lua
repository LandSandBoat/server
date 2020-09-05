-----------------------------------
-- Area: Bhaflau Thickets
--  NPC: ??? (Spawn Dea(ZNM T3))
-- !pos -34 -32 481 52
-----------------------------------
local ID = require("scripts/zones/Bhaflau_Thickets/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2576) and npcUtil.popFromQM(player, npc, ID.mob.DEA) then -- Olzhiryan Cactus
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
