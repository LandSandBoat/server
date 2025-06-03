-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: ??? (Spawns Pallas)
-- !pos -302.000 -159.000 21.000 158
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.HOARY_BATTLE_HORN) and
        npcUtil.popFromQM(player, npc, ID.mob.PALLAS)
    then
        player:confirmTrade()
    end
end

return entity
