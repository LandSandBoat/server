-----------------------------------
-- Area: West Sarutabaruta [S]
--   NM: Jeduah
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 517)
end

return entity
