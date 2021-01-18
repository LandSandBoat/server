-----------------------------------
-- Area: Den of Rancor
--   NM: Friar Rush
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 394)
end

return entity
