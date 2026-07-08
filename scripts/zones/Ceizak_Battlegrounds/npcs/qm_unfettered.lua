-----------------------------------
-- Zone: Ceizak Battlegrounds
-- NPC: qm_unfettered (???)
-- Spawns Unfettered Twitherym
-- !pos 210 0 115 261
-----------------------------------
local ID = zones[xi.zone.CEIZAK_BATTLEGROUNDS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.CELADON_YGGRETE_SHARD_I) and
        npcUtil.popFromQM(player, npc, ID.mob.UNFETTERED_TWITHERYM, { radius = 1 })
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.MONSTER_APPEAR)
    end
end

return entity
