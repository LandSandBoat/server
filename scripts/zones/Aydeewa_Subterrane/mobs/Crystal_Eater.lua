-----------------------------------
-- Area: Aydeewa Subterrane
--   NM: Crystal Eater
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 463)
end

return entity
