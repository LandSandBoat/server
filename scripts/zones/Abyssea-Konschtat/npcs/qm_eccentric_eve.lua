-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: ???
-- Spawns Eccentric Eve
-- !pos 230.413 32.278 280.677 15
-- !pos 215.413 32.778 280.677 15
-- !pos 245.413 31.778 280.677 15
-----------------------------------
require("scripts/globals/abyssea")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.abyssea.qmOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    xi.abyssea.qmOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.abyssea.qmOnEventFinish(player, csid, option)
end

return entity
