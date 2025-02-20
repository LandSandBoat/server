-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm7 (???)
-- Spawns Seps
-- !pos -238 -39 -717 217
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
