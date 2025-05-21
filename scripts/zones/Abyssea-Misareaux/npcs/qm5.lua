-----------------------------------
-- Zone: Abyssea-Misareaux
--  NPC: qm5 (???)
-- Spawns Cep-Kamuy
-- !pos -160 -15 638 216
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
