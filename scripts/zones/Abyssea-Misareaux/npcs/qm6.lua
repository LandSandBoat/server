-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm6 (???)
-- Spawns Ironclad Observer
-- !pos -198.742 -32.162 77.431 216
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
