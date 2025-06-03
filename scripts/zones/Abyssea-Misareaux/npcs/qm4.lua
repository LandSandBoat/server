-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm4 (???)
-- Spawns Manohra
-- !pos 121 -8 -120 216
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
