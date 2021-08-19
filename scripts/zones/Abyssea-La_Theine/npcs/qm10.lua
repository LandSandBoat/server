-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm10 (???)
-- Spawns Poroggo Dom Juan
-- !pos 405.785 26.404 -543.056 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, 17318443, { 2900 })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2900 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
