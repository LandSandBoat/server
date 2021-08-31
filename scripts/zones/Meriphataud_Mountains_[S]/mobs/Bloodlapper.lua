-----------------------------------
-- Area: Meriphataud Mountains [S]
--   NM: Bloodlapper
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 526)
end

return entity
