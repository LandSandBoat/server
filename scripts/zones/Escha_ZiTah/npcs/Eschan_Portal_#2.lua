-----------------------------------
-- Area: Escha - Zi'Tah (288)
-- NPC: Eschan Portal #2
-- !pos -303 -0.028 309 288
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
