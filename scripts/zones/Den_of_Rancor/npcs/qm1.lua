-----------------------------------
-- Area: Den of Rancor
--  NPC: ??? - HakuTaku spawn
-- !pos 24 25 -306 160
-----------------------------------
local ID = zones[xi.zone.DEN_OF_RANCOR]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.HAKUTAKU_EYE_CLUSTER) and
        npcUtil.popFromQM(player, npc, ID.mob.HAKUTAKU)
    then
        player:confirmTrade()
    end
end

return entity
