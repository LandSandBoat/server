-----------------------------------
-- Area: Open_sea_route_to_Mhaura
--  NPC: Sheadon
-- Notes: Tells ship ETA time
-- !pos 0.340 -12.232 -4.120 47
-----------------------------------
local ID = zones[xi.zone.OPEN_SEA_ROUTE_TO_MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.transport.onBoatTimekeeperTrigger(player, xi.transport.routes.OPEN_SEA, ID.text.ON_WAY_TO_MHAURA, ID.text.ARRIVING_SOON_MHAURA)
end

return entity
