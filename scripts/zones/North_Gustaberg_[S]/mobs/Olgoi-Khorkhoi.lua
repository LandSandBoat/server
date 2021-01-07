-----------------------------------
-- Area: North Gustaberg [S]
--   NM: Olgoi-Khorkhoi
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 499)
end

return entity
