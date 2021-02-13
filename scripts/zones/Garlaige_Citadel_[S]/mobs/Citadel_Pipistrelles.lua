-----------------------------------
-- Area: Garlaige Citadel [S]
--   NM: Citadel Pipistrelles
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 533)
end

return entity
