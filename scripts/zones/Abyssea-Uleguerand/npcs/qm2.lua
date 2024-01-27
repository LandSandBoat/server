-----------------------------------
-- Zone: Abyssea-Uleguerand
--  NPC: qm2 (???)
-- Spawns Dhorme Khimaira
-- !pos -281.411 -155.568 267.682 253
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- xi.abyssea.qmOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
