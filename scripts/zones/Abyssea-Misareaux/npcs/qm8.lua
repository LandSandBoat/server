-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm8 (???)
-- Spawns Avalerion
-- !pos 41 -16 81 216
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
