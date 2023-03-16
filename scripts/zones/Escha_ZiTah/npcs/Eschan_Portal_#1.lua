-----------------------------------
-- Area: Escha - Zi'Tah (288)
-- NPC: Eschan Portal #1
-- !pos -344.275 1.659 -182.613 288
-----------------------------------
require("scripts/globals/teleports/eschan_portals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.escha.portals.eschanPortalOnTrigger(player, npc, 0)
end

entity.onEventUpdate = function(player, csid, option)
    xi.escha.portals.eschanPortalEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.escha.portals.eschanPortalEventFinish(player, csid, option, npc)
end

return entity
