-----------------------------------
-- Area: Labyrinth of Onzozo
--   NM: Narasimha
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 299)
end

return entity
