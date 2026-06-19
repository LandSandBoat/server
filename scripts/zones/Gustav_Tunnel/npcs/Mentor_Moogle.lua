-----------------------------------
-- Area: Gustav Tunnel
--  NPC: Mentor Moogle
-----------------------------------
require('modules/custom/lua/mentor')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.mentor.clickMoogle(player, npc)
    xi.mentor.openShop(player, npc)
end

return entity
