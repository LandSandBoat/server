-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: ??? (Spawn Iriz Ima(ZNM T2))
-- !pos 253 -23 116 51
-----------------------------------
local ID = require("scripts/zones/Wajaom_Woodlands/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2577) and npcUtil.popFromQM(player, npc, ID.mob.IRIZ_IMA) then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.PAMAMA_PEELS)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
