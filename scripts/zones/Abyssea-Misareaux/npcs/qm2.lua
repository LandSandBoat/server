-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm2 (???)
-- Spawns Sirrush
-- !pos 346 15 -437 216
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- xi.abyssea.qmOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- xi.abyssea.qmOnTrigger(player, npc)
end

return entity
