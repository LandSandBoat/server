-----------------------------------
-- Zone: Abyssea-LaTheine
--  NPC: qm6 (???)
-- Spawns Grandgousier
-- !pos -398 .010 -322 132
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    tpz.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.abyssea.qmOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
