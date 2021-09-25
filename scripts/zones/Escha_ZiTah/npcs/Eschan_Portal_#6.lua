-----------------------------------
-- Area: Escha - Zi'Tah (288)
-- NPC: Eschan Portal #6
-- !pos 452 1.389 -343 288
-----------------------------------
require("scripts/globals/eschan_portals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.escha.echanPortalOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.escha.echanPortalEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.escha.echanPortalEventFinish(player, csid, option, npc)
end

return entity
