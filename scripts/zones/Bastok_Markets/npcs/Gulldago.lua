-----------------------------------
-- Area: Bastok Markets
--  NPC: Gulldago
-- Type: Tutorial NPC
-- !pos -364.121 -11.034 -167.456 235
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.tutorial.onTrigger(player, npc, 697, 1)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.tutorial.onEventFinish(player, csid, option, 697, 1)
end

return entity
