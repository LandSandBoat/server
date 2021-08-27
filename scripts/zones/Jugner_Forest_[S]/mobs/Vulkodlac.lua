-----------------------------------
-- Area: Jugner Forest [S]
--   NM: Vulkodlac
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 485)
end

return entity
