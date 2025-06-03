-----------------------------------
-- Zone: Abyssea-Uleguerand
--  NPC: qm7 (???)
-- Spawns Veri Selen
-- !pos 13 -140 470 253
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
