-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm6 (???)
-- Spawns Rakshas
-- !pos -203 -39 -26 217
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
