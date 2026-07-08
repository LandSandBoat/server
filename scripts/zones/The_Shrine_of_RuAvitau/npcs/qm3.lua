-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  NPC: ??? (Spawns Ullikummi)
-- !pos 739 -99 -581 178
-----------------------------------
local ID = zones[xi.zone.THE_SHRINE_OF_RUAVITAU]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.CHUNK_OF_DIORITE) and
        npcUtil.popFromQM(player, npc, ID.mob.ULLIKUMMI)
    then
        -- Diorite
        player:confirmTrade()
    end
end

return entity
