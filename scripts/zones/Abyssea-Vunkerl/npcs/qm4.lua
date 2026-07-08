-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm4 (???)
-- Spawns Dvalinn
-- !pos -634 -48 -476 217
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
