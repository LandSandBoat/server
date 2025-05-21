-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm11 (???)
-- Spawns Tuskertrap
-- !pos -22 -23 656 216
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
