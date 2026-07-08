-----------------------------------
-- Area: Riverne Site #B01
--  NPC: qm_unstable_cluster (???)
-- Note: Spawns Unstable Cluster
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.POT_OF_CLUSTERED_TAR) and
        npcUtil.popFromQM(player, npc, ID.mob.UNSTABLE_CLUSTER)
    then
        player:confirmTrade()
    end
end

return entity
