-----------------------------------
-- Area: Windurst Woods
--  NPC: Selele
-- Type: Tutorial NPC
-- !pos 106.9 -5 -31.5 241
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.tutorial.onTrigger(player, npc, 988, 2)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.tutorial.onEventFinish(player, csid, option, 988, 2)
end

return entity
