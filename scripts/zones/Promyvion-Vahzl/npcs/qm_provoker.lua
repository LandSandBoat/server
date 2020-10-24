-----------------------------------
-- Area: Promyvion-Vahzl
--  NPC: ???
-- Notes: Spawn Provoker Floor 5
-- !pos -260.000 -0.003 72.000 22
-----------------------------------
local ID = require("scripts/zones/Promyvion-Vahzl/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1758) and npcUtil.popFromQM(player, npc, ID.mob.PROVOKER) then -- Satiator Remnant
        player:messageSpecial(ID.text.ON_NM_SPAWN)
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.POPPED_NM_OFFSET + 2)
end
