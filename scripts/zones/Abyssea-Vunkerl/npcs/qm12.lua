-----------------------------------
-- Zone: Abyssea-Vunkerl
--  NPC: qm12 (???)
-- Spawns Gnawtooth Gary
-- !pos -343 -39 -644 217
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
