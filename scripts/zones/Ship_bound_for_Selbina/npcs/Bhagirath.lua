-----------------------------------
-- Area: Ship_bound_for_Selbina
--  NPC: Bhagirath
-- Notes: Tells ship ETA time
-- !pos 0.278 -14.707 -1.411 220
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.transport.onBoatTimekeeperTrigger(player, xi.transport.routes.SELBINA_MHAURA, ID.text.ON_WAY_TO_SELBINA, ID.text.ARRIVING_SOON_SELBINA)
end

return entity
