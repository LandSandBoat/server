-----------------------------------
-- Zone: Ceizak Battlegrounds
-- NPC: qm_supernal (???)
-- Spawns Supernal Chapuli
-- !pos 278 0 -129 261
-----------------------------------
local ID = zones[xi.zone.CEIZAK_BATTLEGROUNDS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.CELADON_YGGRETE_SHARD_II) and
        npcUtil.popFromQM(player, npc, ID.mob.SUPERNAL_CHAPULI, { radius = 1 })
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.MONSTER_APPEAR)
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
