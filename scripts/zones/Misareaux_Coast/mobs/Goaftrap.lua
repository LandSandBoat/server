-----------------------------------
-- Area: Misareaux Coast
--   NM: Goaftrap
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 444)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(5400, 7200)) -- 90 to 120 min
end

return entity
