-----------------------------------
-- Zone: Abyssea-Altepa
--  NPC: qm_vadleany (???)
-- Spawns Vadleany
-- !pos -56 1 123 218
-----------------------------------
local ID = require('scripts/zones/Abyssea-Altepa/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.VADLEANY, { xi.items.LADYBIRD_LEAF })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.LADYBIRD_LEAF })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
