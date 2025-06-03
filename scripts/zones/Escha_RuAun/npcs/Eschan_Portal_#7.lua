-----------------------------------
-- Area: Escha - Ru'Aun (289)
-- NPC: Eschan Portal #7
-- !pos -430.5 -71.849 334.5 289
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.escha.portals.eschanPortalOnTrigger(player, npc, 14)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventFinish(player, csid, option, npc)
end

return entity
