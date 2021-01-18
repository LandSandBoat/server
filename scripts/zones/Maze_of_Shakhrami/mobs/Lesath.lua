-----------------------------------
-- Area: Maze of Shakhrami
--   NM: Lesath
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(tpz.mobMod.ADD_EFFECT, 1)
end

entity.onAdditionalEffect = function(mob, target, damage)
    return tpz.mob.onAddEffect(mob, target, damage, tpz.mob.ae.POISON, {power = 20})
end

entity.onMobDeath = function(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 294)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(3600, 10800)) -- 1 to 3 hours
end

return entity
