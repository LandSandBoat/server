-----------------------------------
-- Area: Halvung
--   NM: Big Bomb
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 466)
end

return entity
