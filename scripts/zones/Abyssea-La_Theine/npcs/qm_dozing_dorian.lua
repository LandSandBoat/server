-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm_dozing_dorian (???)
-- Spawns Dozing Dorian
-- !pos 703 40 283 132
-----------------------------------
local ID = require('scripts/zones/Abyssea-La_Theine/IDs')
require('scripts/globals/abyssea')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.DOZING_DORIAN, { xi.items.DRIED_CHIGOE })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.DRIED_CHIGOE })
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
