-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm2 (???)
-- Spawns Quasimodo
-- !pos -278 -40 -367 217
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
