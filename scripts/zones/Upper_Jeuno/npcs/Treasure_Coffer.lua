-----------------------------------
-- Area: Upper Jeuno
--  NPC: Treasure Coffer
-- Goblin Mafia NPC
-----------------------------------
require('modules/custom/lua/gobhook')
-----------------------------------

local entity = {}

entity.onTrigger = function(player, npc)
    xi.mafia.gobhook2(player, npc)
end

return entity
