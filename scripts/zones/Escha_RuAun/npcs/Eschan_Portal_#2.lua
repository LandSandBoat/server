-----------------------------------
-- Area: Escha - Ru'Aun (289)
-- NPC: Eschan Portal #2
-- !pos -274.5 -40.5 -377.5 289
-----------------------------------
require("scripts/globals/teleports/eschan_portals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.escha.portals.eschanPortalOnTrigger(player, npc, 9)
end

entity.onEventUpdate = function(player, csid, option)
    xi.escha.portals.eschanPortalEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventFinish(player, csid, option, npc)
end

return entity
