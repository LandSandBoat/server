-----------------------------------
-- Area: RoMaeve
--   NM: Nightmare Vase
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 327)
end

return entity
