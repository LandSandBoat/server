-----------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Scylla
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 539)
end

return entity
