-----------------------------------
-- Area: Lower Jeuno
--  NPC: Goldagrik
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.mmm.tutorialOnTrigger(player)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.mmm.tutorialOnEventFinish(player, csid, option)
end

return entity
