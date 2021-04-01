-----------------------------------
-- Area: Temple of Uggalepih
--   NM: Sacrificial Goblet
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 391)
end

return entity
