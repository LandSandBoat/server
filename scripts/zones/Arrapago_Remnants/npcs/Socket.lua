-----------------------------------
-- Area: Arrapago Remnants
--  NPC: Socket
-- Trade Salvage Cells to pop Vile Wahzil
-- Wahzil drops 2x the Cells traded
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.SOCKET_TRIGGER)
end

entity.onTrade = function(player, npc, trade)
    xi.salvage.handleSocket(player, npc, trade, ID.mob[2][3].wahzil)
end

return entity
