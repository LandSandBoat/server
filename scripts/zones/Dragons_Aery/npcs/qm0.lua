-----------------------------------
-- Area: Dragons Aery
--  NPC: qm0 (???)
-- Spawns Fafnir or Nidhogg
-- !pos -81 32 2 178
-----------------------------------
local ID = zones[xi.zone.DRAGONS_AERY]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        not GetMobByID(ID.mob.FAFNIR):isSpawned() and
        not GetMobByID(ID.mob.NIDHOGG):isSpawned()
    then
        if
            npcUtil.tradeHasExactly(trade, xi.item.JUG_OF_HONEY_WINE) and
            npcUtil.popFromQM(player, npc, ID.mob.FAFNIR)
        then
            player:confirmTrade()
        elseif
            npcUtil.tradeHasExactly(trade, xi.item.CUP_OF_SWEET_TEA) and
            npcUtil.popFromQM(player, npc, ID.mob.NIDHOGG)
        then
            player:confirmTrade()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

return entity
