-----------------------------------
-- Area: Uleguerand Range
--   NM: Frost Flambeau
-----------------------------------
require("scripts/globals/hunts")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.MAGIC_COOL, 15)
    mob:setMod(tpz.mod.UFASTCAST, 50)
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 320)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(7200, 9000)) -- 2 to 2.5 hours
end

return entity
