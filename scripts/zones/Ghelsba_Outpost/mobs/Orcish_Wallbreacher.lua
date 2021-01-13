----------------------------------------
-- Area: Ghelsba Outpost (140)
--  Mob: Orcish Wallbreacher
----------------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 169)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(3900, 5400)) -- 65 to 90 min
end

return entity
