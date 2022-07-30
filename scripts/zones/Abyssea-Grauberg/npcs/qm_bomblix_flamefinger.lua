-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm_bomblix_flamefinger (???)
-- Spawns Bomblix Flamefinger
-- !pos 555 23 -317 254
-----------------------------------
local ID = require('scripts/zones/Abyssea-Grauberg/IDs')
require('scripts/globals/abyssea')
require('scripts/globals/items')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, ID.mob.BOMBLIX_FLAMEFINGER, { xi.items.JAR_OF_GOBLIN_GUNPOWDER, xi.items.JAR_OF_GOBLIN_OIL })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { xi.items.JAR_OF_GOBLIN_GUNPOWDER, xi.items.JAR_OF_GOBLIN_OIL })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
