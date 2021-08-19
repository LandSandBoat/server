-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm2 (???)
-- Spawns Trudging Thomas
-- !pos 278 24 -82 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade, 17318435, { 2892 })
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc, 0, 0, { 2892 })
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
