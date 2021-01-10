-----------------------------------
-- Area: Davoi
--   NM: Blubbery Bulge
-- Involved in Quest: The Miraculous Dale
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 196)
end

return entity
