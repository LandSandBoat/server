-----------------------------------
-- Area: Feretory
--  NPC: Aengus
-- !pos TODO
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
