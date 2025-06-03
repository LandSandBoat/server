-----------------------------------
-- Area: Escha - Zi'Tah (288)
-- NPC: Eschan Portal #4
-- !pos -110 0.119 -242 288
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.escha.portals.eschanPortalOnTrigger(player, npc, 3)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventFinish(player, csid, option, npc)
end

return entity
