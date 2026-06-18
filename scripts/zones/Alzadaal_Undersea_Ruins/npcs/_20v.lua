-----------------------------------
-- Area: Alzadaal Undersea Ruins
-- Door: Gilded Gateway (Zhayolm)
-- !pos -580 0 -405 72
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.salvage.onTrigger(player, npc, xi.zone.ZHAYOLM_REMNANTS)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.salvage.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.instance.onEventFinish(player, csid, option, npc)
end

return entity
