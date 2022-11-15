-----------------------------------
-- Area: Riverne Site #B01
--  NPC: qm_unstable_cluster (???)
-- Note: Spawns Unstable Cluster
-----------------------------------
local ID = require("scripts/zones/Riverne-Site_B01/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 1880) and
        npcUtil.popFromQM(player, npc, ID.mob.UNSTABLE_CLUSTER)
    then
        -- Clustered tar
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.GROUND_GIVING_HEAT)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
