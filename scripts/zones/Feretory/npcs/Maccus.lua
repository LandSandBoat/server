-----------------------------------
-- Area: Feretory
--  NPC: Maccus
-- !pos TODO
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.monstrosity.maccusOnTrigger(player, npc)
end

return entity
