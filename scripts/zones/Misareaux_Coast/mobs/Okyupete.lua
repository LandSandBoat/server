-----------------------------------
-- Area: Misareaux Coast
--   NM: Okyupete
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 446)
end

return entity
