-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_briareus (???)
-- Spawns Briareus
-- !pos -179 7 259 132
-----------------------------------
local ID = require('scripts/zones/Abyssea-La_Theine/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.BRIAREUS_1, { xi.ki.DENTED_GIGAS_SHIELD, xi.ki.WARPED_GIGAS_ARMBAND, xi.ki.SEVERED_GIGAS_COLLAR })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
