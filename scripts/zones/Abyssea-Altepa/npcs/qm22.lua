-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm22 (???)
-- Spawns Bennu
-- !pos -221 0.950 -320 218
-----------------------------------
local ID = require('scripts/zones/Abyssea-Altepa/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/keyitems')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, ID.mob.BENNU_2, { xi.ki.RESPLENDENT_ROC_QUILL })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
