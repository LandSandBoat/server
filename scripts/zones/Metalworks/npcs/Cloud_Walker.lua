-----------------------------------
-- Area: Metalworks (237)
--  NPC: Cloud Walker
-- !pos 89.047 -20.170 -12.089 237
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.wedding.onTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.wedding.onEventFinish(player, csid, option, npc)
end

return entity
