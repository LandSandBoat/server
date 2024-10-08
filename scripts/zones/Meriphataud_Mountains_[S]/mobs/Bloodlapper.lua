-----------------------------------
-- Area: Meriphataud Mountains [S]
--   NM: Bloodlapper
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 526)
end

return entity
