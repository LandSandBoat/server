-----------------------------------
-- Area: Oldton Movalpolos
--   NM: Bugbear Strongman
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 244)
end

return entity
