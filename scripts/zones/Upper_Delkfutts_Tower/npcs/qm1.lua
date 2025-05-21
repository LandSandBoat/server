-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: ??? (Spawns Alkyoneus)
-- !pos -300 -175 22 158
-----------------------------------
local ID = zones[xi.zone.UPPER_DELKFUTTS_TOWER]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.MOLDY_BUCKLER) and
        npcUtil.popFromQM(player, npc, ID.mob.ALKYONEUS)
    then
        player:confirmTrade()
    end
end

return entity
