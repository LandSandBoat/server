-----------------------------------
-- Area: Mamook
--   NM: Firedance Magmaal Ja
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 461)
end

return entity
