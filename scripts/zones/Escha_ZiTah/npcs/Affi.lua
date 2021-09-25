-----------------------------------
-- Area: Escha - Zi'Tah (288)
-- NPC: Affi
-- !pos -357 0 110 288
-----------------------------------
local ID = require("scripts/zones/Escha_ZiTah/IDs")
require("scripts/globals/escha")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.escha.vendorOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.escha.vendorOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.escha.vendorOnUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.escha.vendorOnEventFinish(player, csid, option, npc)
end

return entity
