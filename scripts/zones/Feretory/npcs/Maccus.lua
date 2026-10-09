-----------------------------------
-- Area: Feretory (285)
--  NPC: Maccus
-- !pos -362.000 -3.112 -470.000 285
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.monstrosity.maccusOnTrigger(player, npc)
end

return entity
