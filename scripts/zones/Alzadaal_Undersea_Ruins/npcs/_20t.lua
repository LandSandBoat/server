-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Gilded Gateway (Silver Sea)
-- !pos 580 -2 442 72
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.salvage.onTrigger(player, npc, xi.zone.SILVER_SEA_REMNANTS)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.salvage.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.instance.onEventFinish(player, csid, option, npc)
end

return entity
