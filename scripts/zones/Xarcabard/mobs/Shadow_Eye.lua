-----------------------------------
-- Area: Xarcabard
--  Mob: Shadow Eye
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 315)
end

return entity
