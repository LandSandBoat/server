-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm13 (???)
-- Spawns Cirein-Croin
-- !pos 39.146 -15.500 519.988 216
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
    tpz.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
