-----------------------------------
-- Zone: Ceizak Battlegrounds
-- NPC: qm_transcendent_s (???)
-- Spawns Transcendent Scorpion
-- !pos 160 0 -400 261
-----------------------------------
local ID = zones[xi.zone.CEIZAK_BATTLEGROUNDS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.CELADON_YGGRETE_SHARD_III) and
        npcUtil.popFromQM(player, npc, ID.mob.TRANSCENDENT_SCORPION, { radius = 1 })
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.MONSTER_APPEAR)
    end
end

return entity
