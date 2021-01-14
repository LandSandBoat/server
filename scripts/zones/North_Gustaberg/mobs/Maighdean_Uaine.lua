-----------------------------------
-- Area: North Gustaberg
--   NM: Maighdean Uaine
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 198)
end

return entity
