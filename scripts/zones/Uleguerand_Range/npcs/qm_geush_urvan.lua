-----------------------------------
-- Area: Uleguerand_Range
--  NPC: ??? (Spawns Geush Urvan)
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.HAUNTED_MULETA) and
        npcUtil.popFromQM(player, npc, ID.mob.GEUSH_URVAN)
    then
        player:confirmTrade()
    end
end

return entity
