-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm8 (???)
-- Spawns Xan
-- !pos 120 -39 -551 217
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
