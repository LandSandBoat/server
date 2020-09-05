-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: ??? (Spawn Chigre(ZNM T1))
-- !pos -217 35 12 68
-----------------------------------
local ID = require("scripts/zones/Aydeewa_Subterrane/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2602) and npcUtil.popFromQM(player, npc, ID.mob.CHIGRE) then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.BLOOD_STAINS)
end
