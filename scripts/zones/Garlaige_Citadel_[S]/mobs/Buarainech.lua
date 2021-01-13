-----------------------------------
-- Area: Garlaige Citadel [S]
--   NM: Buarainech
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 534)
end

return entity
