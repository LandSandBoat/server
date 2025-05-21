-----------------------------------
-- Area: Escha - Zi'Tah (288)
-- NPC: Eschan Portal #2
-- !pos -303 -0.028 309 288
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.escha.portals.eschanPortalOnTrigger(player, npc, 1)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventFinish(player, csid, option, npc)
end

return entity
