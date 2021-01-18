-----------------------------------
-- Area: Batallia Downs [S]
--   NM: La Velue
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 491)
end

return entity
