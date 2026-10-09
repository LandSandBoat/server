-----------------------------------
-- Area: Feretory (285)
--  NPC: Aengus
-- !pos -350.000 -3.379 -466.000 285
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.monstrosity.aengusOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.aengusOnEventFinish(player, csid, option, npc)
end

return entity
