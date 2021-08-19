-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm20 (???)
-- Spawns Carabosse
-- !pos 26 19 148 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 17318460, { xi.ki.PELLUCID_FLY_EYE, xi.ki.SHIMMERING_PIXIE_PINION })
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
