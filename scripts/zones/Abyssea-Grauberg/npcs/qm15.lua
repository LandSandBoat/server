-----------------------------------
-- Zone: Abyssea-Grauberg
--  NPC: qm15 (???)
-- Spawns Raja
-- !pos 495 56 679 254
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
