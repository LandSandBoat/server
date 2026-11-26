-----------------------------------
-- Area: Heavens Tower (242)
--  NPC: Pompi-Rompi
-- !pos -6.719 0.249 24.768 242
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
