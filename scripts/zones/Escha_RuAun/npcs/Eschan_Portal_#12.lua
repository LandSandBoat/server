-----------------------------------
-- Area: Escha - Ru'Aun (289)
-- NPC: Eschan Portal #12
-- !pos 455.5 -3.599 -147.5 289
-----------------------------------
require("scripts/globals/teleports/eschan_portals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.escha.portals.eschanPortalOnTrigger(player, npc, 19)
end

entity.onEventUpdate = function(player, csid, option)
    xi.escha.portals.eschanPortalEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventFinish(player, csid, option, npc)
end

return entity
