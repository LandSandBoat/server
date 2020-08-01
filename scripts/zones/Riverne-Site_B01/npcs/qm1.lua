-----------------------------------
-- Area: Riverne Site #B01
--  NPC: qm1 (???)
-- Note: Spawns Unstable Cluster
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1880) and npcUtil.popFromQM(player, npc, ID.mob.UNSTABLE_CLUSTER) then -- Clustered tar
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.GROUND_GIVING_HEAT)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
