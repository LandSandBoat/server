-----------------------------------
-- Area: Ship_bound_for_Mhaura
--  NPC: Sahn
-- Notes: Tells ship ETA time
-- !pos 0.278 -14.707 -1.411 221
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_MHAURA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.transport.onBoatTimekeeperTrigger(player, xi.transport.routes.SELBINA_MHAURA, ID.text.ON_WAY_TO_MHAURA, ID.text.ARRIVING_SOON_MHAURA)
end

return entity
