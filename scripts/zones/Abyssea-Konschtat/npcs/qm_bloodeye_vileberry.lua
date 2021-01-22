-----------------------------------
-- Zone: Abyssea-Konschtat
--  NPC: ???
-- Spawns Bloodeye Vileberry
-- !pos 554.000 24.198 714.000 15
-- !pos 539.000 24.198 714.000 15
-- !pos 554.000 23.098 699.000 15
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
