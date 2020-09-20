-----------------------------------
-- Area: Arrapago Reef
--  NPC: ??? (Spawn Zareehkl the Jubilant(ZNM T2))
-- !pos 176 -4 182 54
-----------------------------------
local ID = require("scripts/zones/Arrapago_Reef/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2598) and npcUtil.popFromQM(player, npc, ID.mob.ZAREEHKL_THE_JUBILANT) then -- Trade Merow No 11 Molting
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_HAPPENS)
end
