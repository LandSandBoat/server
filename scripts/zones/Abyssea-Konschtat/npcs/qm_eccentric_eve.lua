-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: qm_eccentric_eve (???)
-- Spawns Eccentric Eve
-- !pos 230.413 32.278 280.677 15
-----------------------------------
local ID = require('scripts/zones/Abyssea-Konschtat/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.ECCENTRIC_EVE_1, { xi.ki.FRAGRANT_TREANT_PETAL, xi.ki.FETID_RAFFLESIA_STALK, xi.ki.DECAYING_MORBOL_TOOTH, xi.ki.TURBID_SLIME_OIL, xi.ki.VENOMOUS_PEISTE_CLAW })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
