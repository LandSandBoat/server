-----------------------------------
-- Zone: Ceizak Battlegrounds
-- NPC: qm_mastop (???)
-- Spawns Mastop
-- !pos -230 0 36 261
-----------------------------------
local ID = zones[xi.zone.CEIZAK_BATTLEGROUNDS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.CELADON_YGGRETE_SHARD_IV) and
        npcUtil.popFromQM(player, npc, ID.mob.MASTOP, { radius = 1 })
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
