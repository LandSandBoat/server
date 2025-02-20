-----------------------------------
-- Zone: Ceizak Battlegrounds
-- NPC: qm_taxet (???)
-- Spawns Tax'et
-- !pos -280 0 -290 261
-----------------------------------
local ID = zones[xi.zone.CEIZAK_BATTLEGROUNDS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.CELADON_YGGRETE_SHARD_V) and
        npcUtil.popFromQM(player, npc, ID.mob.TAXET, { radius = 1 })
    then
        player:confirmTrade()
    end
end

return entity
