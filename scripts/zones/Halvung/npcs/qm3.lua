-----------------------------------
-- Area: Halvung
--  NPC: ??? (Spawn Reacton(ZNM T2))
-- !pos 18 -9 213 62
-----------------------------------
local ID = require("scripts/zones/Halvung/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 2588) and npcUtil.popFromQM(player, npc, ID.mob.REACTON) then -- Bone Charcoal
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
