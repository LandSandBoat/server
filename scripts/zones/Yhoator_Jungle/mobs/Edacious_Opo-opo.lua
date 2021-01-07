-----------------------------------
-- Area: Yhoator Jungle
--   NM: Edacious Opo-opo
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 366)
end

return entity
