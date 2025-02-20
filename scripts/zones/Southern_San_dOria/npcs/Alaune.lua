-----------------------------------
-- Area: Southern San d`Oria
--  NPC: Alaune
-- Type: Tutorial NPC
-- !pos -90 1 -56 230
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.tutorial.onTrigger(player, npc, 916, 0)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.tutorial.onEventFinish(player, csid, option, 916, 0)
end

return entity
