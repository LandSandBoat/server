-----------------------------------
-- Area: Beaucedine Glacier [S]
--   NM: Becut
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 537)
end

return entity
