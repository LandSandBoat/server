-----------------------------------
-- Area: Qufim Island
--  Mob: Atkorkamuy
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 310)
end

return entity
