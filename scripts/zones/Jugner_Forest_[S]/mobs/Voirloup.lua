-----------------------------------
-- Area: Jugner Forest [S]
--   NM: Voirloup
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 486)
end

return entity
