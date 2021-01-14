-----------------------------------
-- Area: North Gustaberg
--   NM: Stinging Sophie
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 197)
end

return entity
