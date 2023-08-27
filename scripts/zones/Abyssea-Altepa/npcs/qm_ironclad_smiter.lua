-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_ironclad_smiter (???)
-- Spawns Ironclad Smiter
-- !pos -744 -17 -696 218
-----------------------------------
local ID = require('scripts/zones/Abyssea-Altepa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.IRONCLAD_SMITER, { xi.items.VIAL_OF_TABLILLA_MERCURY, xi.items.SMOLDERING_ARM })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.VIAL_OF_TABLILLA_MERCURY, xi.items.SMOLDERING_ARM })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
