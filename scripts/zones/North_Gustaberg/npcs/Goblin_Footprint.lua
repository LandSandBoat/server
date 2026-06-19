-----------------------------------
-- Universal Goblin Footprint NPC
-----------------------------------
require('modules/custom/lua/gobhook')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getVar('gobquest') == 1 then
        xi.mafia.gobhook(player, npc)
    end
end

return entity
