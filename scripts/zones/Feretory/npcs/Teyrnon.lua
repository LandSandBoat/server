-----------------------------------
-- Area: Feretory (285)
--  NPC: Teyrnon
-- !pos -354.000 -3.112 -470.000 285
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.monstrosity.teyrnonOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.monstrosity.teyrnonOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.monstrosity.teyrnonOnEventFinish(player, csid, option, npc)
end

return entity
