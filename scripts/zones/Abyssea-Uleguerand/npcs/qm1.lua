-----------------------------------
-- Zone: Abyssea-Uleguerand
--  NPC: qm1 (???)
-- Spawns Ironclad Triturator
-- !pos -10 -175 56 253
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
