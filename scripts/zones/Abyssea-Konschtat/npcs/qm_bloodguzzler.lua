-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_bloodguzzler (???)
-- Spawns Bloodguzzler
-- !pos -155.000 64.117 590.000 15
-----------------------------------
local ID = require('scripts/zones/Abyssea-Konschtat/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BLOODGUZZLER, { xi.items.VIAL_OF_EFT_BLOOD })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.VIAL_OF_EFT_BLOOD })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
