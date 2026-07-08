-----------------------------------
-- Area: Zhayolm Remnants
-- NPC: Socket
-- Trade Salvage Cells to pop Poroggo Madame
-- Poroggo Madame drops 2x the Cells traded
-----------------------------------
local ID = zones[xi.zone.ZHAYOLM_REMNANTS]
-----------------------------------

---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.salvage.handleSocket(player, npc, trade, ID.mob.POROGGO_MADAME[2])
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SOCKET_TRIGGER)
end

return entity
