-----------------------------------
-- Area: Heavens Tower
--  NPC: Matrimonial Coffer
-- !pos -5.955 0.249 24.360 242
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.matrimonialcoffer.startEvent(player)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.matrimonialcoffer.finishEvent(player, csid, option, npc)
end

return entity
