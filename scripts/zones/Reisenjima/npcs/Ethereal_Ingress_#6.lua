-----------------------------------
-- Area: Reisenjima (291)
-- NPC: Ethereal Ingress #6
-- !pos 242.5 -87.4 106 291
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.escha.portals.eschanPortalOnTrigger(player, npc, 28)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventFinish(player, csid, option, npc)
end

return entity
