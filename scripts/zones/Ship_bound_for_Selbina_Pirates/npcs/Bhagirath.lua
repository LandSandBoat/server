-----------------------------------
-- Area: Ship_bound_for_Selbina Pirates
--  NPC: Bhagirath
-- Notes: Tells ship ETA time
-- !pos 0.278 -14.707 -1.411 220
-----------------------------------
local ID = zones[xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.transport.onBoatTimekeeperTrigger(player, xi.transport.routes.SELBINA_MHAURA, ID.text.ON_WAY_TO_SELBINA, ID.text.ARRIVING_SOON_SELBINA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
