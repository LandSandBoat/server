-----------------------------------
-- Zone: Abyssea-Uleguerand
--  NPC: qm10 (???)
-- Spawns Audumbla
-- !pos 337 20 -277 253
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
