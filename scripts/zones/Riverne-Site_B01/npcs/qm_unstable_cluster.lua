-----------------------------------
-- Area: Riverne Site #B01
--  NPC: qm_unstable_cluster (???)
-- Note: Spawns Unstable Cluster
-----------------------------------
local ID = zones[xi.zone.RIVERNE_SITE_B01]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.POT_OF_CLUSTERED_TAR) and
        npcUtil.popFromQM(player, npc, ID.mob.UNSTABLE_CLUSTER)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.GROUND_GIVING_HEAT)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
