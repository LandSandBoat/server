-----------------------------------
-- Area: Reisenjima (291)
-- NPC: Ethereal Ingress #1
-- !pos -494.44 -19 -476.48 291
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.escha.portals.eschanPortalOnTrigger(player, npc, 23)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventFinish(player, csid, option, npc)
end

return entity
