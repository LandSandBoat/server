-----------------------------------
-- Area: Eastern Adoulin !zone 257
-- NPC: Inthius
-- Type: Weather Reporter
-- !pos -97.145 0.001 -36.710 257
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(4, 0, 0, 0, 0, 0, 0, 0, VanadielTime())
end

return entity
