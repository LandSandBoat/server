-----------------------------------
-- Area: Northern San d'Oria (231)
--  NPC: Suspicious Elvaan
-- !pos 82.217 -0.199 42.682 231
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.monstrosity.gladiatorOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.gladiatorOnEventFinish(player, csid, option, npc)
end

return entity
